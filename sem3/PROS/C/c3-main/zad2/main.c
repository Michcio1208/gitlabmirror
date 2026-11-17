#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "myNames.h"

#define EXIT_SUCCESS_OK 0
#define EXIT_WRONG_ARGUMENT_COUNT 1
#define EXIT_INVALID_NAME 3

int main(int argc, char *argv[]) {
    printf("Program do analizy imion: weryfikuje, poprawia, okresla plec i zlicza litery.\n");

    if (argc != 2) {
        fprintf(stderr, "Blad: Oczekiwano dokladnie jednego argumentu z imieniem.\n");
        return EXIT_WRONG_ARGUMENT_COUNT;
    }

    char name[64];
    strncpy(name, argv[1], 63);
    name[63] = '\0'; 

    printf("Imie wprowadzone: %s\n", argv[1]);

    int status = bigLetter(name);
    
    if (status == NAME_INVALID) {
        fprintf(stderr, "Blad: Wprowadzone imie jest niepoprawne.\n");
        return EXIT_INVALID_NAME;
    }

    printf("Imie poprawione: %s\n", name);

    if (maleOrFemale(name) == NAME_FEMALE) {
        printf("Rodzaj: zenskie\n");
    } else {
        printf("Rodzaj: meskie\n");
    }

    printf("Liczba liter: %d\n", countLetters(name));

    return EXIT_SUCCESS_OK;
}