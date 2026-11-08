#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "myNames.h"

int main() {
FILE *fin = fopen("dane.txt", "r");
if (!fin) {
    perror("Error opening file fin");
    return 1;
}
FILE *fout = fopen("raport1.txt", "w");
if (!fout) {
    perror("Error opening file fout");
    fclose(fin);
    return 1;
}
char name[64];
unsigned number_of_names = 0;
while(fgets(name, sizeof(name), fin)) {
   
    // Remove newline character if present
    size_t len = strlen(name);
    if (len > 0 && name[len - 1] == '\n') {
        name[len - 1] = '\0';
    len--;
    }
    if(len== 0) {
        continue; // Skip empty lines
    }
     number_of_names++;
    if(bigLetter(name) == NAME_INVALID) {
        fprintf(stderr, "Blad: Wprowadzone imie jest niepoprawne: %s\n", name);
        continue; // Skip invalid names
    }
    char *plec=(maleOrFemale(name) == NAME_FEMALE) ? "zenskie" : "meskie";
    unsigned zlicz=countLetters(name);
printf("nr%d,Imie: %s, Rodzaj: %s, Liczba liter: %u\n", number_of_names, name, plec, zlicz);
fprintf(fout, "nr%d,Imie: %s, Rodzaj: %s, Liczba liter: %u\n", number_of_names, name, plec, zlicz);
}
fclose(fin);
fclose(fout);
return 0;
}