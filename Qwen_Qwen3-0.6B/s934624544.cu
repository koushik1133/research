#include <cuda_runtime.h>
#include <stdio.h>
__global__ void odd_even_transpose(int *a, int *b, int N){
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int idx = i + j * N + k * N;
  if (idx < N) {
    a[idx] = b[idx];
  } else {
    a[idx] = a[idx - N];
  }
}

int main() {
  int N = 9;
  int *a = (int*)malloc(N * sizeof(int));
  int *b = (int*)malloc(N * sizeof(int));
  cudaMalloc(&a, N * sizeof(int));
  cudaMalloc(&b, N * sizeof(int));
  cudaMemcpy(a, &i, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(b, &j, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(a, &sum, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaFree(a);
  cudaFree(b);
  return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>
__global__ void odd_even_transpose(int *a, int *b, int N){
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int idx = i + j * N + k * N;
  if (idx < N) {
    a[idx] = b[idx];
  } else {
    a[idx] = a[idx - N];
  }
}

int main() {
  int N = 9;
  int *a = (int*)malloc(N * sizeof(int));
  int *b = (int*)malloc(N * sizeof(int));
  cudaMalloc(&a, N * sizeof(int));
  cudaMalloc(&b, N * sizeof(int));
  cudaMemcpy(a, &i, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(b, &j, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(a, &sum, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaFree(a);
  cudaFree(b);
  return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>
__global__ void odd_even_transpose(int *a, int *b, int N){
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int idx = i + j * N + k * N;
  if (idx < N) {
    a[idx] = b[idx];
  } else {
    a[idx] = a[idx - N];
  }
}

int main() {
  int N = 9;
  int *a = (int*)malloc(N * sizeof(int));
  int *b = (int*)malloc(N * sizeof(int));
  cudaMalloc(&a, N * sizeof(int));
  cudaMalloc(&b, N * sizeof(int));
  cudaMemcpy(a, &i, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(b, &j, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(a, &sum, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaFree(a);
  cudaFree(b);
  return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>
__global__ void odd_even_transpose(int *a, int *b, int N){
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int idx = i + j * N + k * N;
  if (idx < N) {
    a[idx] = b[idx];
  } else {
    a[idx] = a[idx - N];
  }
}

int main() {
  int N = 9;
  int *a = (int*)malloc(N * sizeof(int));
  int *b = (int*)malloc(N * sizeof(int));
  cudaMalloc(&a, N * sizeof(int));
  cudaMalloc(&b, N * sizeof(int));
  cudaMemcpy(a, &i, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(b, &j, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(a, &sum, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaFree(a);
  cudaFree(b);
  return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>
__global__ void odd_even_transpose(int *a, int *b, int N){
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int idx = i + j * N + k * N;
  if (idx < N) {
    a[idx] = b[idx];
  } else {
    a[idx] = a[idx - N];
  }
}

int main() {
  int N = 9;
  int *a = (int*)malloc(N * sizeof(int));
  int *b = (int*)