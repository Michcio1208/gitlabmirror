import numpy as np
import matplotlib.pyplot as plt

# Definicja parametrów
E = 5.0
tau_1 = 2.266e-3
tau_2 = 52.93e-6
tau_G = 2.2e-3

# Wektor czasu od 0 do 10 ms (aby uchwycić pełny proces ładowania)
t = np.linspace(0, 10e-3, 1000)

# Metoda dokładna (Laplace'a)
coeff_1 = tau_1 / (tau_1 - tau_2)
coeff_2 = tau_2 / (tau_1 - tau_2)
U_C2_exact = E * (1 - coeff_1 * np.exp(-t / tau_1) + coeff_2 * np.exp(-t / tau_2))

# Metoda przybliżona (Czoła i Grzbietu)
U_C2_approx = E * (1 - np.exp(-t / tau_G))

# Rysowanie wykresu
plt.figure(figsize=(10, 6))
plt.plot(t * 1000, U_C2_exact, label='Metoda dokładna (Laplace)', linewidth=2.5, color='blue')
plt.plot(t * 1000, U_C2_approx, label='Metoda przybliżona (Czoła i Grzbietu)', linestyle='--', linewidth=2, color='red')

# Formatowanie wykresu
plt.title('Przebieg napięcia na pojemności C2 w stanie nieustalonym', fontsize=14)
plt.xlabel('Czas [ms]', fontsize=12)
plt.ylabel('Napięcie $U_{C2}$ [V]', fontsize=12)
plt.grid(True, linestyle=':', alpha=0.7)
plt.legend(fontsize=11)
plt.xlim(0, 10)
plt.ylim(0, 5.2)

# Wyświetlenie
plt.tight_layout()
plt.show()