#include <cuda_runtime.h>
#include <stdio.h>
__global__ void odd_even_transpose(int *a, int *b, int N) {
  int i,j;
  __syncthreads();
  for (i=0; i < N; i++) {
    for (j=0; j < N; j++) {
      if (i == j) {
        b[i] = a[j];
      } else {
        b[i] = a[j];
      }
    }
  }
}
__global__ void bubble_sort(int *a, int *b, int N) {
  int i,j;
  __syncthreads();
  for (i=0; i < N; i++) {
    for (j=0; j < N; j++) {
      if (a[i] > a[j]) {
        b[i] = a[j];
        a[j] = a[i];
      }
    }
  }
}
__global__ void transpose(int *a, int *b, int N) {
  int i,j;
  __syncthreads();
  for (i=0; i < N; i++) {
    for (j=0; j < N; j++) {
      if (i == j) {
        b[i] = a[j];
      } else {
        b[i] = a[j];
      }
    }
  }
}
__global__ void swap(int *a, int *b, int i, int j) {
  int k;
  __syncthreads();
  for (k=0; k < N; k++) {
    if (k == i) {
      a[k] = b[k];
    } else if (k == j) {
      b[k] = a[k];
    }
  }
}
__global__ void swap2(int *a, int *b, int i, int j) {
  int k;
  __syncthreads();
  for (k=0; k < N; k++) {
    if (k == i) {
      a[k] = b[k];
    } else if (k == j) {
      b[k] = a[k];
    }
  }
}
__global__ void swap3(int *a, int *b, int i, int j) {
  int k;
  __syncthreads();
  for (k=0; k < N; k++) {
    if (k == i) {
      a[k] = b[k];
    } else if (k == j) {
      b[k] = a[k];
    }
  }
}

int main() {
  int a,b;
  for(int j=1;j<=9;j++){
    for(int i=1;i<=9;i++)
      scanf("%d",&a);
  }
  cudaMalloc(&a, N * sizeof(int));
  cudaMalloc(&b, N * sizeof(int));
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(b, input, N * sizeof(int), cudaMemcpyDeviceToHost);
  cudaMemcpy(a, input, N * sizeof