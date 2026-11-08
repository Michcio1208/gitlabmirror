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
secondNumber=firstNumber;
printNumber(secondNumber);
return 0;
}