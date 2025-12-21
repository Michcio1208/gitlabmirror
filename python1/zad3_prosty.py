"""Bardzo prosty skrypt dopasowany do pliku GUS.
Użycie:
  python zad3_prosty.py [sciezka/do/pliku.csv]
Jeśli nie podasz ścieżki, skrypt użyje:
  python1/rocznewskaznikicentowarowiuslugkonsumpcyjnychod1950roku.csv
"""
import sys
import os
import math


def parse_line(line):
    # pomijamy nagłówek i rozdzielamy po średnikach
    if line.strip().startswith('Nazwa') or line.strip().startswith('Wska'):
        return None, None
    parts = [p.strip() for p in line.split(';')]
    if len(parts) < 5:
        return None, None
    try:
        y = int(parts[3])
        v = float(parts[4].replace(',', '.'))
    except Exception:
        return None, None
    return y, v


def main():
    if len(sys.argv) < 2:
        path = os.path.join(os.path.dirname(__file__), 'rocznewskaznikicentowarowiuslugkonsumpcyjnychod1950roku.csv')
    else:
        path = sys.argv[1]
    try:
        with open(path, 'r', encoding='utf-8') as f:
            data = {y: v for (y, v) in (parse_line(line) for line in f) if y is not None}
    except FileNotFoundError:
        print(f"Plik nie znaleziony: {path}")
        return

    if not data:
        print("Brak danych w pliku.")
        return

    values = list(data.values())
    n = len(values)
    mean = sum(values) / n
    var = sum((x - mean) ** 2 for x in values) / n
    std = math.sqrt(var)

    years_sorted = sorted(data.keys())
    print(f"Wczytano: {n} rekordów ({years_sorted[0]}-{years_sorted[-1]})")
    print(f"Średnia: {mean:.4f}, Odch.std: {std:.4f}")


if __name__ == '__main__':
    main()
