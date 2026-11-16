#include <stdio.h>
void f_1(double x) { printf("x=%.2f\n", x); }
double f_2(double x, double y) { return x + y; }
int main(int argc, char **argv)
{
void (*fp_1)(double);
double (*fp_2)(double, double);
double x = 2.0, y = 3.0;
fp_1 = f_1; //nazwa funkcji to wskaźnik do tej funkcji
fp_2 = f_2; //podobnie jak w przypadku tablic
f_1(x); //wywołanie bezpośrednie f_1()
(*fp_1)(y); //wywołanie pośrednie f_1()
(*fp_1)(f_2(x, y)); //wywołanie pośrednie f_1() i bezpośrednie f_2()
(*fp_1)((*fp_2)(x, y)); //wywołanie pośrednie f_1 i pośrednie f_2()
printf("%.2f+%.2f=%.2f\n", x, y, (*fp_2)(x, y)); //wywołanie pośrednie f_2()
return 0;
}