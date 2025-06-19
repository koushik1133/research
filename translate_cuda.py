import os
import json
import tempfile
import subprocess
import platform
from multiprocessing import Pool, cpu_count
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch
import re

# ----- CONFIG -----
MODELS = [
    "Qwen/Qwen3-0.6B",
    "google/gemma-3-1b-it",
    "hpcgroup/hpc-coder-v2-1.3b",
    "nvidia/Llama-3.1-Nemotron-Nano-4B-v1.1"
]
INPUT_FOLDER = "input_codes"
OUTPUT_BASE_DIR = "output_cuda"
NUM_C_FILES = 0
NUM_CPP_FILES = 12
os.environ["TOKENIZERS_PARALLELISM"] = "false"  # Fix parallelism warning

# ----- LOAD MODEL -----
def load_model(model_path):
    print(f"🚀 Loading model: {model_path}...")
    try:
        tokenizer = AutoTokenizer.from_pretrained(model_path, trust_remote_code=True)
        model = AutoModelForCausalLM.from_pretrained(
            model_path,
            torch_dtype=torch.float16,
            device_map="mps" if torch.backends.mps.is_available() else "cpu",
            trust_remote_code=True
        )
        print(f"✅ Model {model_path} loaded successfully")
        return tokenizer, model
    except Exception as e:
        print(f"❌ Error loading model {model_path}: {e}")
        return None, None

# ----- LOAD FILES -----
def load_code_files(folder_path, num_c=NUM_C_FILES, num_cpp=NUM_CPP_FILES):
    print(f"📂 Loading files from: {folder_path}")
    if not os.path.exists(folder_path):
        print(f"❌ Folder {folder_path} does not exist.")
        return []
    code_examples = []
    seen_content = set()
    c_count, cpp_count = 0, 0
    try:
        for filename in sorted(os.listdir(folder_path)):
            if not filename.endswith((".c", ".cpp")):
                continue
            full_path = os.path.join(folder_path, filename)
            try:
                with open(full_path, "r") as f:
                    code = f.read().strip()
                    if code not in seen_content:
                        if filename.endswith(".c") and c_count < num_c:
                            code_examples.append({"id": filename, "c_code": code})
                            seen_content.add(code)
                            c_count += 1
                        elif filename.endswith(".cpp") and cpp_count < num_cpp:
                            code_examples.append({"id": filename, "c_code": code})
                            seen_content.add(code)
                            cpp_count += 1
            except Exception as e:
                print(f"⚠️ Error reading {filename}: {e}")
            if c_count >= num_c and cpp_count >= num_cpp:
                break
        if len(code_examples) < (num_c + num_cpp):
            print(f"⚠️ Found only {len(code_examples)} unique files, expected {num_c + num_cpp}")
        return code_examples
    except Exception as e:
        print(f"❌ Error accessing {folder_path}: {e}")
        return []

# ----- CLEAN OUTPUT -----
def clean_translated_code(raw_output):
    blocks = re.findall(r"```[a-zA-Z0-9]*\n(.*?)```", raw_output, re.DOTALL)
    if blocks:
        return blocks[0].strip()
    return raw_output.replace("```", "").strip()

# ----- VALIDATE CUDA CODE -----
def is_valid_cuda_code(code):
    if not code.strip():
        return False
    invalid_patterns = [
        r"__global__\s+int\s+main",  # __global__ main is invalid
        r"__global__\s+[^void]\s+\w+\s*\(",  # Non-void __global__ functions
        r"__local\s",  # Incorrect __local usage
        r"\[\d+\]\s*;",  # Suspicious array declarations
    ]
    required_patterns = [
        r"cudaMalloc",  # Must allocate GPU memory
        r"cudaMemcpy",  # Must transfer data
        r"<<<[^>]+>>>",  # Must launch kernel
        r"__global__\s+void\s+\w+\s*\("  # At least one kernel
    ]
    for pattern in invalid_patterns:
        if re.search(pattern, code):
            return False
    required_count = sum(1 for pattern in required_patterns if re.search(pattern, code))
    return required_count >= 3  # Require at least 3/4 CUDA constructs

# ----- PROMPT -----
def create_translation_prompt(c_code, is_cpp=True):
    lang = "C++" if is_cpp else "C"
    return (
        f"You are an expert in CUDA programming. Translate the following {lang} code into valid CUDA code for GPU execution. "
        "For sorting algorithms (e.g., bubble sort), implement a parallel version (e.g., odd-even transposition sort) using `__global__` kernels (must return `void`) with thread synchronization (`__syncthreads`). "
        "Allocate GPU memory with `cudaMalloc`, transfer data with `cudaMemcpy`, and launch kernels with `<<<1, N>>>` where N is the array size. "
        "Replace `std::cin`/`std::cout` with `scanf`/`printf`. "
        "The `main` function should remain on the host (CPU), handle input/output, and free GPU memory with `cudaFree`. "
        "Include `#include <cuda_runtime.h>` and `#include <stdio.h>`. "
        "For array operations, ensure indices stay within bounds. "
        "Return only the CUDA `.cu` code, no markdown or explanations.\n\n"
        f"{c_code}\n\nCUDA code:"
    )

def translate_c_to_cuda(c_code, tokenizer, model, is_cpp=True, max_tokens=1024):
    if not tokenizer or not model:
        return ""
    prompt = create_translation_prompt(c_code, is_cpp)
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    try:
        outputs = model.generate(
            **inputs,
            max_new_tokens=max_tokens,
            temperature=0.7,
            top_p=0.9,
            do_sample=False,
            pad_token_id=tokenizer.eos_token_id
        )
        full_output = tokenizer.decode(outputs[0], skip_special_tokens=True)
        cuda_code = clean_translated_code(full_output[len(prompt):].strip())
        if not is_valid_cuda_code(cuda_code):
            print(f"⚠️ Invalid CUDA code for {is_cpp and 'C++' or 'C'} input; skipping.")
            return ""
        return cuda_code
    except Exception as e:
        print(f"❌ Translation error: {e}")
        return ""

# ----- SAVE INDIVIDUAL FILES -----
def save_translated_cuda_files(examples, model_name, output_dir=OUTPUT_BASE_DIR):
    model_dir = os.path.join(output_dir, model_name.replace("/", "_"))
    os.makedirs(model_dir, exist_ok=True)
    seen_translations = set()
    for ex in examples:
        cuda_code = ex["translated_code"]
        if cuda_code and cuda_code not in seen_translations:
            safe_id = os.path.splitext(ex["id"])[0]
            filename = os.path.join(model_dir, f"{safe_id}.cu")
            with open(filename, "w") as f:
                f.write(cuda_code)
            seen_translations.add(cuda_code)
        else:
            print(f"⚠️ Skipping invalid or duplicate translation for {ex['id']}")

# ----- COMPILE & RUN -----
def write_cuda_file(code: str, file_id: int, dir_path: str):
    filename = os.path.join(dir_path, f"program_{file_id}.cu")
    with open(filename, "w") as f:
        f.write(code)
    return filename

def compile_cuda_file(cuda_file_path: str):
    exe_path = cuda_file_path.replace(".cu", "")
    try:
        result = subprocess.run(
            ["nvcc", cuda_file_path, "-o", exe_path],
            capture_output=True,
            text=True,
            timeout=10
        )
        return {
            "source": cuda_file_path,
            "executable": exe_path,
            "compile_stdout": result.stdout.strip(),
            "compile_stderr": result.stderr.strip(),
            "compile_success": result.returncode == 0
        }
    except subprocess.TimeoutExpired:
        return {
            "source": cuda_file_path,
            "executable": None,
            "compile_stdout": "",
            "compile_stderr": "Timeout",
            "compile_success": False
        }
    except FileNotFoundError:
        return {
            "source": cuda_file_path,
            "executable": None,
            "compile_stdout": "",
            "compile_stderr": "nvcc not found",
            "compile_success": False
        }

def run_executable(exe_path: str):
    try:
        result = subprocess.run(
            [exe_path],
            capture_output=True,
            text=True,
            timeout=5
        )
        return {
            "run_stdout": result.stdout.strip(),
            "run_stderr": result.stderr.strip(),
            "run_success": result.returncode == 0
        }
    except subprocess.TimeoutExpired:
        return {
            "run_stdout": "",
            "run_stderr": "Timeout",
            "run_success": False
        }
    except FileNotFoundError:
        return {
            "run_stdout": "",
            "run_stderr": "Executable not found",
            "run_success": False
        }

def process_example(args):
    ex, idx, dir_path = args
    code = ex["translated_code"]
    cuda_path = write_cuda_file(code, idx, dir_path)
    result = {
        "id": ex["id"],
        "original_c": ex["c_code"],
        "translated_code": code,
        "compile_success": False,
        "run_success": False,
        "compile_stderr": "Compilation skipped on macOS",
        "run_stderr": "Execution skipped on macOS"
    }

    if platform.system() != "Darwin":  # Skip compilation/run on macOS
        compile_result = compile_cuda_file(cuda_path)
        result.update(compile_result)
        if compile_result["compile_success"]:
            print(f"✅ Compiled: {ex['id']}")
            run_result = run_executable(compile_result["executable"])
            if run_result["run_success"]:
                print(f"🏃 Ran: {ex['id']} → Output:\n{run_result['run_stdout'][:200]}")
            else:
                print(f"🛑 Run failed for: {ex['id']}")
            result.update(run_result)
        else:
            print(f"❌ Compilation failed: {ex['id']}")
            print("---- stderr ----")
            print(compile_result["compile_stderr"][:300])
    return result

# ----- MAIN -----
if __name__ == "__main__":
    code_examples = load_code_files(INPUT_FOLDER)
    if not code_examples:
        print("❌ No valid files found. Exiting.")
        exit(1)

    all_results = {}
    for model_path in MODELS:
        tokenizer, model = load_model(model_path)
        if not tokenizer or not model:
            continue

        model_safe_name = model_path.replace("/", "_")
        print(f"🔄 Translating for {model_path}...")
        translated_examples = []
        for i, ex in enumerate(code_examples):
            is_cpp = ex["id"].endswith(".cpp")
            print(f"🔹 Translating: {ex['id']} ({'C++' if is_cpp else 'C'})")
            cuda_code = translate_c_to_cuda(ex["c_code"], tokenizer, model, is_cpp)
            print("🔸 Preview:\n" + "\n".join((cuda_code or "Translation failed").splitlines()[:5]) + "\n...")
            translated_examples.append({
                "id": ex["id"],
                "c_code": ex["c_code"],
                "translated_code": cuda_code
            })

        print(f"📁 Saving to '{os.path.join(OUTPUT_BASE_DIR, model_safe_name)}'")
        save_translated_cuda_files(translated_examples, model_path)

        print("⚙️ Processing translations...")
        with tempfile.TemporaryDirectory() as tmpdir:
            args = [(ex, i, tmpdir) for i, ex in enumerate(translated_examples)]
            with Pool(processes=max(1, cpu_count() - 1)) as pool:
                model_results = pool.map(process_example, args)

        all_results[model_path] = model_results

    json_file = "translation_results.json"
    print(f"💾 Saving to '{json_file}'")
    with open(json_file, "w") as f:
        json.dump(all_results, f, indent=2)

    error_file = "compile_and_run_errors.txt"
    print(f"📝 Errors to '{error_file}'")
    with open(error_file, "w") as f:
        for model_path, results in all_results.items():
            for result in results:
                if not result.get("compile_success", True):
                    f.write(f"❌ Compilation failed: {result['id']} (Model: {model_path})\n")
                    f.write("---- Compile stderr ----\n")
                    f.write(result["compile_stderr"] + "\n\n")
                elif not result.get("run_success", True):
                    f.write(f"🛑 Execution failed: {result['id']} (Model: {model_path})\n")
                    f.write("---- Run stderr ----\n")
                    f.write(result["run_stderr"] + "\n\n")

    print(f"✅ Done. Files in 'output_cuda/'.")