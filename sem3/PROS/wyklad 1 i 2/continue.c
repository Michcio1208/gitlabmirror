//Przykład
#include <stdio.h>
int sumowanie(int suma, int a)
{
    return suma + a;
}
int main(void){
int sumOfEven=0;
for (int i=1;i<=10;i++){
if(i%2!=0) continue;
sumOfEven = sumowanie(sumOfEven, i);
printf("i=%d\n",i);
}
printf("Sum=%d\n",sumOfEven);
return 0;
}