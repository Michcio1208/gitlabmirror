//////////////////////////////////////////////
// Imie Nazwisko
// moj pierwszy program w C
#include <stdio.h>
int main (void)
{
 int a,b,c; //zmienne typu int
 a=9;
 b=7;
 c=a+b;
 puts("Witamy na zajeciach PROS");
 printf("a=%d\nb=%d\na+b=%d\n",a,b,c);

 // funckcja obliczajaca pole kola o zadanym promieniu
 double r, pole;
 r=5.0;
 pole=3.14*r*r;
 printf("Pole kola o promieniu %.2f wynosi %.2f\n",r,pole);



 return 0;
}