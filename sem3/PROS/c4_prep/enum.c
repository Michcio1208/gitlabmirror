#include<stdio.h>

typedef enum {MONDAY=1, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY} Weekdays;
typedef enum {SPADE=1,HEARD,DIAMOND, CLUB} CardSuid;
int main(void)
{
Weekdays day=MONDAY;
Weekdays day2=FRIDAY;
CardSuid cardColor=SPADE;

printf("day=%d\n",day);
printf("day2=%d\n",day2);
printf("cardColor=%d\n",cardColor);
return 0;
}