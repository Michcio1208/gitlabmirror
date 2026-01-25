import numpy as np
import matplotlib.pyplot as plt

# 1. Wczytanie i przygotowanie danych
# Plik covid1.txt zawiera spacje jako separatory tysięcy (np. "1 306"),
# które trzeba usunąć przed konwersją na liczby.
data = []
with open('covid1.txt', 'r') as f:
    for line in f:
        clean_line = line.strip().replace(' ', '').replace('\xa0', '')
        if clean_line:
            data.append(float(clean_line))

data = np.array(data)

# 2. Wybór zakresu danych (dni 184-214)
# MATLAB (indeksowanie od 1): 184:214
# Python (indeksowanie od 0): 183:214 (zakres prawostronnie otwarty, pobiera 31 elementów)
start_idx = 183
end_idx = 214
x = data[start_idx:end_idx]

N = len(x) # Liczba analizowanych dni (31)

# 3. Wyznaczenie współczynnika k (Wzór 4)
# Licznik: suma x[n] * x[n+1]
# Mianownik: suma x[n]^2
# W Pythonie x[n] to x[:-1] (wszystkie oprócz ostatniego),
# a x[n+1] to x[1:] (wszystkie od drugiego).
numerator_k = np.sum(x[:-1] * x[1:])
denominator_k = np.sum(x[:-1]**2)
k = numerator_k / denominator_k

print(f"Współczynnik transmisji wirusa: {k:.4f}")

# 4. Wyznaczenie estymatora zakażeń pierwszego dnia (Wzór 8)
# Licznik: suma k^n * x[n+1]
# Mianownik: suma (k^n)^2
# n idzie od 1 do N-1
n_range = np.arange(1, N)       # wektor n = [1, 2, ..., 30]
k_powers = k ** n_range         # wektor k^n
x_targets = x[1:]               # wektor x[n+1] (czyli od x[2] w notacji matematycznej)

numerator_x1 = np.sum(k_powers * x_targets)
denominator_x1 = np.sum(k_powers**2)
x1_tilde = numerator_x1 / denominator_x1

print(f"Liczba zakażeń pierwszego dnia: {x1_tilde:.4f}")

# 5. Wyznaczenie estymaty dla kolejnych dni (Wzór 9)
# x_tilde[n] = k^(n-1) * x1_tilde
# Tworzymy wektor potęg dla dni od 0 do N-1 (bo pierwszy dzień to k^0)
days_powers = np.arange(0, N)
x_estimates = (k ** days_powers) * x1_tilde

# 6. Prezentacja wyników na wykresie
days_axis = np.arange(184, 184 + N) # Oś czasu zgodna z dniami pandemii

plt.figure(figsize=(10, 6))
plt.plot(days_axis, x, 'b.-', label='Dane rzeczywiste')
plt.plot(days_axis, x_estimates, 'r--', label='Model estymowany')
plt.title('Liczba zakażeń od 184 do 214 dnia pandemii (Python)')
plt.xlabel('Dzień pandemii')
plt.ylabel('Liczba zakażeń')
plt.legend()
plt.grid(True)
plt.show() # W środowisku Jupyter/Notebook pominąć lub użyć savefig