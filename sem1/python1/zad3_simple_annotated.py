# Ten plik zawiera kod z `python1/zad3_simple.py` z wyjaśnieniami każdej linijki.
# Każda linia kodu znajduje się bezpośrednio pod komentarzem objaśniającym jej działanie.

# Import biblioteki pandas pod aliasem pd (używana do pracy z tabelami/CSV)
import pandas as pd

# Import modułu pyplot z matplotlib do rysowania wykresów
import matplotlib.pyplot as plt

# Import biblioteki numpy pod aliasem np (używana do obliczeń numerycznych)
import numpy as np

# Nazwa pliku CSV, który będzie wczytany
nazwa_pliku = 'inflacja.csv'

# Wczytaj plik CSV do obiektu typu DataFrame (tutaj nazwanego `plik`)
# Parametr sep=';' ustawia separator pól na średnik, encoding ustawia kodowanie
plik = pd.read_csv(nazwa_pliku, sep=';', encoding='cp1250')

# Utworzenie nowej kolumny 'Wartość_liczba' poprzez:
# 1) konwersję wartości na string (astype(str))
# 2) zamianę przecinka na kropkę (str.replace(',', '.'))
# 3) konwersję na float (astype(float))
plik['Wartość_liczba'] = plik['Wartość'].astype(str).str.replace(',', '.').astype(float)

# Zmienna przechowująca nazwę kolumny, którą będziemy analizować
kolumna_do_analizy = 'Wartość_liczba'

# Posortuj tabelę `plik` według kolumny 'Rok' rosnąco
plik = plik.sort_values('Rok')

# Wyciągnij wartości kolumny analizy do tablicy NumPy typu float
srednie_wartosci = plik[kolumna_do_analizy].to_numpy(dtype=float)

# Oblicz średnią arytmetyczną przy użyciu NumPy
srednia = np.mean(srednie_wartosci)

# Oblicz odchylenie standardowe próbki z korekcją ddof=1 (zgodne z pandas std())
odchylenie = np.std(srednie_wartosci, ddof=1)

# Wypisz nagłówek wyników na konsolę
print(f"--- WYNIKI ---")

# Wypisz średnią sformatowaną do 2 miejsc po przecinku
print(f"Średnia inflacja: {srednia:.2f}")

# Wypisz odchylenie standardowe sformatowane do 2 miejsc po przecinku
print(f"Odchylenie standardowe: {odchylenie:.2f}")

# Utwórz nową figurę o rozmiarze 10x6 cala
plt.figure(figsize=(10, 6))

# Narysuj liniowy wykres: oś X = lata, oś Y = wartości analizy
plt.plot(plik['Rok'], plik[kolumna_do_analizy], color='red', linestyle='-', label='Inflacja')

# Ustaw tytuł wykresu
plt.title('Wskaźnik inflacji (GUS)')

# Opis osi X
plt.xlabel('Rok')

# Opis osi Y
plt.ylabel('Wartość')

# Włącz siatkę wykresu
plt.grid(True)

# Wyświetl legendę (etykieta z `label` w plt.plot)
plt.legend()

# Pokaż wykres w oknie (dla środowisk z GUI)
plt.show()

# Informacja po wyświetleniu wykresu
print("Wykres został wyświetlony.")
