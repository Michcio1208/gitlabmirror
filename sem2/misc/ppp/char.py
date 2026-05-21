import numpy as np
import matplotlib.pyplot as plt

# Ustawienia globalne dla czytelności wykresów
plt.style.use('default')
plt.rcParams['font.size'] = 11

# ==============================================================================
# 1. Charakterystyki wyjściowe BJT w konfiguracji WE (Wspólnego Emitera)
# ==============================================================================
Uce = np.linspace(0, 15, 500)
Ib_values = np.array([10e-6, 20e-6, 30e-6, 40e-6]) # Prądy bazy od 10 uA do 40 uA
beta = 100      # Idealny współczynnik wzmocnienia prądowego
Va = 100        # Napięcie Early'ego [V]

plt.figure(figsize=(10, 6))
for Ib in Ib_values:
    # Model uwzględniający obszar nasycenia (przybliżenie exp) oraz zjawisko Early'ego w pr. aktywnej
    Ic = beta * Ib * (1 + Uce / Va) * (1 - np.exp(-Uce / 0.2))
    plt.plot(Uce, Ic * 1000, linewidth=2, label=f'$I_B$ = {Ib*1e6:.0f} µA')

plt.title('1. Charakterystyki wyjściowe tranzystora npn (Konfiguracja WE)')
plt.xlabel('Napięcie Kolektor-Emiter, $U_{CE}$ [V]')
plt.ylabel('Prąd Kolektora, $I_C$ [mA]')
plt.axvline(x=0.5, color='red', linestyle='--', alpha=0.7, label='Umowna granica nasycenia')
plt.grid(True, which='both', linestyle='--')
plt.legend(loc='lower right')
plt.tight_layout()
plt.show()

# ==============================================================================
# 2. Charakterystyki wejściowe BJT w konfiguracji WE
# ==============================================================================
Ube = np.linspace(0, 0.8, 500)
Uce_values = [0, 5]
Is = 1e-14
Vt = 0.026 # Napięcie termiczne (26 mV w 300K)

plt.figure(figsize=(10, 6))
for Uce_val in Uce_values:
    # Przybliżony model pokazujący spadek prądu Ib na skutek modulacji szerokości bazy (efekt Early'ego)
    Ib = Is * np.exp(Ube / Vt) * (1 - (Uce_val / 150)) 
    # Ograniczenie wartości odciętych do zera
    Ib = np.where(Ib < 0, 0, Ib)
    plt.plot(Ube, Ib * 1e6, linewidth=2, label=f'$U_{{CE}}$ = {Uce_val} V')

plt.title('2. Charakterystyki wejściowe tranzystora npn (Konfiguracja WE)')
plt.xlabel('Napięcie Baza-Emiter, $U_{BE}$ [V]')
plt.ylabel('Prąd Bazy, $I_B$ [µA]')
plt.ylim(-5, 60)
plt.xlim(0.4, 0.8)
plt.grid(True, which='both', linestyle='--')
plt.legend(loc='upper left')
plt.tight_layout()
plt.show()

# ==============================================================================
# 3. Zależność modułu współczynnika wzmocnienia prądowego |h21e| od częstotliwości
# ==============================================================================
f = np.logspace(5, 10, 500) # Skala od 100 kHz do 10 GHz
h21e0 = 100                 # Wzmocnienie stałoprądowe
f_beta = 20e6               # Częstotliwość graniczna 3dB (20 MHz)

# Obliczanie modułu
h21e_mag = h21e0 / np.sqrt(1 + (f / f_beta)**2)
h21e_mag_db = 20 * np.log10(h21e_mag)

plt.figure(figsize=(10, 6))
plt.semilogx(f, h21e_mag_db, color='blue', linewidth=2.5, label='$|h_{21e}(f)|$')

# Zaznaczanie kluczowych częstotliwości granicznych
plt.axvline(x=f_beta, color='green', linestyle='--', label=f'$f_\\beta$ = {f_beta/1e6:.0f} MHz (Granica 3dB)')
f_T = h21e0 * f_beta # Częstotliwość jednościowa
plt.axvline(x=f_T, color='red', linestyle='--', label=f'$f_T$ = {f_T/1e9:.0f} GHz (Pole wzmocnienia)')
plt.axhline(y=0, color='black', linestyle='-', linewidth=1)
plt.axhline(y=20*np.log10(h21e0) - 3, color='gray', linestyle=':', label='Spadek o 3 dB')

plt.title('3. Wykres Bode\'go współczynnika wzmocnienia prądowego $|h_{21e}|$')
plt.xlabel('Częstotliwość, $f$ [Hz]')
plt.ylabel('Moduł $|h_{21e}|$ [dB]')
plt.ylim(-20, 50)
plt.grid(True, which='both', linestyle=':')
plt.legend(loc='lower left')
plt.tight_layout()
plt.show()