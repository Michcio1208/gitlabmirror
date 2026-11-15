/* Plik: p1.c (połączenie przykładów z prezentacji - Slajdy 9 i 11) */
#include <stdio.h>
#include <stdlib.h>

int dzielenie (int a, int b)
{
    return a/b;
}

int main(void) {
    int rozmiar=3, i;
    int x=3, y=2;
    int tab_1[]={1,2,3,4,5};
    int *tab_2=(int *)malloc(rozmiar*sizeof(int));
    for (i=0; i<rozmiar; i++) tab_2[i]=rozmiar-i;
    printf("%d\n", dzielenie(x,y));
    y=0;
    printf("%d\n", dzielenie(x,y));
    free(tab_2);
    return 0;
}