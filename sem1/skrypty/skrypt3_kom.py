#!/usr/bin/env python3
import sys
import math

# Sprawdzenie liczby argumentów (nazwa skryptu + 3 argumenty = 4 elementy)
# Wiedza z sekcji "Obsługa parametrów wywołania skryptu"
if len(sys.argv) != 4:
    print("Blad: Podaj dokladnie 3 liczby")
    # Zakończenie działania w prosty sposób
    sys.exit()

# Pobranie argumentów i konwersja na float
# Wiedza z sekcji "Wczytywanie wartości zmiennej"
a = float(sys.argv[1])
b = float(sys.argv[2])
c = float(sys.argv[3])

# Sprawdzenie czy liczby są dodatnie
# Wiedza z sekcji "Instrukcje warunkowe" (użycie operatora 'and' i '>')
if a > 0 and b > 0 and c > 0:
    # Obliczenie sumy pierwiastków
    # Wiedza z sekcji "Korzystanie z biblioteki standardowej" (math.sqrt)
    suma = math.sqrt(a) + math.sqrt(b) + math.sqrt(c)
    print("Suma pierwiastkow:", suma)
else:
    print("Blad: Liczby musza byc dodatnie")