import numpy as np
import matplotlib.pyplot as plt

# Parametry obwodu
R = 1000      # Rezystancja w Ohmach (1 kOhm)
C = 1e-6      # Pojemność w Faradach (1 uF)
tau = R * C   # Stała czasowa

# Wektor pulsacji od 10 do 10^5 rad/s
omega = np.logspace(1, 5, 500)

# Moduł transmitancji |H(jw)| = 1 / sqrt(1 + (w*RC)^2)
H_mod_linear = 1 / np.sqrt(1 + (omega * tau)**2)
H_mod_dB = 20 * np.log10(H_mod_linear) # Skala decybelowa

# Generowanie wykresu
plt.figure(figsize=(10, 6))
plt.semilogx(omega, H_mod_dB, color='blue', linewidth=2, label=r'$|H(\omega)| = \frac{1}{\sqrt{1+(\omega RC)^2}}$')

# Zaznaczenie punktu dla omega = 1000 rad/s
w_zad = 1000
H_zad_dB = 20 * np.log10(1 / np.sqrt(1 + (w_zad * tau)**2))
plt.scatter([w_zad], [H_zad_dB], color='red', zorder=5)
plt.annotate(f'$\omega = {w_zad}$ rad/s\n$|H| = -3$ dB', 
             xy=(w_zad, H_zad_dB), xytext=(w_zad*1.5, H_zad_dB + 2),
             arrowprops=dict(facecolor='black', arrowstyle='->'))

# Formatowanie wykresu
plt.title('Charakterystyka amplitudowa (Bode) filtru dolnoprzepustowego RC', fontsize=14)
plt.xlabel('Pulsacja $\omega$ [rad/s]', fontsize=12)
plt.ylabel('Moduł transmitancji $|H(\omega)|$ [dB]', fontsize=12)
plt.grid(True, which="both", ls="--", alpha=0.6)
plt.legend(fontsize=12)
plt.axhline(0, color='black', linewidth=1)
plt.show()