import pandas as pd
import matplotlib.pyplot as plt
import os

nazwa_pliku = 'inflacja.csv'

print("--- DIAGNOSTYKA ---")
# 1. Sprawdzenie, gdzie Python szuka pliku
katalog_roboczy = os.getcwd()
print(f"1. Python pracuje w katalogu: {katalog_roboczy}")

# 2. Sprawdzenie, czy plik tam fizycznie jest
if not os.path.exists(nazwa_pliku):
    print(f"BŁĄD KRYTYCZNY: Plik '{nazwa_pliku}' nie istnieje w powyższym katalogu!")
    print("ROZWIĄZANIE: Przenieść plik CSV do tego samego folderu co skrypt .py")
    exit() # Zatrzymujemy program
else:
    print(f"2. Plik '{nazwa_pliku}' został znaleziony. Próbuję wczytać...")

# 3. Próba wczytania z różnymi ustawieniami (kodowanie/separator)
    # Najpierw próbujemy standardowe kodowanie dla polskich Exceli (cp1250)
    plik = pd.read_csv(nazwa_pliku, sep=';', encoding='cp1250')


print("2. Plik wczytany poprawnie. Przetwarzanie danych...")

# --- WŁAŚCIWA ANALIZA (Zadanie 3) ---

try:
    # Zamiana przecinka na kropkę w kolumnie 'Wartość'
    # Uwaga: Twoja kolumna nazywa się 'Wartość', a nie 'Wskaznik'
    if 'Wartość' in plik.columns:
        plik['Wartość_liczba'] = plik['Wartość'].astype(str).str.replace(',', '.').astype(float)
        kolumna_do_analizy = 'Wartość_liczba'
    elif 'Wskaznik' in plik.columns: # Na wypadek innej nazwy
         plik['Wartość_liczba'] = plik['Wskaznik'].astype(str).str.replace(',', '.').astype(float)
         kolumna_do_analizy = 'Wartość_liczba'
    else:
        print(f"BŁĄD: Nie widzę kolumny 'Wartość'. Dostępne kolumny: {plik.columns}")
        exit()

    # Sortowanie
    plik = plik.sort_values('Rok')

    # Obliczenia
    srednia = plik[kolumna_do_analizy].mean()
    odchylenie = plik[kolumna_do_analizy].std()

    print(f"\n--- WYNIKI ---")
    print(f"Średnia inflacja: {srednia:.2f}")
    print(f"Odchylenie standardowe: {odchylenie:.2f}")

    # Wykres
    plt.figure(figsize=(10, 6))
    plt.plot(plik['Rok'], plik[kolumna_do_analizy], color='red', linestyle='-', label='Inflacja')
    plt.title('Wskaźnik inflacji (GUS)')
    plt.xlabel('Rok')
    plt.ylabel('Wartość')
    plt.grid(True)
    plt.legend()
    plt.show()
    print("Wykres został wyświetlony.")

except Exception as e:
    print(f"Wystąpił błąd podczas obliczeń lub rysowania: {e}")