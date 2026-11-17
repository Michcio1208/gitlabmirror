#include <stdio.h>
#include <stdlib.h>
int main(void) {
const unsigned size = 6;
int *ptr = (int*)calloc(size, sizeof(int)), *ptr1;
if (ptr) { //jeśli ptr != NULL czyli udało się przydzielić pamięć
ptr1 =(int*) realloc(ptr, (size + 2) * sizeof(int)); //wsk. do void zamieniamy na wsk. do int
if (!ptr1) { //jeśli NIE udało się zwiększyć pamięci
free(ptr); //to zwalniamy to co wskazuje ptr
}
else { //jeśli udało się zwiększyć pamięć
printf("ptr->%p, ptr1->%p\n",ptr,ptr1);
ptr=ptr1;
for (int i = 0; i < (size + 2); i++) printf("%d\n", ptr[i]);
free(ptr);
}
}
return 0;
}