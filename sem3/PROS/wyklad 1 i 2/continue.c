//Przykład
#include <stdio.h>
int main(void){
int sumOfEven=0;
for (int i=1;i<=10;i++){
if(i%2!=0) continue;
printf("i=%d\n",i);
}
printf("Sum=%d\n",sumOfEven);
return 0;
}