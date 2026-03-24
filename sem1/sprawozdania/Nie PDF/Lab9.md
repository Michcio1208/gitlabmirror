

--- 

#Sprawozdanie: Wstęp do informatyki - Laboratorium nr 9**Temat:** Skrypty powłoki systemowej **Data:** Grudzień 2025 
**Autor:** [Twoje Imię i Nazwisko]

---

##WstępCelem laboratorium było stworzenie skryptów powłoki oraz skryptów w języku Python realizujących zadania administracyjne i obliczeniowe. Zgodnie z wymaganiami, sprawozdanie zawiera kody źródłowe oraz dokumentację testów (zrzuty ekranu) dla przypadków poprawnych i błędnych.

---

##Zadanie 1. Skrypt do archiwizacji (Backup)**Treść zadania:**
Napisanie skryptu, który kopiuje pliki o zadanym rozszerzeniu z podanej ścieżki do katalogu `~/backup`. Skrypt musi obsługiwać argumenty wywołania.

###Kod źródłowy: `zadanie1.sh````bash
#!/bin/bash

# Sprawdzenie czy podano 2 argumenty (rozszerzenie i ścieżka)
if [ "$#" -ne 2 ]; then
    echo "Błąd: Nieprawidłowa liczba argumentów."
    echo "Użycie: $0 <rozszerzenie> <ścieżka_źródłowa>"
    exit 1
fi

EXT=$1
DIR=$2

# Sprawdzenie czy katalog źródłowy istnieje
if [ ! -d "$DIR" ]; then
    echo "Błąd: Katalog źródłowy '$DIR' nie istnieje."
    exit 1
fi

# Utworzenie katalogu backup w katalogu domowym
# Użyto zmiennej $HOME dla pewności ścieżki
mkdir -p "$HOME/backup"

echo "Kopiowanie plików *$EXT z $DIR do ~/backup..."

# Wyszukanie i skopiowanie plików (polecenia find i cp)
find "$DIR" -name "*$EXT" -exec cp {} "$HOME/backup" \;

echo "Zakończono."

```

###Dokumentacja działania (Zrzuty ekranu)**1. Test poprawny:**
Uruchomienie skryptu dla plików `.pdf` w katalogu `~/sprawozdania`. Widać poprawne skopiowanie plików.

> [TU WKLEJ ZRZUT EKRANU: wywołanie `./zadanie1.sh .pdf ~/sprawozdania` oraz wynik `ls ~/backup`]

**2. Test błędu (zła liczba argumentów):**
Próba uruchomienia bez argumentów.

> [TU WKLEJ ZRZUT EKRANU: wywołanie `./zadanie1.sh`]

**3. Test błędu (nieistniejący katalog):**
Próba uruchomienia dla błędnej ścieżki.

> [TU WKLEJ ZRZUT EKRANU: wywołanie `./zadanie1.sh .txt ./nie_ma_takiego_folderu`]

---

##Zadanie 2. Monitor systemu**Treść zadania:**
Skrypt wyświetlający co sekundę informacje o systemie (host, kernel, uptime, CPU, dysk, procesy) do momentu naciśnięcia klawisza `q`.

###Kod źródłowy: `zadanie2.sh````bash
#!/bin/bash

echo "Uruchamiam monitor (Naciśnij 'q' aby wyjść)..."
sleep 2

while true; do
    clear
    echo "=== MONITOR SYSTEMU ==="
    
    # Wyświetlanie informacji zgodnie z instrukcją
    echo "Nazwa hosta: $(hostname)"
    echo "Wersja jądra: $(uname -r)"
    echo "Czas działania: $(uptime -p)"
    
    # Wykorzystanie procesora (mpstat)
    echo -n "CPU: "
    mpstat | tail -1 | awk '{print 100-$12"%"}'
    
    # Użycie dysku
    echo "Użycie dysku:"
    df -h --total | tail -1
    
    echo "---------------------------------"
    echo "Top 5 procesów:"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6
    
    # Oczekiwanie na klawisz 'q' (czas oczekiwania: 1 sekunda)
    read -t 1 -N 1 input
    if [[ "$input" == "q" ]]; then
        echo -e "\nKoniec pracy."
        break
    fi
done

```

###Dokumentacja działania (Zrzuty ekranu)**1. Działanie monitora:**
Zrzut ekranu przedstawiający działający skrypt z aktualnymi danymi systemowymi.

> [TU WKLEJ ZRZUT EKRANU: widok terminala z tabelą procesów i użyciem zasobów]

---

##Zadanie 3. Obliczenia w Pythonie (Wersja uproszczona)**Treść zadania:**
Skrypt w Python 3 przyjmujący 3 argumenty. Sprawdza ich liczbę i czy są dodatnie, a następnie oblicza sumę ich pierwiastków.

###Kod źródłowy: `zadanie3.py````python
#!/usr/bin/env python3
import sys
import math

# Sprawdzenie liczby argumentów
# Wymagane są 3 argumenty + nazwa skryptu = 4 elementy listy sys.argv
if len(sys.argv) != 4:
    print("Blad: Podaj dokladnie 3 liczby")
    sys.exit()

# Pobranie argumentów
a = float(sys.argv[1])
b = float(sys.argv[2])
c = float(sys.argv[3])

# Sprawdzenie czy liczby są dodatnie
if a > 0 and b > 0 and c > 0:
    # Obliczenie sumy pierwiastków
    wynik = math.sqrt(a) + math.sqrt(b) + math.sqrt(c)
    print("Suma pierwiastkow:", wynik)
else:
    print("Blad: Liczby musza byc dodatnie")

```

###Dokumentacja działania (Zrzuty ekranu)**1. Test poprawny:**
Obliczenie dla liczb 4, 9, 16 (wynik powinien być 9.0).

> [TU WKLEJ ZRZUT EKRANU: `python3 zadanie3.py 4 9 16`]

**2. Test błędu (liczba ujemna):**
Próba obliczenia dla liczby ujemnej.

> [TU WKLEJ ZRZUT EKRANU: `python3 zadanie3.py 4 -9 16`]

**3. Test błędu (zła liczba argumentów):**
Podanie zbyt małej liczby argumentów.

> [TU WKLEJ ZRZUT EKRANU: `python3 zadanie3.py 10 20`]

---

##Zadanie 4. Wrapper w powłoce (Wersja uproszczona)**Treść zadania:**
Skrypt powłoki sprawdzający 3 argumenty, a następnie wywołujący skrypt Python trzykrotnie, modyfikując argumenty o +1, +2 i +3. Kod wykorzystuje polecenie `expr` do obliczeń.

###Kod źródłowy: `zadanie4.sh````bash
#!/bin/sh

# Sprawdzenie liczby argumentów
if [ $# -ne 3 ]
then
    echo "Blad: Podaj dokladnie 3 argumenty"
    exit 1
fi

# Sprawdzenie czy argumenty są dodatnie (prosta weryfikacja -gt 0)
if [ $1 -gt 0 ] && [ $2 -gt 0 ] && [ $3 -gt 0 ]
then
    echo "Argumenty poprawne. Rozpoczynam obliczenia..."

    # Wywołanie 1 (argumenty + 1)
    # Użycie expr do obliczeń arytmetycznych
    a1=$(expr $1 + 1)
    b1=$(expr $2 + 1)
    c1=$(expr $3 + 1)
    
    echo "--- Wywolanie 1 (dane + 1): $a1 $b1 $c1 ---"
    python3 zadanie3.py $a1 $b1 $c1

    # Wywołanie 2 (argumenty + 2)
    a2=$(expr $1 + 2)
    b2=$(expr $2 + 2)
    c2=$(expr $3 + 2)

    echo "--- Wywolanie 2 (dane + 2): $a2 $b2 $c2 ---"
    python3 zadanie3.py $a2 $b2 $c2

    # Wywołanie 3 (argumenty + 3)
    a3=$(expr $1 + 3)
    b3=$(expr $2 + 3)
    c3=$(expr $3 + 3)

    echo "--- Wywolanie 3 (dane + 3): $a3 $b3 $c3 ---"
    python3 zadanie3.py $a3 $b3 $c3

else
    echo "Blad: Argumenty musza byc wieksze od 0"
fi

```

###Dokumentacja działania (Zrzuty ekranu)**1. Test poprawny:**
Uruchomienie skryptu dla danych wejściowych: 3, 8, 15.
Skrypt powinien wykonać obliczenia dla zestawów: (4,9,16), (5,10,17) itd.

> [TU WKLEJ ZRZUT EKRANU: `./zadanie4.sh 3 8 15`]

**2. Test błędu:**
Podanie liczby ujemnej na wejściu.

> [TU WKLEJ ZRZUT EKRANU: `./zadanie4.sh 3 -5 10`]