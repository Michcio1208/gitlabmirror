#include <stdio.h>

#include <stdio.h>
int someVar = 10;
void varInfo(int *var) {
printf("someVar=%d -> %p\n", *var, var);
}
int main(void) {
varInfo(&someVar);
int someVar = 20;
varInfo(&someVar);
return 0;
}