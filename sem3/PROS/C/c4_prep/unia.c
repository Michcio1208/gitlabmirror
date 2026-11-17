#include <stdio.h>
#define INT 0
#define DOUBLE 1
struct Number {
char type;
union {
int i;
double d;
} data;
};
union NumberUnion {
int i;
double d;
}someNumber={3.14};

void printNumber(struct Number number)
{
if (!number.type) printf("%d\n, rozmiar %d\n",number.data.i,sizeof(number.data.i));
else printf("%lf\n ,rozmiar %d\n",number.data.d,sizeof(number.data.d));
}
int main(void)
{
struct Number firstNumber={INT,.data.i=1};
struct Number secondNumber={DOUBLE,.data.d=2.0};
printNumber(firstNumber);
printNumber(secondNumber);
printf("someNumber i: %i\n",someNumber.i);
printf("someNumber d: %d\n",someNumber.d);
printf("Rozmiar struktury someNumber: %lu\n",sizeof(someNumber));
secondNumber=firstNumber;
printNumber(secondNumber);
return 0;
}