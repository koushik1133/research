#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *arr, int size) {
    int i = threadIdx.x;
    int j = threadIdx.y;
    int k = threadIdx.z;

    if (i == 0) {
        if (j == 0) {
            if (k == 0) {
                arr[i] = arr[i] + 1;
            } else {
                arr[i] = arr[i] - 1;
            }
        } else {
            if (k == 0) {
                arr[i] = arr[i] + 1;
            } else {
                arr[i] = arr[i] - 1;
            }
        }
    } else {
        if (j == 0) {
            if (k == 0) {
                arr[i] = arr[i] + 1;
            } else {
                arr[i] = arr[i] - 1;
            }
        } else {
            if (k == 0) {
                arr[i] = arr[i] + 1;
            } else {
                arr[i] = arr[i] - 1;
            }
        }
    }
}

int main() {
    int size = 10;
    int *arr = (int *)malloc(size * sizeof(int));
    cudaMalloc(&arr, size * sizeof(int));
    cudaMemcpy(arr, input_array, size * sizeof(int), cudaMemcpyHostToDevice);

    for (int i = 0; i < size; ++i) {
        arr[i] = input_array[i];
    }

    __launch_bounds__(1, size);
    odd_even_sort(arr, size);
    cudaMemcpy(arr, output_array, size * sizeof(int), cudaMemcpyDeviceToHost);

    free(arr);
    return 0;
}

#include <iostream>
#include <queue>

using namespace std;

int main() {
    priority_queue<int> pq;

    for (int i = 0; i < 10; ++i) {
        int height;
        cin >> height;
        pq.emplace(height);
    }

    for (int i = 0; i <= 2; ++i) {
        std::cout << pq.top() << endl;
        pq.pop();
    }

    return 0;
}

CUDA code:

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *arr, int size) {
    int i = threadIdx.x;
    int j = threadIdx.y;
    int k = threadIdx.z;

    if (i == 0) {
        if (j == 0) {
            if (k == 0) {
                arr[i] = arr[i] + 1;
            } else {
                arr[i] = arr[i] - 1;
            }
        } else {
            if (k == 0) {
                arr[i] = arr[i] + 1;
            } else {
                arr[i] = arr[i] - 1;
            }
        }
    } else {
        if (j == 0) {
            if (k == 0) {
                arr[i] = arr[i] + 1;
            } else {
                arr[i] = arr[i] - 1;
            }
        } else {
            if (k == 0) {
                arr[i] = arr[i] + 1;
            } else {
                arr[i] = arr[i] - 1;
            }
        }
    }
}

int main() {
    int size = 10;
    int *arr = (int *)malloc(size * sizeof(int));
    cudaMalloc(&arr, size * sizeof(int));
    cudaMemcpy(arr, input_array, size * sizeof(int), cudaMemcpyHostToDevice);

    for (int i = 0; i < size; ++i) {
        arr[i] = input_array[i];
    }

    __launch_bounds__(1, size);
    odd_even_sort(arr, size);
    cudaMemcpy(arr, output_array, size * sizeof(int), cudaMemcpyDeviceToHost);

    free(arr);
    return 0;
}

#include <iostream>
#include <queue>

using namespace std;

int main() {
    priority_queue<int> pq;

    for (int i = 0; i < 10; ++i) {
        int height;
        cin >> height;
        pq.emplace(height);
    }

    for (int i = 0; i <= 2; ++i) {
        std::cout << pq.top() << endl;
        pq.pop();
    }

    return 0;
}

CUDA code:

#include <cuda_runtime.h>
#include <stdio.h>

__global__ void odd_even_sort(int *arr, int size) {
    int i = threadIdx.x;
    int j = threadIdx.y;
    int k = threadIdx.z;

    if (i == 0) {
        if (j == 0) {
            if (k ==