#include <cuda_runtime.h>
#include <stdio.h>
 
__global__ void odd_even_sort(int *a, int N)
{
   int idx = threadIdx.x;
   int offset = idx * 2;
   int i = offset;
   int j = offset + 1;
   int k = offset + 2;
   int temp;
   if (idx == 0) {
       temp = a[i];
       a[i] = a[j];
       a[j] = a[k];
       a[k] = temp;
   } else {
       if (idx == 1) {
           temp = a[i];
           a[i] = a[j];
           a[j] = a[k];
           a[k] = temp;
       } else {
           if (idx == 2) {
               temp = a[i];
               a[i] = a[j];
               a[j] = a[k];
               a[k] = temp;
           }
       }
   }
}
 
int main() {
   int a[10], i;
   cudaMalloc(&a, 10 * sizeof(int));
   cudaMemcpy(a, a, 10 * sizeof(int), cudaMemcpyHostToDevice);
   for (i = 0; i < 10; i++) {
       scanf("%d", &a[i]);
   }
   cudaFree(a);
   return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>
 
__global__ void odd_even_sort(int *a, int N)
{
   int idx = threadIdx.x;
   int offset = idx * 2;
   int i = offset;
   int j = offset + 1;
   int k = offset + 2;
   int temp;
   if (idx == 0) {
       temp = a[i];
       a[i] = a[j];
       a[j] = a[k];
       a[k] = temp;
   } else {
       if (idx == 1) {
           temp = a[i];
           a[i] = a[j];
           a[j] = a[k];
           a[k] = temp;
       } else {
           if (idx == 2) {
               temp = a[i];
               a[i] = a[j];
               a[j] = a[k];
               a[k] = temp;
           }
       }
   }
}
 
int main() {
   int a[10], i;
   cudaMalloc(&a, 10 * sizeof(int));
   cudaMemcpy(a, a, 10 * sizeof(int), cudaMemcpyHostToDevice);
   for (i = 0; i < 10; i++) {
       scanf("%d", &a[i]);
   }
   cudaFree(a);
   return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>
 
__global__ void odd_even_sort(int *a, int N)
{
   int idx = threadIdx.x;
   int offset = idx * 2;
   int i = offset;
   int j = offset + 1;
   int k = offset + 2;
   int temp;
   if (idx == 0) {
       temp = a[i];
       a[i] = a[j];
       a[j] = a[k];
       a[k] = temp;
   } else {
       if (idx == 1) {
           temp = a[i];
           a[i] = a[j];
           a[j] = a[k];
           a[k] = temp;
       } else {
           if (idx == 2) {
               temp = a[i];
               a[i] = a[j];
               a[j] = a[k];
               a[k] = temp;
           }
       }
   }
}
 
int main() {
   int a[10], i;
   cudaMalloc(&a, 10 * sizeof(int));
   cudaMemcpy(a, a, 10 * sizeof(int), cudaMemcpyHostToDevice);
   for (i = 0; i < 10; i++) {
       scanf("%d", &a[i]);
   }
   cudaFree(a);
   return 0;
}

#include <cuda_runtime.h>
#include <stdio.h>
 
__global__ void odd_even_sort(int *a, int N)
{
   int idx = threadIdx.x;
   int offset = idx * 2;
   int i = offset;
   int j = offset + 1;
   int k = offset + 2;
   int temp;
   if (idx == 0) {
       temp = a[i];
       a[i] = a[j];
       a[j] = a[k];
       a[k] = temp;
   } else {
       if (idx == 1) {
           temp = a[i];
           a[i] = a[j];
           a[j] = a[k];
           a[k] = temp;
       } else {
           if (idx == 2) {
               temp = a[i];
               a[i]