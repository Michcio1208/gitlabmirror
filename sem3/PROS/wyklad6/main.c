#include <stdio.h>
#include <stdlib.h>
struct vector {
float x, y, z;
} * ptrToVector;
int main(void) {
ptrToVector = (struct vector*) calloc(1, sizeof(struct vector));
if (ptrToVector) {
printf("[%f,%f,%f]\n", ptrToVector->x, ptrToVector->y, ptrToVector->z);
// wyświetlamy same zera bo calloc()
free(ptrToVector);
}
return 0;
}