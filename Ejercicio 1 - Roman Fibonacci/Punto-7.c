//Versión en C (punto 7)

%%writefile fibonacci.c
#include <stdio.h>

int main() {
    int n = 10;
    int fib[20] = {0, 1};

    // Calcular Fibonacci
    for (int i = 2; i < n; i++) {
        fib[i] = fib[i-1] + fib[i-2];
    }

    // Mostrar resultado
    printf("Fibonacci: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", fib[i]);
    }
    printf("\n");

    return 0;
}

// Compilar y ejecutar versión C

!gcc -m32 fibonacci.c -o fibonacci_c
!./fibonacci_c