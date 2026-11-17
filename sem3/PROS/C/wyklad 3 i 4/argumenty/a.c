#include <stdio.h>

int main(int argc, char *argv[]) {
    for (int i = 1; i < argc; i++) {
        printf("arg %d=%s\n", i + 1, argv[i]);
    }
    return 0;
}