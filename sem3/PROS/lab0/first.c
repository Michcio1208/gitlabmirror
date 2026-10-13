//////////////////////////////////////////////
// Imie Nazwisko
// moj pierwszy program w C
#include <stdio.h>

int ch(int a)
{
 return a+45;
}

int main (void)
{
 int a,b,c; //zmienne typu int
 a=9;
 b=7;
 c=a+b;
 float d;
 scanf("%f",&d);
 puts("Witamy na zajeciach PROS");
 printf("a=%d\nb=%d\na+b=%d\n",a,b,c);
printf("d=%2.1e\n",d);
printf("a=%+d\n",a);
a= -a;
printf("a=%+d\n",a);
printf("ch=%d\n",ch(a));
int x;
x=(int)d;
printf("x=%d\n",x);
 return 0;
}
//////////////////////////////////////////////
