import numpy as np
import matplotlib.pyplot as plt

# Konfiguracja stylu wykresów
plt.style.use('bmh')
fig = plt.figure(figsize=(14, 12))
fig.canvas.manager.set_window_title('Wykresy do kolokwium - Podstawy Przyrządów Półprzewodnikowych')

# =====================================================================
# WYKRES 1: Charakterystyki wyjściowe BJT w konfiguracji WE
# =====================================================================
ax1 = fig.add_subplot(2, 2, 1)
U_CE = np.linspace(0, 10, 500)
V_A = 50       # Napięcie Early'ego [V]
beta = 100     # Współczynnik wzmocnienia prądowego
I_B_vals = [10, 20, 30, 40, 50] # Wartości prądu bazy [mikroampery]

for I_B in I_B_vals:
    # Modelowanie zakresu nasycenia (łagodne wejście) i zakresu aktywnego (efekt Early'ego)
    I_C = beta * I_B * (1 + U_CE / V_A) * (1 - np.exp(-U_CE / 0.05))
    ax1.plot(U_CE, I_C / 1000, label=f'$I_B$ = {I_B} $\mu$A', linewidth=2)

ax1.set_title('1. Charakterystyki wyjściowe BJT (Układ WE)', fontsize=13, fontweight='bold')
ax1.set_xlabel('Napięcie Kolektor-Emiter $U_{CE}$ [V]', fontsize=11)
ax1.set_ylabel('Prąd Kolektora $I_C$ [mA]', fontsize=11)
ax1.grid(True, linestyle='--', alpha=0.7)
ax1.legend(title='Prąd bazy (parametr)', loc='lower right')

# =====================================================================
# WYKRES 2: Przełączanie quasi-prądowe diody (Wyłączanie)
# =====================================================================
ax2 = fig.add_subplot(2, 2, 2)
t = np.linspace(-10, 50, 600)
I_F = 10  # Prąd przewodzenia [mA]
I_R = 5   # Wymuszony prąd wsteczny [mA]
t_s = 15  # Czas magazynowania [ns]
tau = 5   # Czas życia nośników/stała czasowa [ns]

# Funkcja sklejana (piecewise) dla prądu przełączania diody
I_diody = np.piecewise(
    t, 
    [t < 0, (t >= 0) & (t <= t_s), t > t_s],
    [I_F, -I_R, lambda t: -I_R * np.exp(-(t - t_s) / tau)]
)

ax2.plot(t, I_diody, color='firebrick', linewidth=2.5, label='Prąd diody $I(t)$')
ax2.axhline(0, color='black', linewidth=1)
ax2.axvline(0, color='gray', linestyle='--')
ax2.axvline(t_s, color='gray', linestyle='--', label='Koniec fazy magazynowania ($t_s$)')

ax2.annotate(
    'Faza\nmagazynowania', 
    xy=(t_s / 2, -I_R), xycoords='data',
    xytext=(t_s / 2, -I_R + 3), textcoords='data',
    ha='center', arrowprops=dict(arrowstyle="->", connectionstyle="arc3")
)

ax2.set_title('2. Przełączanie impulsowe diody p-n', fontsize=13, fontweight='bold')
ax2.set_xlabel('Czas $t$ [ns]', fontsize=11)
ax2.set_ylabel('Prąd $I$ [mA]', fontsize=11)
ax2.legend(loc='upper right')

# =====================================================================
# WYKRES 3: Moduł wzmocnienia prądowego zwarciowego |h21e| od f
# =====================================================================
ax3 = fig.add_subplot(2, 1, 2)  # Zajmuje cały dolny rząd
f = np.logspace(4, 10, 500)     # Zakres od 10 kHz do 10 GHz
h21e0 = 100                     # Statyczne wzmocnienie prądowe
f_beta = 1e6                    # Częstotliwość graniczna 3 dB [1 MHz]
f_T = h21e0 * f_beta            # Częstotliwość tranzytowa [100 MHz]

# Model jednobiegunowy filtru dolnoprzepustowego z obwodu hybryd-pi
h21e_mag = h21e0 / np.sqrt(1 + (f / f_beta)**2)

ax3.loglog(f, h21e_mag, color='indigo', linewidth=2.5, label='$|h_{21e}(f)|$')
ax3.axhline(h21e0, color='gray', linestyle='--', label='Wzmocnienie stałoprądowe $h_{21e0}$')
ax3.axhline(1, color='red', linestyle='--', label='Wzmocnienie jednostkowe (0 dB)')
ax3.axvline(f_beta, color='royalblue', linestyle=':', linewidth=2, label=f'Graniczna $f_\\beta$ = 1 MHz')
ax3.axvline(f_T, color='forestgreen', linestyle=':', linewidth=2, label=f'Tranzytowa $f_T$ = 100 MHz')

ax3.set_title('3. Zależność modułu wzmocnienia zwarciowego $|h_{21e}|$ od częstotliwości', fontsize=13, fontweight='bold')
ax3.set_xlabel('Częstotliwość $f$ [Hz] (skala logarytmiczna)', fontsize=11)
ax3.set_ylabel('Moduł $|h_{21e}|$', fontsize=11)
ax3.grid(True, which="both", ls="--", alpha=0.5)
ax3.legend(loc='lower left')

# Renderowanie układu
plt.tight_layout()
plt.show()