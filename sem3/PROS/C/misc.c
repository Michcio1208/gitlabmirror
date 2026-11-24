#include <stdio.h>

void zwieksz(int a) {
    a = a + 10;
}

int main(void) {
    int x = 5;
    zwieksz(x);
    printf("%d\n", x);
    return 0;
}