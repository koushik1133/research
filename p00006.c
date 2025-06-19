#include <stdio.h>
#define N 5

void vector_add(float *a, float *b, float *result, int n) {
    for (int i = 0; i < n; i++) {
        result[i] = a[i] + b[i];
    }
}

int main() {
    float a[N] = {1.0, 2.0, 3.0, 4.0, 5.0};
    float b[N] = {10.0, 20.0, 30.0, 40.0, 50.0};
    float result[N];

    vector_add(a, b, result, N);

    printf("Result vector:\n");
    for (int i = 0; i < N; i++) {
        printf("%.2f ", result[i]);
    }
    printf("\n");

    return 0;
}
