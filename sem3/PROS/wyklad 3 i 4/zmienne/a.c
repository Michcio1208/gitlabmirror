/*
//extern int zmiennaZewnetrzna; // zdefiniowana w innym pliku
//static int tylkoTenPlik = 0;  // widoczna tylko w tej jednostce translacji
#include <stdio.h>
static unsigned liczWywolania(void) {
    auto int temp = 1;            // zmienna automatyczna na stosie
    //register int licznikPetli;    // wskazówka użycia rejestru (brak &licznikPetli)
    static unsigned counter = 0;  // zachowuje wartość między wywołaniami
    counter += temp;
    return counter;
}
int main(void) {
    for (int i = 0; i < 10; ++i) {
        printf("Wywolanie %d: liczWywolania() = %u\n", i + 1, liczWywolania());
    }
    return 0;
}
*/
//#ifndef _MOJA_BIBLIOTEKA_H
//#define _MOJA_BIBLIOTEKA_H

#include <stdio.h>
#define MIN(a,b) ((a)<(b)?(a):(b))
#define STALA 100
//#undef STALA

const int n = 0;     // zmienna tylko do odczytu
volatile char rejestrSprzetowy; // wyłączenie optymalizacji

int main(void) {
    int a = 10, b = 20;
    printf("MIN(%d,%d) = %d\n", a, b, MIN(a,b));
    printf("STALA = %d\n", STALA);
    printf("n = %d\n", n);
    rejestrSprzetowy = 0xFF; // zapis do rejestru sprzętowego
    return 0;
}