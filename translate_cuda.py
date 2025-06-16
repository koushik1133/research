import os
import json
import re
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch

# ----- CONFIG -----
MODELS = ["codellama/CodeLlama-7b-Instruct-hf"]
INPUT_FOLDER = "input_codes"
NUM_CPP_FILES = 1
NUM_C_FILES = 0

# ----- LOAD MODEL -----
def load_model(model_path):
    try:
        tokenizer = AutoTokenizer.from_pretrained(model_path, trust_remote_code=True)
        model = AutoModelForCausalLM.from_pretrained(
            model_path,
            torch_dtype=torch.float16,
            device_map="auto",
            trust_remote_code=True
        )
        return tokenizer, model
    except Exception as e:
        print(f"Error loading model {model_path}: {e}")
        return None, None

# ----- LOAD FILES -----
def load_code_files(folder_path, num_cpp=5, num_c=5):
    cpp_files, c_files = [], []
    for filename in sorted(os.listdir(folder_path)):
        full_path = os.path.join(folder_path, filename)
        with open(full_path, "r") as f:
            code = f.read()
            entry = {"id": filename, "c_code": code}
            if filename.endswith(".cpp") and len(cpp_files) < num_cpp:
                cpp_files.append(entry)
            elif filename.endswith(".c") and len(c_files) < num_c:
                c_files.append(entry)
        if len(cpp_files) >= num_cpp and len(c_files) >= num_c:
            break
    return cpp_files + c_files

# ----- CLEAN OUTPUT -----
def clean_translated_code(raw_output):
    blocks = re.findall(r"```[a-zA-Z0-9]*\n(.*?)```", raw_output, re.DOTALL)
    if blocks:
        return blocks[0].strip()
    return raw_output.replace("```", "").strip()

# ----- PROMPT -----
def create_translation_prompt(c_code, is_cpp=True):
    lang = "C++" if is_cpp else "C"
    return (
        f"You are a helpful assistant. Translate the following {lang} code into valid CUDA. "
        "Return only CUDA `.cu` code, no markdown or explanations.\n\n"
        f"{c_code}\n\nCUDA code:"
    )

def translate_to_cuda(c_code, tokenizer, model, is_cpp=True, max_tokens=512):
    if not tokenizer or not model:
        return ""
    prompt = create_translation_prompt(c_code, is_cpp)
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    outputs = model.generate(
        **inputs,
        max_new_tokens=max_tokens,
        temperature=0.7,
        top_p=0.9,
        do_sample=False,
        pad_token_id=tokenizer.eos_token_id
    )
    full_output = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return clean_translated_code(full_output[len(prompt):].strip())

# ----- SAVE INDIVIDUAL FILES -----
def save_translated_cuda_files(examples, model_name, output_dir="output_cuda"):
    model_dir = os.path.join(output_dir, model_name.replace("/", "_"))
    os.makedirs(model_dir, exist_ok=True)
    for ex in examples:
        safe_id = os.path.splitext(ex["id"])[0]
        filename = os.path.join(model_dir, f"{safe_id}.cu")
        with open(filename, "w") as f:
            f.write(ex["translated_code"])

# ----- MAIN -----
if __name__ == "__main__":
    print(f"📂 Loading C/C++ files from: {INPUT_FOLDER}")
    code_examples = load_code_files(INPUT_FOLDER, NUM_CPP_FILES, NUM_C_FILES)
    if len(code_examples) < (NUM_CPP_FILES + NUM_C_FILES):
        print(f"⚠️ Warning: Found only {len(code_examples)} files, expected {NUM_CPP_FILES + NUM_C_FILES}")
        exit(1)

    all_results = []
    for model_path in MODELS:
        print(f"🚀 Loading model: {model_path}")
        tokenizer, model = load_model(model_path)
        if not tokenizer or not model:
            print(f"⚠️ Skipping model {model_path} due to load failure")
            continue

        print(f"🔁 Translating C/C++ code to CUDA for {model_path}...")
        translated_examples = []
        for i, ex in enumerate(code_examples):
            is_cpp = ex["id"].endswith(".cpp")
            print(f"🔹 Translating file: {ex['id']} ({'C++' if is_cpp else 'C'})")
            cuda_code = translate_to_cuda(ex["c_code"], tokenizer, model, is_cpp)
            print("🔸 CUDA preview:\n" + "\n".join(cuda_code.splitlines()[:5]) + "\n...")
            translated_examples.append({
                "id": ex["id"],
                "c_code": ex["c_code"],
                "translated_code": cuda_code
            })

        print(f"📁 Saving CUDA files for {model_path}")
        save_translated_cuda_files(translated_examples, model_path)

        all_results.extend([{
            "model": model_path,
            "id": ex["id"],
            "original_c": ex["c_code"],
            "translated_code": ex["translated_code"]
        } for ex in translated_examples])

    json_file = "translation_results.json"
    print(f"💾 Saving output to '{json_file}'")
    with open(json_file, "w") as f:
        json.dump(all_results, f, indent=2)

    print("✅ Done. CUDA files saved in 'output_cuda/'. Compilation skipped on macOS.")