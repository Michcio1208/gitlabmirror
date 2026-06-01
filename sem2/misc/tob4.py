import numpy as np
import matplotlib.pyplot as plt

# ---------------------------------------------------------
# Parametry układu dla Zadania 4.2 (N=7)
# ---------------------------------------------------------
E = 5.0                # Napięcie zasilania [V]
R1 = 1000.0            # Rezystancja R1 [Ohm]
R2 = 1200.0            # Rezystancja R2 [Ohm] (500 + 100*7)
C1 = 100e-9            # Pojemność C1 [F]
C2 = 1e-6              # Pojemność C2 [F]

# ---------------------------------------------------------
# Obliczenia stałych czasowych
# ---------------------------------------------------------
# 1. Metoda przybliżona "czoła i grzbietu"
tau_C_approx = ((R1 * R2) / (R1 + R2)) * C1  # Stała czoła (~54.5 us)
tau_G_approx = (R1 + R2) * C2                # Stała grzbietu (2.2 ms)

# 2. Metoda dokładna (pierwiastki równania charakterystycznego)
a = R1 * R2 * C1 * C2
b = R1 * C2 + R2 * C1 + R2 * C2
c = 1.0

delta = b**2 - 4 * a * c
s1 = (-b + np.sqrt(delta)) / (2 * a)
s2 = (-b - np.sqrt(delta)) / (2 * a)

tau_1 = -1 / s1  # Długa stała czasowa (~2.266 ms)
tau_2 = -1 / s2  # Krótka stała czasowa (~52.9 us)

# Współczynniki do wzoru dokładnego
k1 = tau_1 / (tau_1 - tau_2)
k2 = tau_2 / (tau_1 - tau_2)

# ---------------------------------------------------------
# Wektory czasu
# ---------------------------------------------------------
# t_full: do obserwacji grzbietu (0 do 12 ms)
t_full = np.linspace(0, 12e-3, 2000)
# t_zoom: do obserwacji czoła (0 do 0.3 ms)
t_zoom = np.linspace(0, 0.3e-3, 1000)

# ---------------------------------------------------------
# Funkcje napięcia UC2(t)
# ---------------------------------------------------------
# Przebieg dokładny z transformaty Laplace'a
uc2_exact_full = E * (1 - k1 * np.exp(-t_full / tau_1) + k2 * np.exp(-t_full / tau_2))
uc2_exact_zoom = E * (1 - k1 * np.exp(-t_zoom / tau_1) + k2 * np.exp(-t_zoom / tau_2))

# Przebieg przybliżony (pomija fazę czoła dla C2)
uc2_approx_full = E * (1 - np.exp(-t_full / tau_G_approx))
uc2_approx_zoom = E * (1 - np.exp(-t_zoom / tau_G_approx))

# ---------------------------------------------------------
# Wizualizacja (Wykresy)
# ---------------------------------------------------------
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
fig.suptitle('Analiza stanów nieustalonych dla układu (Zadanie 4.2)', fontsize=16, fontweight='bold')

# Wykres 1: Pełny proces (Grzbiet)
ax1.plot(t_full * 1000, uc2_exact_full, label='Metoda dokładna (Laplace)', color='#1f77b4', linewidth=2.5)
ax1.plot(t_full * 1000, uc2_approx_full, label='Uproszczenie czoła i grzbietu', color='#d62728', linestyle='--', linewidth=2.5)
ax1.set_title('Pełny proces ładowania (0 - 12 ms)', fontsize=13)
ax1.set_xlabel('Czas [ms]', fontsize=11)
ax1.set_ylabel('Napięcie $U_{C2}$ [V]', fontsize=11)
ax1.axhline(y=E, color='gray', linestyle=':', label='Stan ustalony (5V)')
ax1.grid(True, linestyle='--', alpha=0.7)
ax1.legend(loc='lower right')

# Wykres 2: Zoom na czoło (bardzo krótki czas)
ax2.plot(t_zoom * 1000, uc2_exact_zoom, label='Metoda dokładna (widoczny wpływ $\\tau_C$)', color='#1f77b4', linewidth=2.5)
ax2.plot(t_zoom * 1000, uc2_approx_zoom, label='Uproszczenie (tylko $\\tau_G$)', color='#d62728', linestyle='--', linewidth=2.5)
ax2.set_title('Faza czoła - zbliżenie (0 - 0.3 ms)', fontsize=13)
ax2.set_xlabel('Czas [ms]', fontsize=11)
ax2.set_ylabel('Napięcie $U_{C2}$ [V]', fontsize=11)
ax2.grid(True, linestyle='--', alpha=0.7)
ax2.legend(loc='upper left')

plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.show()