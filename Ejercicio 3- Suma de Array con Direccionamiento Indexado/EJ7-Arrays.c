#include <stdio.h>

int main() {
    int array[] = {2, 4, 6, 8, 10};
    int count = 5;
    int sum = 0;

    for (int i = 0; i < count; i++) {
        sum += array[i];
    }

    printf("La suma del array es: %d\n", sum);
    return 0;
}