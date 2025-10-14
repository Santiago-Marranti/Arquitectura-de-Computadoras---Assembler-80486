%%writefile mcd.c
#include <stdio.h>

int calcularMCD(int a, int b) {
    while (a != b) {
        if (a > b) {
            a = a - b;
        } else {
            b = b - a;
        }
    }
    return a;
}

int calcularMCM(int a, int b) {
    return (a * b) / calcularMCD(a, b);
}

int main() {
    int a = 48;
    int b = 18;
    int mcd = calcularMCD(a, b);
    int mcm = calcularMCM(a, b);

    printf("MCD de %d y %d es: %d\n", a, b, mcd);
    printf("MCM de %d y %d es: %d\n", a, b, mcm);

    return 0;
}