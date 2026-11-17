#include <stdio.h>
struct {
int i;
double d;
} someStruct={1,2.0};
union {
int i;
double d;
} someUnion={.d=2.14};
int main(void)
{
printf("Struct size=%lu[B]\n",sizeof(someStruct));
printf("Union size=%lu[B]\n",sizeof(someUnion));
printf("Unia: i=%d, d=%lf\n",someUnion.i,someUnion.d);
return 0;
}