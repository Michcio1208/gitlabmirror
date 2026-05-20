import numpy as np
import matplotlib.pyplot as plt

# Napięcie w kierunku przewodzenia [V]
U = np.linspace(0.1, 0.8, 100)
Vt = 0.025  # Napięcie termiczne [V]

# Parametry teoretyczne prądów
I_diff_1 = 1e-14 * np.exp(U / Vt)         # Prąd dyfuzyjny diody 1
I_diff_2 = I_diff_1                       # Prądy dyfuzyjne równe zgodnie z pkt. a)

# Prąd rekombinacji w warstwie zaporowej
I_rek_1 = 1e-9 * np.exp(U / (2 * Vt))
I_rek_2 = 3.16e-10 * np.exp(U / (2 * Vt)) 

# Prąd całkowity
I_tot_1 = I_diff_1 + I_rek_1
I_tot_2 = I_diff_2 + I_rek_2

plt.figure(figsize=(8, 6))
# Zastosowano "r" przed ciągami znaków zawierającymi komendy LaTeX
plt.plot(U, np.log10(I_tot_1), label=r'Dioda 1 ($N_{A1}$, $w_1=2L_n$)', color='blue', linewidth=2)
plt.plot(U, np.log10(I_tot_2), label=r'Dioda 2 ($10 N_{A1}$, $w_2 \approx 0.1L_n$)', color='red', linestyle='--', linewidth=2)

# Oznaczenia asymptot i nachyleń
plt.text(0.2, -6, 'Rejon rekombinacyjny\n(nachylenie m=2)', fontsize=10, color='gray')
plt.text(0.55, -2, 'Rejon dyfuzyjny\n(nachylenie m=1)', fontsize=10, color='gray')

plt.title(r'Charakterystyka $lg(I) = f(U)$ złączy krzemowych dla polaryzacji przewodzenia', fontsize=12)
plt.xlabel('Napięcie polaryzacji U [V]', fontsize=11)
plt.ylabel('lg(I) [A]', fontsize=11)
plt.grid(True, which='both', linestyle=':', alpha=0.7)
plt.legend()
plt.tight_layout()
plt.show()