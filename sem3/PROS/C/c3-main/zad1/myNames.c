#include "myNames.h"
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

int bigLetter(char* name) {
    if (name == NULL || name[0] == '\0') {
        fprintf(stderr, "Blad: Pusty lancuch lub NULL.\n");
        return NAME_INVALID;
    }

    int i = 0;
    int hyphens = 0;

    /* Sprawdzanie dozwolonych znaków (tylko ASCII i max 1 myślnik) */
    while (name[i] != '\0') {
        if (name[i] == '-') {
            hyphens++;
        } else if (!((name[i] >= 'a' && name[i] <= 'z') || (name[i] >= 'A' && name[i] <= 'Z'))) {
            fprintf(stderr, "Blad: Niedozwolony znak w imieniu.\n");
            return NAME_INVALID;
        }
        i++;
    }

    if (hyphens > 1) {
        fprintf(stderr, "Blad: Wiecej niz jeden myslnik.\n");
        return NAME_INVALID;
    }

    bool fixed = 0;
    bool new_word = 1;

    /* Poprawianie wielkości liter w miejscu */
    for (i = 0; name[i] != '\0'; i++) {
        if (name[i] == '-') {
            new_word = 1;
            continue;
        }

        if (new_word) {
            if (name[i] >= 'a' && name[i] <= 'z') {
                name[i] = name[i] - ('a' - 'A'); // Zamiana na wielką
                fixed = 1;
            }
            new_word = 0;
        } else {
            if (name[i] >= 'A' && name[i] <= 'Z') {
                name[i] = name[i] + ('a' - 'A'); // Zamiana na małą
                fixed = 1;
            }
        }
    }

    return fixed ? NAME_FIXED : NAME_OK;
}

int maleOrFemale(const char* name) {
    if (name == NULL || name[0] == '\0') {
        return NAME_GENDER_UNKNOWN;
    }
    
    int len = strlen(name);
    char last = name[len - 1];
    
    /* Decyduje ostatnia litera */
    if (last == 'a' || last == 'A') {
        return NAME_FEMALE;
    }
    return NAME_MALE;
}

int countLetters(const char* name) {
    if (name == NULL) {
        return -1;
    }
    
    int count = 0;
    for (int i = 0; name[i] != '\0'; i++) {
        if ((name[i] >= 'a' && name[i] <= 'z') || (name[i] >= 'A' && name[i] <= 'Z')) {
            count++;
        }
    }
    return count;
}