%%writefile factorial.c
#include <stdio.h>

// Función para calcular factorial de forma iterativa
long long factorial_iterativo(int n) {
    if (n < 0) return -1; // Error para números negativos
    if (n == 0 || n == 1) return 1;
    
    long long resultado = 1;
    for (int i = 2; i <= n; i++) {
        resultado *= i;
    }
    return resultado;
}

// Función para calcular factorial de forma recursiva
long long factorial_recursivo(int n) {
    if (n < 0) return -1;
    if (n == 0 || n == 1) return 1;
    return n * factorial_recursivo(n - 1);
}

int main() {
    int numero = 5;
    
    printf("=== CALCULADORA DE FACTORIAL ===\n");
    printf("Numero: %d\n", numero);
    
    // Calcular factorial de ambas formas
    long long fact_iter = factorial_iterativo(numero);
    long long fact_rec = factorial_recursivo(numero);
    
    // Mostrar resultados
    printf("Factorial (iterativo): %lld\n", fact_iter);
    printf("Factorial (recursivo): %lld\n", fact_rec);
    
    // Verificar que ambos métodos coinciden
    if (fact_iter == fact_rec) {
        printf("✓ Ambos métodos producen el mismo resultado.\n");
    } else {
        printf("✗ Error: Los métodos producen resultados diferentes.\n");
    }
    
    // Mostrar tabla de factoriales pequeños
    printf("\n--- TABLA DE FACTORIALES (0-10) ---\n");
    for (int i = 0; i <= 10; i++) {
        printf("%2d! = %lld\n", i, factorial_iterativo(i));
    }
    
    return 0;
}

