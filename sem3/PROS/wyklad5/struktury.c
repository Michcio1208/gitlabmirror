#include<stdio.h>
/*
struct Point3D {
    float coordinates[3];
}; firstPoint={{0.0, 0.0, 0.0}}; secondPoint={1.0, 1.0, 1.0}; //struktura nazwana, mozna uzyc wielu struktur tego samego typu

struct{
    struct Point topLeft;
    struct Point bottomRight;
};Rectangle; //struktura bezimienna, mozna uzyc tylko jednej bezimiennej

struct Rectangle {
    struct Point topLeft;
    struct Point bottomRight;
}Rectangle; //struktura nazwana, mozna uzyc wielu struktur tego samego typu
*/
struct adress {
    char street[20];
    char city[20];
    char zip[7];
};
struct student {
    char name[20];
    int age;
    struct adress studentAdress; //struktura zagniezdzona
}student1={"Jan", 20, {"Kwiatowa", "Warszawa", "00-000"}};
int main() {
    printf("imie: %s\n", student1.name);
    printf("wiek: %d\n", student1.age);
    printf("ulica: %s\n", student1.studentAdress.street);
    printf("miasto: %s\n", student1.studentAdress.city);
    printf("kod pocztowy: %s\n", student1.studentAdress.zip);

    return 0;
}