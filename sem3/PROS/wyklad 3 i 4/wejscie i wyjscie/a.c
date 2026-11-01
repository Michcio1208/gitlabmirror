#include <stdio.h>

int main(void) {
    // 1. Zapis i odczyt formatowany oraz buforowanie
    FILE *fp = fopen("dane.txt", "w");
    if (fp != NULL) {
        fprintf(fp, "%d %f\n", 10, 3.14);
        fflush(fp); // wymuszenie opróżnienia bufora wyjściowego
        fclose(fp);
    }

    int x; float y;
    fp = fopen("dane.txt", "r");
    if (fp != NULL) {
        fscanf(fp, "%d %f", &x, &y);
        fclose(fp);
    }

    // 2. Operacje znakowe i łańcuchowe
    char buf[50];
    fp = fopen("tekst.txt", "w+");
    if (fp != NULL) {
        fputc('A', fp);
        fputs("BC\n", fp);
        rewind(fp);
        int znak = fgetc(fp);
        fgets(buf, sizeof(buf), fp);
        fclose(fp);
    }

    // 3. Blokowy zapis i odczyt binarny
    int tabZapis[4] = {1, 2, 3, 4}, tabOdczyt[4] = {0};
    fp = fopen("binarny.bin", "wb");
    if (fp != NULL) {
        fwrite(tabZapis, sizeof(tabZapis[0]), 4, fp);
        fclose(fp);
    }
    fp = fopen("binarny.bin", "rb");
    if (fp != NULL) {
        fread(tabOdczyt, sizeof(tabOdczyt[0]), 4, fp);
        fclose(fp);
    }
    return 0;
}