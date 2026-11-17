#include <stdio.h>
#include <math.h>
int main(void)
{
double f=0.1,eps=10e-5;
for (int i=0;i<9;i++) f+=0.1;
if (f==1.0) /*ZLE*/
printf("Direct comparison - TRUE\n");
else printf("Direct comparison - FALSE\n");
if (fabs(f-1.0)<eps) /*DOBRZE*/
printf("Epsilon comparison TRUE\n");
else printf("Eps comparison - FALSE\n");
printf ("f\t=%.32f\n",f);
printf ("1.0\t=%.32f\n",1.0);
return 0;
}