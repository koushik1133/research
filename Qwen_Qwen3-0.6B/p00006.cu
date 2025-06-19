#include <cuda_runtime.h>
#include <stdio.h>

__global__ void vector_add(float *a, float *b, float *result, int n) {
    int i = threadIdx.x;
    if (i < n) {
        result[i] = a[i] + b[i];
    }
}

int main() {
    float a[N] = {1.0, 2.0, 3.0, 4.0, 5.0};
    float b[N] = {10.0, 20.0, 30.0, 40.0, 50.0};
    float result[N];

    cudaMalloc(&a, N * sizeof(float));
    cudaMalloc(&b, N * sizeof(float));
    cudaMalloc(&result, N * sizeof(float));

    cudaMemcpy(a, a, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(b, b, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(result, result, N * sizeof(float), cudaMemcpyHostToDevice);

    printf("Result vector:\n");
    for (int i = 0; i < N; i++) {
        printf("%.2f ", result[i]);
    }
    printf("\n");

    cudaFree(a);
    cudaFree(b);
    cudaFree(result);

    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void vector_add(float *a, float *b, float *result, int n) {
    int i = threadIdx.x;
    if (i < n) {
        result[i] = a[i] + b[i];
    }
}

int main() {
    float a[N] = {1.0, 2.0, 3.0, 4.0, 5.0};
    float b[N] = {10.0, 20.0, 30.0, 40.0, 50.0};
    float result[N];

    cudaMalloc(&a, N * sizeof(float));
    cudaMalloc(&b, N * sizeof(float));
    cudaMalloc(&result, N * sizeof(float));

    cudaMemcpy(a, a, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(b, b, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(result, result, N * sizeof(float), cudaMemcpyHostToDevice);

    printf("Result vector:\n");
    for (int i = 0; i < N; i++) {
        printf("%.2f ", result[i]);
    }
    printf("\n");

    cudaFree(a);
    cudaFree(b);
    cudaFree(result);

    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void vector_add(float *a, float *b, float *result, int n) {
    int i = threadIdx.x;
    if (i < n) {
        result[i] = a[i] + b[i];
    }
}

int main() {
    float a[N] = {1.0, 2.0, 3.0, 4.0, 5.0};
    float b[N] = {10.0, 20.0, 30.0, 40.0, 50.0};
    float result[N];

    cudaMalloc(&a, N * sizeof(float));
    cudaMalloc(&b, N * sizeof(float));
    cudaMalloc(&result, N * sizeof(float));

    cudaMemcpy(a, a, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(b, b, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(result, result, N * sizeof(float), cudaMemcpyHostToDevice);

    printf("Result vector:\n");
    for (int i = 0; i < N; i++) {
        printf("%.2f ", result[i]);
    }
    printf("\n");

    cudaFree(a);
    cudaFree(b);
    cudaFree(result);

    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void vector_add(float *a, float *b, float *result, int n) {
    int i = threadIdx.x;
    if (i < n) {
        result[i] = a[i] + b[i];
    }
}

int main() {
    float a[N] = {1.0, 2.0, 3.0, 4.0, 5.0};
    float b[N] = {10.0, 20.0, 30.0, 40.0, 50.0};
    float result[N];

    cudaMalloc(&a, N * sizeof(float));
    cudaMalloc(&b, N * sizeof(float));
    cudaMalloc(&result, N * sizeof(float));

    cudaMemcpy(a, a, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy