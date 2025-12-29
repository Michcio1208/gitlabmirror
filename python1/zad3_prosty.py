import numpy             # Wymagane w zadaniu 
import matplotlib.pyplot as plt  # Wymagane w zadaniu [cite: 32]

# -- KROK 1: Wczytanie danych (najprostsza metoda bez modułu csv) --
# Tworzymy pusty słownik, tak jak w materiałach: empy_dict = {}
dane_inflacja = {}

# Otwieramy plik. Zakładamy, że plik nazywa się 'inflacja.csv' i jest w tym samym folderze.
# Używamy kodowania 'utf-8' lub 'latin-1' (zależy od pliku GUS).
plik = open('rocznewskaznikicentowarowiuslugkonsumpcyjnychod1950roku.csv', 'r') 

# Wczytujemy wszystkie linie do listy
linie = plik.readlines()
plik.close() # Pamiętamy o zamknięciu pliku

# Przechodzimy przez pętlę (pomijamy pierwszą linię, jeśli to nagłówek)
for linia in linie[1:]: # slicing [1:] pomija nagłówek
    linia = linia.strip() # usuwamy białe znaki z końca/początku
    
    # Zakładamy, że dane w GUS są oddzielone średnikiem (np. 2023;11.4)
    # Metoda split tworzy listę elementów
    elementy = linia.split(';') 
    
    if len(elementy) >= 2:
        # Pobieramy rok (indeks 0) i wskaźnik (indeks 1)
        rok = int(elementy[0])
        
        # W plikach polskich separatorem jest często przecinek, zamieniamy na kropkę
        wartosc_napis = elementy[1].replace(',', '.')
        wskaznik = float(wartosc_napis)
        
        # Zapisujemy do słownika: klucz to rok, wartość to wskaźnik 
        dane_inflacja[rok] = wskaznik

print("Wczytano dane:", dane_inflacja)

# -- KROK 2: Obliczenia (Numpy) --
# Pobieramy same wartości ze słownika, aby policzyć średnią
lista_wartosci = list(dane_inflacja.values())

# Obliczamy średnią i odchylenie standardowe 
srednia = numpy.mean(lista_wartosci)
odchylenie = numpy.std(lista_wartosci)

print(f"Średnia inflacja: {srednia:.2f}")
print(f"Odchylenie standardowe: {odchylenie:.2f}")

# -- KROK 3: Wykres (Matplotlib) --
# Potrzebujemy listy lat (oś X) i wskaźników (oś Y)
# Metoda keys() zwraca klucze, values() zwraca wartości
lata = list(dane_inflacja.keys())
wartosci = list(dane_inflacja.values())

# Rysujemy wykres linią ciągłą w kolorze czerwonym [cite: 33]
plt.plot(lata, wartosci, color='red', linestyle='-')

# Dodajemy tytuł i opisy osi [cite: 33]
plt.title("Wskaźnik inflacji na przestrzeni lat")
plt.xlabel("Rok")
plt.ylabel("Wartość wskaźnika")

plt.show() # Wyświetlenie wykresu [cite: 32]