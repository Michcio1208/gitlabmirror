#include <stdio.h>

// Typ wyliczeniowy określający, co aktualnie przechowuje unia
enum DisplayInfo { SHOW_AGE, SHOW_HEIGHT };

struct adress {
    char street[20];
    char city[20];
    char zip[7];
};

struct student {
    char name[20];
    enum DisplayInfo infoType; // flaga informująca: wiek czy wzrost
    union {
        int age;
        float height;
    };
    struct adress studentAdress;
};

int main(void) {
    // 1. Inicjalizacja ze wzrostem (używamy .height)
    struct student student1 = {
        .name = "Jan",
        .infoType = SHOW_HEIGHT,
        .height = 1.82f,
        .studentAdress = {"Kwiatowa", "Warszawa", "00-000"}
    };

    printf("--- Wersja 1: Wzrost ---\n");
    printf("imie: %s\n", student1.name);
    
    // Sprawdzamy znacznik unii
    if (student1.infoType == SHOW_AGE) {
        printf("wiek: %d lat\n", student1.age);
    } else {
        printf("wzrost: %.2f m\n", student1.height);
    }

    printf("adres: %s, %s %s\n\n", student1.studentAdress.street, 
                                  student1.studentAdress.zip, 
                                  student1.studentAdress.city);

    // 2. Dynamiczna zmiana na wiek (nadpisuje to samo miejsce w pamięci!)
    student1.infoType = SHOW_AGE;
    student1.age = 21;

    printf("--- Wersja 2: Po zmianie na wiek ---\n");
    printf("imie: %s\n", student1.name);

    if (student1.infoType == SHOW_AGE) {
        printf("wiek: %d lat\n", student1.age);
    } else {
        printf("wzrost: %.2f m\n", student1.height);
    }

    return 0;
}