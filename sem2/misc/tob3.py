import numpy as np
import matplotlib.pyplot as plt

# Parametry elementów
C = 10e-6    # 10 uF
Lp = 0.5e-6  # 0.5 uH
Rp = 0.5     # 0.5 Ohm

# Wyznaczone pulsacje załamania
w1 = (5 - np.sqrt(5)) * 1e5
w2 = (5 + np.sqrt(5)) * 1e5

# Zakres pulsacji do wykresu (skala logarytmiczna)
w = np.logspace(4, 7, 1000)

# Obliczenie dokładnej charakterystyki w dB
H_exact = 1 + 1j * w * Rp * C - w**2 * Lp * C
mag_exact_dB = 20 * np.log10(np.abs(H_exact))

# Obliczenie aproksymowanej charakterystyki Bodego (asymptot)
mag_approx_dB = np.zeros_like(w)
for i, wi in enumerate(w):
    if wi < w1:
        mag_approx_dB[i] = 0
    elif wi < w2:
        mag_approx_dB[i] = 20 * np.log10(wi / w1)
    else:
        mag_approx_dB[i] = 20 * np.log10(w2 / w1) + 40 * np.log10(wi / w2)

# Konfiguracja wykresu
plt.figure(figsize=(10, 6))
plt.semilogx(w, mag_exact_dB, label='Dokładna charakterystyka', color='black')
plt.semilogx(w, mag_approx_dB, label='Asymptotyczna charakterystyka Bodego', color='red', linestyle='--')

# Zaznaczenie pulsacji załamania
plt.axvline(w1, color='blue', linestyle=':', label=f'$\\omega_1 \\approx {w1:.2e}$ rad/s')
plt.axvline(w2, color='green', linestyle=':', label=f'$\\omega_2 \\approx {w2:.2e}$ rad/s')

# Opisy i legenda
plt.title('Charakterystyka amplitudowa Bodego stosunku impedancji')
plt.xlabel('Pulsacja $\\omega$ [rad/s]')
plt.ylabel('Moduł $|Z_{rzecz} / Z_{ideal}|$ [dB]')
plt.grid(True, which="both", ls="--")
plt.legend()

# Zapisanie lub wyświetlenie wykresu
plt.show()
