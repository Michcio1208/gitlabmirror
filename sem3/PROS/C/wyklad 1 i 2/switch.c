//Przykład
#include <stdio.h>
int main(void) {
    char key;
    printf("Enter key=");
    scanf("%c", &key);
    switch (key) {
        case 'a': 
            printf("Key %c pressed\n", key);
            break;
        case '+': 
            printf("Key %c pressed\n", key);
            break;
        default: 
            printf("Another key pressed\n");
            break;
    }
    return 0;
}