#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "myNames.h"

#define EXIT_SUCCESS_OK 0
#define EXIT_WRONG_ARGUMENT_COUNT 1
#define EXIT_FILE_OPEN_ERROR 2
#define EXIT_INVALID_NAME 3

int main(int argc, char *argv[]) {
    // Tryb 1 argumentu (Zadanie 2)
    if (argc == 2) {
        printf("Program do analizy imion: tryb pojedynczego imienia.\n");
        
        char name[64];
        strncpy(name, argv[1], 63);
        name[63] = '\0'; 

        printf("Imie wprowadzone: %s\n", argv[1]);

        if (bigLetter(name) == NAME_INVALID) {
            fprintf(stderr, "Blad: Wprowadzone imie jest niepoprawne.\n");
            return EXIT_INVALID_NAME;
        }

        printf("Imie poprawione: %s\n", name);
        printf("Rodzaj: %s\n", (maleOrFemale(name) == NAME_FEMALE) ? "zenskie" : "meskie");
        printf("Liczba liter: %d\n", countLetters(name));

        return EXIT_SUCCESS_OK;
    } 
    // Tryb 2 argumentów - operacje na plikach (Zadanie 3)
    else if (argc == 3) {
        printf("Program do analizy imion: tryb wsadowy z pliku.\n");
        
        FILE *fin = fopen(argv[1], "r");
        FILE *fout = fopen(argv[2], "w");
        
        if (!fin || !fout) {
            fprintf(stderr, "Blad: Nie udalo sie otworzyc plikow.\n");
            if (fin) fclose(fin);
            if (fout) fclose(fout);
            return EXIT_FILE_OPEN_ERROR;
        }

        char buffer[64];
        int line_num = 0;
        int report_num = 0;

        while (fgets(buffer, sizeof(buffer), fin)) {
            line_num++; // Numer linii w pliku wejściowym
            
            size_t len = strlen(buffer);
            // Usuwanie znaku nowej linii \n
            if (len > 0 && buffer[len - 1] == '\n') {
                buffer[len - 1] = '\0';
                len--;
            }
            
            // Pomijanie pustych linii (bez zwiększania numeracji w raporcie)
            if (len == 0) continue;

            // Walidacja imienia
            if (bigLetter(buffer) == NAME_INVALID) {
                fprintf(stderr, "Blad w linii %d\n", line_num);
                continue;
            }

            report_num++; // Numer poprawnego wpisu w raporcie
            char* gender = (maleOrFemale(buffer) == NAME_FEMALE) ? "zenskie" : "meskie";
            int letters = countLetters(buffer);

            // Zapis w formacie: numer;imie_poprawione;rodzaj;liczba_liter
            printf("%d;%s;%s;%d\n", report_num, buffer, gender, letters);
            fprintf(fout, "%d;%s;%s;%d\n", report_num, buffer, gender, letters);
        }

        fclose(fin);
        fclose(fout);
        return EXIT_SUCCESS_OK;
    } 
    // Obsługa nieprawidłowej liczby argumentów
    else {
        fprintf(stderr, "Blad: Zla liczba argumentow.\n");
        return EXIT_WRONG_ARGUMENT_COUNT;
    }
}