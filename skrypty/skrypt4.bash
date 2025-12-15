#!/bin/bash
if [ $# -ne 3 ]
then
    echo "Podaj dokladnie 3 argumenty"
    exit 1
fi
if [ $1 -gt 0 ] && [ $2 -gt 0 ] && [ $3 -gt 0 ]
then
    echo "Argumenty poprawne. Uruchamiam skrypt Python..."
    arg1=$(expr $1 + 1)
    arg2=$(expr $2 + 1)
    arg3=$(expr $3 + 1)
    echo "Wywolanie 1 (argumenty + 1; $arg1 $arg2 $arg3):"
    python3 skrypt3.py $arg1 $arg2 $arg3
    arg1=$(expr $1 + 2)
    arg2=$(expr $2 + 2)
    arg3=$(expr $3 + 2)
    echo "Wywolanie 2 (argumenty + 2); $arg1 $arg2 $arg3):"
    python3 skrypt3.py $arg1 $arg2 $arg3
    arg1=$(expr $1 + 3)
    arg2=$(expr $2 + 3)
    arg3=$(expr $3 + 3)
    echo "Wywolanie 3 (argumenty + 3; $arg1 $arg2 $arg3):"
    python3 skrypt3.py $arg1 $arg2 $arg3
else
    echo "Blad: Wszystkie argumenty musza byc liczbami dodatnimi"
fi
