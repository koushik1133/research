#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *h, int N){
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int offset = (i + j + k) % 2;
  if (offset == 0) {
    for (int m = 0; m < N; m += 2) {
      h[m] = h[m + 1];
    }
  } else {
    for (int m = 1; m < N; m += 2) {
      h[m] = h[m - 1];
    }
  }
}

int main() {
  int N = 10;
  int *h = (int*)cudaMalloc(&N, sizeof(int));
  cudaMemcpy(h, h, N, cudaMemcpyHostToDevice);
  for (int i = 0; i < N; i++) {
    scanf("%d", &h[i]);
  }
  cudaMemcpy(h, h, N, cudaMemcpyDeviceToHost);
  cudaFree(h);
  return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *h, int N) {
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int offset = (i + j + k) % 2;
  if (offset == 0) {
    for (int m = 0; m < N; m += 2) {
      h[m] = h[m + 1];
    }
  } else {
    for (int m = 1; m < N; m += 2) {
      h[m] = h[m - 1];
    }
  }
}

int main() {
  int N = 10;
  int *h = (int*)cudaMalloc(&N, sizeof(int));
  cudaMemcpy(h, h, N, cudaMemcpyHostToDevice);
  for (int i = 0; i < N; i++) {
    scanf("%d", &h[i]);
  }
  cudaMemcpy(h, h, N, cudaMemcpyDeviceToHost);
  cudaFree(h);
  return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *h, int N) {
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int offset = (i + j + k) % 2;
  if (offset == 0) {
    for (int m = 0; m < N; m += 2) {
      h[m] = h[m + 1];
    }
  } else {
    for (int m = 1; m < N; m += 2) {
      h[m] = h[m - 1];
    }
  }
}

int main() {
  int N = 10;
  int *h = (int*)cudaMalloc(&N, sizeof(int));
  cudaMemcpy(h, h, N, cudaMemcpyHostToDevice);
  for (int i = 0; i < N; i++) {
    scanf("%d", &h[i]);
  }
  cudaMemcpy(h, h, N, cudaMemcpyDeviceToHost);
  cudaFree(h);
  return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *h, int N) {
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int offset = (i + j + k) % 2;
  if (offset == 0) {
    for (int m = 0; m < N; m += 2) {
      h[m] = h[m + 1];
    }
  } else {
    for (int m = 1; m < N; m += 2) {
      h[m] = h[m - 1];
    }
  }
}

int main() {
  int N = 10;
  int *h = (int*)cudaMalloc(&N, sizeof(int));
  cudaMemcpy(h, h, N, cudaMemcpyHostToDevice);
  for (int i = 0; i < N; i++) {
    scanf("%d", &h[i]);
  }
  cudaMemcpy(h, h, N, cudaMemcpyDeviceToHost);
  cudaFree(h);
  return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *h, int N) {
  int i = threadIdx.x;
  int j = threadIdx.y;
  int k = threadIdx.z;
  int offset = (i + j + k) % 2;
  if (offset == 0) {
    for (int m = 0; m < N; m += 2) {
      h