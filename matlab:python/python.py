import numpy as np
import matplotlib.pyplot as plt

# 1. Wczytanie danych [cite: 78]
# Plik zawiera jedną liczbę w linii, wczytujemy do tablicy numpy
data = np.loadtxt('covid1.txt')

# 2. Wybór zakresu danych
# MATLAB: 184 do 214 (włącznie)
# Python (indeksowanie od 0): 
# Indeks 184 w Matlabie to indeks 183 w Pythonie.
# Zakres slice: 183 do 214 (bo w Pythonie koniec zakresu jest otwarty/exclusive)
start_idx = 183
end_idx = 214
x = data[start_idx:end_idx]

# Sprawdzenie długości (powinno być 31 dni)
N = len(x)
print(f"Analizowana liczba dni: {N}")

# 3. Obliczenie współczynnika k (Wzór 4) 
# Suma x[n]*x[n+1] / Suma x[n]^2
# W Pythonie wektor x[n] to x[:-1], a x[n+1] to x[1:]
licznik_k = np.sum(x[:-1] * x[1:])
mianownik_k = np.sum(x[:-1]**2)
k = licznik_k / mianownik_k

print(f"Współczynnik transmisji wirusa (k): {k:.4f}")

# 4. Obliczenie x1 (Wzór 8) [cite: 42, 82]
# Suma k^n * x[n+1] / Suma (k^n)^2
# n biegnie od 1 do N-1
n_vec = np.arange(1, N) # Tworzy wektor [1, 2, ..., N-1]
wektorK = k ** n_vec

licznik_x1 = np.sum(wektorK * x[1:])
mianownik_x1 = np.sum(wektorK ** 2)
x1 = licznik_x1 / mianownik_x1

print(f"Liczba zakażeń pierwszego dnia (x1): {x1:.4f}")

# 5. Wyznaczenie predykcji xn (Wzór 9) [cite: 46, 83]
# x[n] = x1 * k^(n-1) dla n=1..N
# Wykładniki potęgi to 0, 1, ..., N-1
potegi = np.arange(0, N)
xn = x1 * (k ** potegi)

# 6. Wykres [cite: 83]
days = np.arange(184, 215) # Oś X zgodna z dniami pandemii

plt.figure(figsize=(10, 6))
plt.plot(days, x, 'b.-', label='Dane rzeczywiste')
plt.plot(days, xn, 'r--', label='Model estymowany')
plt.title('Liczba zakażeń od 184 do 214 dnia pandemii (Python)')
plt.xlabel('Dzień pandemii')
plt.ylabel('Liczba zakażeń')
plt.legend()
plt.grid(True)
plt.show()