#include<stdio.h>
#include<string.h>

typedef struct Book {
    char title[100];
    char author[100];
    int year;
}Book;

int main() {
    Book book1;
    Book book2;
    strcpy(book1.title, "The Great Gatsby");
    strcpy(book1.author, "F. Scott Fitzgerald");
    book1.year = 1925;

    printf("Title: %s\n", book1.title);
    printf("Author: %s\n", book1.author);
    printf("Year: %d\n", book1.year);

    book2=book1;
    struct Book *b=&book2;
    //book2={.title="1984",.author="George Orwell",.year=1949};
    //b->title="1984";
    strcpy(b->title, "1984");
    strcpy(b->author, "Orwell");
    b->year=1984;
    printf("Title: %s\n", book2.title);
    printf("Author: %s\n", book2.author);
    printf("Year: %d\n", book2.year);
    return 0;
}