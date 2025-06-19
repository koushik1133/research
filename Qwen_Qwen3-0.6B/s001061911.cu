#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *arr, int len) {
    int i = threadIdx.x;
    int j = threadIdx.y;
    int k = threadIdx.z;

    if (i < len && j < len && k < len) {
        if (arr[i] < arr[j])
            swap(arr[i], arr[j]);
    }
}

int main() {
    int len = 10;
    int arr[len];
    cudaMalloc(&arr, len * sizeof(int));
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyHostToDevice);
    for (int i = 0; i < len; i++)
        for (int j = 0; j < len; j++)
            if (arr[i] < arr[j])
                swap(arr[i], arr[j]);
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(arr);
    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *arr, int len) {
    int i = threadIdx.x;
    int j = threadIdx.y;
    int k = threadIdx.z;

    if (i < len && j < len && k < len) {
        if (arr[i] < arr[j])
            swap(arr[i], arr[j]);
    }
}

int main() {
    int len = 10;
    int arr[len];
    cudaMalloc(&arr, len * sizeof(int));
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyHostToDevice);
    for (int i = 0; i < len; i++)
        for (int j = 0; j < len; j++)
            if (arr[i] < arr[j])
                swap(arr[i], arr[j]);
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(arr);
    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *arr, int len) {
    int i = threadIdx.x;
    int j = threadIdx.y;
    int k = threadIdx.z;

    if (i < len && j < len && k < len) {
        if (arr[i] < arr[j])
            swap(arr[i], arr[j]);
    }
}

int main() {
    int len = 10;
    int arr[len];
    cudaMalloc(&arr, len * sizeof(int));
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyHostToDevice);
    for (int i = 0; i < len; i++)
        for (int j = 0; j < len; j++)
            if (arr[i] < arr[j])
                swap(arr[i], arr[j]);
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(arr);
    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *arr, int len) {
    int i = threadIdx.x;
    int j = threadIdx.y;
    int k = threadIdx.z;

    if (i < len && j < len && k < len) {
        if (arr[i] < arr[j])
            swap(arr[i], arr[j]);
    }
}

int main() {
    int len = 10;
    int arr[len];
    cudaMalloc(&arr, len * sizeof(int));
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyHostToDevice);
    for (int i = 0; i < len; i++)
        for (int j = 0; j < len; j++)
            if (arr[i] < arr[j])
                swap(arr[i], arr[j]);
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(arr);
    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *arr, int len) {
    int i = threadIdx.x;
    int j = threadIdx.y;
    int k = threadIdx.z;

    if (i < len && j < len && k < len) {
        if (arr[i] < arr[j])
            swap(arr[i], arr[j]);
    }
}

int main() {
    int len = 10;
    int arr[len];
    cudaMalloc(&arr, len * sizeof(int));
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyHostToDevice);
    for (int i = 0; i < len; i++)
        for (int j = 0; j < len; j++)
            if (arr[i] < arr[j])
                swap(arr[i], arr[j]);
    cudaMemcpy(arr, arr, len * sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(arr);
    return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>

__global