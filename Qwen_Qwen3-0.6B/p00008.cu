#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *A, int N) {
    int i, j, k;
    __syncthreads();
    if (i < N / 2) {
        for (j = 0; j < N; j++) {
            A[i][j] = A[i][j] + A[i][j + 1];
        }
    } else {
        for (j = 0; j < N; j++) {
            A[i][j] = A[i][j] - A[i][j - 1];
        }
    }
}

int main() {
    int A[N][N], B[N][N], C[N][N];
    cudaMalloc(&A, N * N * sizeof(int));
    cudaMalloc(&B, N * N * sizeof(int));
    cudaMalloc(&C, N * N * sizeof(int));
    cudaMemcpy(A, A, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(B, B, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(C, C, N * N * sizeof(int), cudaMemcpyHostToDevice);

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            C[i][j] = 0;
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    printf("C[0][0] = %d\n", C[0][0]);
    cudaFree(A);
    cudaFree(B);
    cudaFree(C);
    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *A, int N) {
    int i, j, k;
    __syncthreads();
    if (i < N / 2) {
        for (j = 0; j < N; j++) {
            A[i][j] = A[i][j] + A[i][j + 1];
        }
    } else {
        for (j = 0; j < N; j++) {
            A[i][j] = A[i][j] - A[i][j - 1];
        }
    }
}

int main() {
    int A[N][N], B[N][N], C[N][N];
    cudaMalloc(&A, N * N * sizeof(int));
    cudaMalloc(&B, N * N * sizeof(int));
    cudaMalloc(&C, N * N * sizeof(int));
    cudaMemcpy(A, A, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(B, B, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(C, C, N * N * sizeof(int), cudaMemcpyHostToDevice);

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            C[i][j] = 0;
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    printf("C[0][0] = %d\n", C[0][0]);
    cudaFree(A);
    cudaFree(B);
    cudaFree(C);
    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *A, int N) {
    int i, j, k;
    __syncthreads();
    if (i < N / 2) {
        for (j = 0; j < N; j++) {
            A[i][j] = A[i][j] + A[i][j + 1];
        }
    } else {
        for (j = 0; j < N; j++) {
            A[i][j] = A[i][j] - A[i][j - 1];
        }
    }
}

int main() {
    int A[N][N], B[N][N], C[N][N];
    cudaMalloc(&A, N * N * sizeof(int));
    cudaMalloc(&B, N * N * sizeof(int));
    cudaMalloc(&C, N * N * sizeof(int));
    cudaMemcpy(A, A, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(B, B, N * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(C, C, N * N * sizeof(int), cudaMemcpyHostToDevice);

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            C[i][j] = 0;