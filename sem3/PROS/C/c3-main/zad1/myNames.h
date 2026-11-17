#ifndef MYNAMES_H
#define MYNAMES_H

/* Kody powrotu dla bigLetter */
#define NAME_OK 0
#define NAME_FIXED 1
#define NAME_INVALID 2

/* Kody powrotu dla maleOrFemale */
#define NAME_MALE 1
#define NAME_FEMALE 2
#define NAME_GENDER_UNKNOWN 0

int bigLetter(char* name);
int maleOrFemale(const char* name);
int countLetters(const char* name);

#endif // MYNAMES_H