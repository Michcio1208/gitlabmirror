import numpy as np
import matplotlib.pyplot as plt

# Parametry przykładowe z wykładu (str. 27, 34)
beta = 1.5e-3  # Współczynnik materiałowo-konstrukcyjny [A/V^2]
U_T = 0.71     # Napięcie progowe [V]

# Konfiguracja obszaru roboczego
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

# --- Zadanie 2: Rodzina charakterystyk wyjściowych ---
U_DS = np.linspace(0, 4, 300)
U_GS_values = [1.0, 1.5, 2.0, 2.5, 3.0]

for U_GS in U_GS_values:
    I_D = np.zeros_like(U_DS)
    U_DSsat = max(0, U_GS - U_T) # Napięcie nasycenia
    for i, u in enumerate(U_DS):
        if u <= U_DSsat: # Zakres nienasycenia
            I_D[i] = beta * ((U_GS - U_T) * u - 0.5 * u**2) * 1000 # Wynik w mA
        else: # Zakres nasycenia
            I_D[i] = beta * ((U_GS - U_T)**2) / 2 * 1000 # Wynik w mA
            
    if U_GS > U_T:
        ax1.plot(U_DS, I_D, label=f'$U_{{GS}}$ = {U_GS} V')

# Linia podziału zakresów (parabola nasycenia IDsat)
U_DS_sat_line = np.linspace(0, 3.5, 100)
I_D_sat_line = (beta * U_DS_sat_line**2 / 2) * 1000
ax1.plot(U_DS_sat_line, I_D_sat_line, color='gray', linestyle='--', linewidth=2, label='$I_D = I_{Dsat}$')

ax1.set_title('Charakterystyki wyjściowe tranzystora MOS')
ax1.set_xlabel('Napięcie dren-źródło $U_{DS}$ [V]')
ax1.set_ylabel('Prąd drenu $I_D$ [mA]')
ax1.text(0.5, 3.0, 'ZAKRES\nNIENASYCENIA', fontsize=10, fontweight='bold')
ax1.text(2.5, 1.5, 'ZAKRES\nNASYCENIA', fontsize=10, fontweight='bold')
ax1.grid(True)
ax1.legend()

# --- Zadanie 3: Rodzina charakterystyk przejściowych ---
U_GS_arr = np.linspace(0, 3.5, 300)
U_DS_fixed_values = [0.5, 1.0, 3.0]

for U_DS_fixed in U_DS_fixed_values:
    I_D_trans = np.zeros_like(U_GS_arr)
    for i, u_gs in enumerate(U_GS_arr):
        if u_gs <= U_T:
            I_D_trans[i] = 0 # Ignorujemy tu precyzyjny prąd podprogowy dla czytelności zjawisk makro
        else:
            U_DSsat = u_gs - U_T
            if U_DS_fixed <= U_DSsat: # Zakres nienasycenia
                I_D_trans[i] = beta * ((u_gs - U_T) * U_DS_fixed - 0.5 * U_DS_fixed**2) * 1000
            else: # Zakres nasycenia
                I_D_trans[i] = beta * ((u_gs - U_T)**2) / 2 * 1000
                
    ax2.plot(U_GS_arr, I_D_trans, label=f'$U_{{DS}}$ = {U_DS_fixed} V')

ax2.axvline(x=U_T, color='black', linestyle=':', label='Napięcie progowe $U_T$')
ax2.set_title('Charakterystyki przejściowe tranzystora MOS')
ax2.set_xlabel('Napięcie bramka-źródło $U_{GS}$ [V]')
ax2.set_ylabel('Prąd drenu $I_D$ [mA]')
ax2.text(0.2, 2.0, 'Zakres\npodprogowy', rotation=90, fontsize=10)
ax2.text(1.2, 0.4, 'Nasycenie', fontsize=10, fontweight='bold')
ax2.text(2.2, 0.5, 'Nienasycenie', fontsize=10, fontweight='bold')
ax2.grid(True)
ax2.legend()

plt.tight_layout()
plt.show()