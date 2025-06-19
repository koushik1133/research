#include <stdio.h>

#define N 512

int main() {
    float input[N], output[N];
    for (int i = 0; i < N; i++)
        input[i] = i * 0.5f;

    for (int i = 0; i < N; i++)
        output[i] = input[i] * input[i];

    printf("output[0] = %.2f, output[%d] = %.2f\n", output[0], N-1, output[N-1]);
    return 0;
}
