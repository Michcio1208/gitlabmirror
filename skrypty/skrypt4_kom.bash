#!/bin/bash

# 1. Sprawdzenie liczby argumentów (czy nie jest równa 3)
# Użycie operatora -ne z tabeli "Testowanie wyrażeń numerycznych"
if [ $# -ne 3 ]
then
    echo "Podaj dokladnie 3 argumenty"
    exit 1
fi

# 2. Sprawdzenie czy argumenty są dodatnie (większe od 0)
# Użycie operatora -gt z tabeli
if [ $1 -gt 0 ] && [ $2 -gt 0 ] && [ $3 -gt 0 ]
then
    echo "Argumenty poprawne. Uruchamiam skrypt Python..."

    # --- Wywołanie 1 (dodanie 1) ---
    # Użycie 'expr' zgodnie z sekcją "Obliczenia arytmetyczne"
    # PAMIĘTAJ O SPACJACH: expr $a + 1
    arg1=$(expr $1 + 1)
    arg2=$(expr $2 + 1)
    arg3=$(expr $3 + 1)
    
    echo "Wywolanie 1 (argumenty + 1):"
    python3 zadanie3.py $arg1 $arg2 $arg3

    # --- Wywołanie 2 (dodanie 2) ---
    arg1=$(expr $1 + 2)
    arg2=$(expr $2 + 2)
    arg3=$(expr $3 + 2)

    echo "Wywolanie 2 (argumenty + 2):"
    python3 zadanie3.py $arg1 $arg2 $arg3

    # --- Wywołanie 3 (dodanie 3) ---
    arg1=$(expr $1 + 3)
    arg2=$(expr $2 + 3)
    arg3=$(expr $3 + 3)

    echo "Wywolanie 3 (argumenty + 3):"
    python3 zadanie3.py $arg1 $arg2 $arg3

else
    echo "Blad: Wszystkie argumenty musza byc liczbami dodatnimi"
fi