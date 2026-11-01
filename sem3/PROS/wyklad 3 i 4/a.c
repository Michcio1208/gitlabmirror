#include <stdio.h>

float sum1D(float *array, int size) {
    float sum = 0.0f;
    for (int i = 0; i < size; i++) {
        sum += array[i];
    }
    return sum;
}
float sum2D(float (*array)[4], int rows) {
    float sum = 0.0f;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < 4; j++) {
            sum += array[i][j];
        }
    }
    return sum;
}

int main() {
    
  float array1D[5] = {1, 2, 3, 4, 5};
  float val = *(array1D + 2); // tożsame z array1D[2]
  float *ptr1D = array1D + 2; // tożsame z &array1D[2]

  float array2D[3][4] = {
      {1, 2, 3, 4},
      {5, 6, 7, 8},
      {9, 10, 11, 12}
  };
  float (*ptr2D)[4] = array2D; // wskaźnik do tablicy 4-elementowej
/*
  printf("array1D (adres): %p\n", (void *)array1D);
  printf("array1D (elementy): ");
  for (int i = 0; i < 5; i++) {
      printf("%f ", array1D[i]);
  }
  printf("\n");

  printf("val: %f\n", val);
  printf("ptr1D (adres): %p, *ptr1D (wartosc): %f\n", (void *)ptr1D, *ptr1D);

  printf("array2D (adres): %p\n", (void *)array2D);
  printf("ptr2D (adres): %p, **ptr2D (pierwszy element): %f\n", (void *)ptr2D, **ptr2D);

  printf("array2D / ptr2D (elementy):\n");
  for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 4; j++) {
          printf("%2f ", ptr2D[i][j]);
      }
      printf("\n");
  }
*/
printf("Suma elementów array1D: %f\n", sum1D((float *)array1D, 5));
printf("Suma elementów array2D: %f\n", sum2D((float (*)[4])array2D, 3));

  return 0;

}
/*Zapis int (*array)[4] oznacza: wskaźnik na 4-elementową tablicę liczb typu int.

Wynika to z dwóch głównych powodów: sposobu, w jaki tablice 2D są zorganizowane w pamięci w języku C, oraz priorytetu operatorów.

1. Czym w pamięci jest tablica dwuwymiarowa?

Tablica int tab[3][4] to w rzeczywistości tablica 3 elementów, gdzie każdym elementem jest 4-elementowa tablica int:

text
           [0]     [1]     [2]     [3]
wiersz 0: [int]   [int]   [int]   [int]   <-- element 0: tablica 4 intów
wiersz 1: [int]   [int]   [int]   [int]   <-- element 1: tablica 4 intów
wiersz 2: [int]   [int]   [int]   [int]   <-- element 2: tablica 4 intów

Gdy przekazujesz tablicę do funkcji lub przypisujesz ją do wskaźnika, zachodzi tzw. array decay (degradacja tablicy do wskaźnika na jej pierwszy element):

Dla tablicy 1D (int arr[5]): elementem jest pojedynczy int, więc pierwszy element ma typ int, a wskaźnik to int *.
Dla tablicy 2D (int arr[3][4]): elementem jest cała tablica int[4], więc wskaźnik na ten element to wskaźnik na tablicę 4 intów: int (*)[4].
2. Dlaczego kompilator musi znać liczbę kolumn [4]? (Arytmetyka wskaźników)

Wskaźnik musi wiedzieć, o ile bajtów ma przesunąć się w pamięci, gdy wykonasz operację np. array + 1 lub array[i]:

Rozmiar jednego wiersza to 4 * sizeof(int) = 16 bajtów.
Dzięki zapisowi (*array)[4], kompilator wie:
adres 
(
𝑎
𝑟
𝑟
𝑎
𝑦
+
1
)
=
𝑎
𝑟
𝑟
𝑎
𝑦
+
1
×
(
4
×
sizeof
(
𝑖
𝑛
𝑡
)
)
adres (array+1)=array+1×(4×sizeof(int))
Gdyby nie było [4], kompilator nie wiedziałby, gdzie kończy się wiersz 0, a zaczyna wiersz 1, i operacja array[i][j] nie mogłaby zostać poprawnie obliczona w pamięci.

(Liczba wierszy nie jest potrzebna, bo wskaźnik wskazuje tylko na początek – dlatego pierwszy wymiar może być pusty, np. int array[][4] w parametrze funkcji).

3. Dlaczego nawiasy (*array) są konieczne? (Priorytety operatorów)

Nawiasy wokół *array decydują o tym, z czym najpierw wiąże się nazwa zmiennej:

int (*array)[4] (z nawiasami):

Nawiasy wymuszają, że najpierw ewaluowana jest gwiazdka *.
Znaczenie: array jest wskaźnikiem wskazującym na tablicę 4 intów.

int *array[4] (bez nawiasów):

Operator [] ma wyższy priorytet niż *.
Znaczenie: array jest 4-elementową tablicą wskaźników (tablicą trzymającą 4 wskaźniki typu int *). To zupełnie inny typ!
Podsumowanie w kontekście funkcji suma2D:
c
int suma2D(int (*array)[4], int rows) {
    // array[i][j] przelicza się pod spodem na:
    // *( *(array + i) + j )
    // Żeby "skoczyć" o cały wiersz (i), kompilator MUSI wiedzieć, że wiersz ma szerokość 4.
}

Zapis int (*array)[4] w nagłówku funkcji jest w C w 100% równoważny zapisowi int array[][4].
*/