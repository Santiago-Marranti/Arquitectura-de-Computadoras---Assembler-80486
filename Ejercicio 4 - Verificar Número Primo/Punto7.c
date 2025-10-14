
#include <stdio.h>
#include <stdbool.h>

bool esPrimo(int num) {
    if (num < 2) return false;
    if (num == 2) return true;
    if (num % 2 == 0) return false;

    for (int i = 3; i * i <= num; i += 2) {
        if (num % i == 0) return false;
    }
    return true;
}

int main() {
    int num = 17;

    if (esPrimo(num)) {
        printf("%d es primo\n", num);
    } else {
        printf("%d no es primo\n", num);
    }

    return 0;
}