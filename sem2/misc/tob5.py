import numpy as np
import matplotlib.pyplot as plt

# Parametry układu
R = 1000.0  # Ohm
C = 1e-6    # F
w_signal = 1000.0  # rad/s

# Zakres pulsacji: od 10 rad/s do 100 krad/s
w = np.logspace(1, 5, 500)
# Obliczenie modułu transmitancji H(jw)
H_mag = 1 / np.sqrt(1 + (w * R * C)**2)
# Przeliczenie na decybele
H_mag_dB = 20 * np.log10(H_mag)

# Punkt dla sygnału z zadania
H_signal_dB = 20 * np.log10(1 / np.sqrt(1 + (w_signal * R * C)**2))

# Inicjalizacja figury
plt.figure(figsize=(10, 6))
plt.semilogx(w, H_mag_dB, label=r'Moduł transmitancji $|H(j\omega)|$', color='blue', linewidth=2)
plt.scatter([w_signal], [H_signal_dB], color='red', zorder=5, 
            label=f'Pobudzenie AC ($\omega={w_signal}$ rad/s, tłumienie: {H_signal_dB:.1f} dB)')

# Formaty i opisy
plt.title('Charakterystyka amplitudowa filtru dolnoprzepustowego RC', fontsize=14, fontweight='bold')
plt.xlabel('Pulsacja $\omega$ [rad/s]', fontsize=12)
plt.ylabel('Moduł transmitancji [dB]', fontsize=12)

# Konfiguracja siatki i linii odniesienia
plt.grid(True, which="both", ls="--", alpha=0.6)
w_cutoff = 1 / (R * C)
plt.axvline(w_cutoff, color='gray', linestyle=':', 
            label=f'Pulsacja graniczna ({w_cutoff:.0f} rad/s)')

plt.legend(loc='lower left', fontsize=11)
plt.tight_layout()

# Wyświetlenie wykresu
plt.show()