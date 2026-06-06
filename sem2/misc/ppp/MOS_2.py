import numpy as np
import matplotlib.pyplot as plt

# Konfiguracja ogólna wykresów
plt.style.use('seaborn-v0_8-whitegrid')

# ==========================================
# Figura 1: DC Zadanie 2 (Wyznaczanie napięcia progowego UT)
# ==========================================
fig1, ax0 = plt.subplots(figsize=(8, 6))
fig1.suptitle('DC Zadanie 2: Wyznaczanie napięcia progowego $U_T$', fontsize=14, fontweight='bold')

# Dane pomiarowe z tabeli
UGS_data = np.array([2, 3, 4, 5, 6, 7, 8])
ID_data_mA = np.array([0.25, 0.75, 1.35, 2.25, 3.5, 5.0, 7.0])
sqrt_ID = np.sqrt(ID_data_mA)

# Regresja liniowa dla punktów pomiarowych
coefs = np.polyfit(UGS_data, sqrt_ID, 1)
a, b = coefs
UT_est = -b / a  # Miejsce zerowe prostej (przecięcie z osią X)

# Linia trendu
UGS_line = np.linspace(0, 8.5, 100)
sqrt_ID_line = a * UGS_line + b

ax0.scatter(UGS_data, sqrt_ID, color='red', zorder=5, label='Dane pomiarowe $\\sqrt{I_D}$')
ax0.plot(UGS_line, sqrt_ID_line, color='black', linestyle='--', label='Linia trendu')
ax0.axvline(x=UT_est, color='blue', linestyle=':', label=f'Wyznaczone $U_T \\approx {UT_est:.2f}$ V')
ax0.axhline(y=0, color='gray', linewidth=1)

ax0.set_xlabel('$U_{GS}$ [V]')
ax0.set_ylabel('$\\sqrt{I_D}$ [$\\sqrt{mA}$]')
ax0.set_xlim(0, 8.5)
ax0.set_ylim(0, 3.0)
ax0.legend()
fig1.tight_layout()

# ==========================================
# Figura 2: DC Zadanie 4 (Wpływ różnych parametrów na NMOS-D)
# ==========================================
fig2, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(18, 5))
fig2.suptitle('DC Zadanie 4: Tranzystor NMOS z kanałem zubożanym (D-MOS)', fontsize=15, fontweight='bold')

U_GS = np.linspace(-3, 3, 100)

# a) Grubość tlenku
ax1.plot(U_GS, np.maximum(0, 2.0 * (U_GS - (-1.0)))**2, label='Cienki tlenek (duże $\\beta$, małe $|U_T|$)')
ax1.plot(U_GS, np.maximum(0, 1.0 * (U_GS - (-1.5)))**2, label='Gruby tlenek (małe $\\beta$, duże $|U_T|$)')
ax1.set_title('a) Wpływ grubości tlenku')
ax1.set_xlabel('$U_{GS}$ [V]')
ax1.set_ylabel('$I_D$ [j.w.]')
ax1.legend()

# b) Temperatura
ax2.plot(U_GS, np.maximum(0, 2.0 * (U_GS - (-1.0)))**2, label='Temp. $T_1$')
ax2.plot(U_GS, np.maximum(0, 1.5 * (U_GS - (-1.2)))**2, label='Temp. $T_2 > T_1$ (spadek ruchliwości)')
ax2.set_title('b) Wpływ temperatury')
ax2.set_xlabel('$U_{GS}$ [V]')
ax2.set_ylabel('$I_D$ [j.w.]')
ax2.legend()

# c) Napięcie źródło-podłoże
ax3.plot(U_GS, np.maximum(0, 2.0 * (U_GS - (-1.5)))**2, label='$U_{SB} = 0$ V')
ax3.plot(U_GS, np.maximum(0, 2.0 * (U_GS - (-0.5)))**2, label='$U_{SB} > 0$ V (wzrost $U_T$)')
ax3.set_title('c) Wpływ napięcia $U_{SB}$')
ax3.set_xlabel('$U_{GS}$ [V]')
ax3.set_ylabel('$I_D$ [j.w.]')
ax3.legend()

fig2.tight_layout()

# ==========================================
# Figura 3: DC Zadanie 5 i 6
# ==========================================
fig3, ax4 = plt.subplots(figsize=(8, 6))
fig3.suptitle('DC Zadanie 5 i 6: Charakterystyki ze zwartą bramką ($U_{GS} = U_{DS}$)', fontsize=14, fontweight='bold')

U_DS = np.linspace(0, 5, 100)
ax4.plot(U_DS, np.maximum(0, 1.0 * (-U_DS - (-0.5)))**2, color='red', linewidth=2, label='PMOS ($U_T = -0.5$ V)')
ax4.plot(U_DS, np.maximum(0, 1.0 * (U_DS - 0.5))**2, color='blue', linewidth=2, label='NMOS ($U_T = 0.5$ V)')
ax4.set_xlabel('$|U_{DS}|$ [V]')
ax4.set_ylabel('$|I_D|$ [j.w.]')
ax4.axvline(x=0.5, color='gray', linestyle='--', label='Punkt włączenia $|U_T| = 0.5$ V')
ax4.legend()

fig3.tight_layout()

# ==========================================
# Figura 4: AC Zadanie 1
# ==========================================
fig4, (ax5, ax6) = plt.subplots(1, 2, figsize=(14, 6))
fig4.suptitle('AC Zadanie 1: Parametry małosygnałowe w funkcji $U_{DS}$ i $U_{GS}$', fontsize=14, fontweight='bold')

beta = 30e-6
U_T = 1.0

# vs U_DS
U_DS_arr = np.linspace(0, 5, 100)
g_m_UDS = np.where(U_DS_arr < (3 - U_T), beta * U_DS_arr, beta * (3 - U_T))
g_ds_UDS = np.where(U_DS_arr < (3 - U_T), beta * (3 - U_T - U_DS_arr), 0)

ax5.plot(U_DS_arr, g_m_UDS * 1e6, linewidth=2, label='$g_m$')
ax5.plot(U_DS_arr, g_ds_UDS * 1e6, linewidth=2, label='$g_{ds}$')
ax5.set_title('W funkcji $U_{DS}$ (dla stałego $U_{GS} = 3$ V)')
ax5.set_xlabel('$U_{DS}$ [V]')
ax5.set_ylabel('Konduktancja [$\\mu$A/V]')
ax5.axvline(x=2.0, color='gray', linestyle=':', label='Granica nasycenia ($U_{DSat}$)')
ax5.legend()

# vs U_GS
U_GS_arr = np.linspace(0, 5, 100)
g_m_UGS = np.piecewise(U_GS_arr, [U_GS_arr <= U_T, (U_GS_arr > U_T) & (U_GS_arr <= 3), U_GS_arr > 3],
                       [0, lambda x: beta * (x - U_T), lambda x: beta * 2.0])
g_ds_UGS = np.piecewise(U_GS_arr, [U_GS_arr <= U_T, (U_GS_arr > U_T) & (U_GS_arr <= 3), U_GS_arr > 3],
                        [0, 0, lambda x: beta * (x - U_T - 2.0)])

ax6.plot(U_GS_arr, g_m_UGS * 1e6, linewidth=2, label='$g_m$')
ax6.plot(U_GS_arr, g_ds_UGS * 1e6, linewidth=2, label='$g_{ds}$')
ax6.set_title('W funkcji $U_{GS}$ (dla stałego $U_{DS} = 2$ V)')
ax6.set_xlabel('$U_{GS}$ [V]')
ax6.set_ylabel('Konduktancja [$\\mu$A/V]')
ax6.axvline(x=1.0, color='gray', linestyle=':', label='Punkt włączenia ($U_T$)')
ax6.axvline(x=3.0, color='black', linestyle=':', label='Granica nienasycenia')
ax6.legend()

fig4.tight_layout()

# ==========================================
# Figura 5: AC Zadanie 2
# ==========================================
fig5, (ax7, ax8) = plt.subplots(1, 2, figsize=(14, 6))
fig5.suptitle('AC Zadanie 2: Tranzystor PMOS w funkcji temperatury', fontsize=14, fontweight='bold')

U_GS_pmos = np.linspace(0, 5, 100)
beta_T1 = 50
beta_T2 = 30 # Symulacja spadku ruchliwości w wyższej temperaturze

ax7.plot(U_GS_pmos, 0.5 * beta_T1 * (np.maximum(0, U_GS_pmos - 1.0))**2, linewidth=2, label='$I_{Dsat}$ w $T_1$')
ax7.plot(U_GS_pmos, 0.5 * beta_T2 * (np.maximum(0, U_GS_pmos - 1.0))**2, linewidth=2, label='$I_{Dsat}$ w $T_2 > T_1$')
ax7.set_title('$I_{Dsat}$ w funkcji $|U_{GS}|$')
ax7.set_xlabel('$|U_{GS}|$ [V]')
ax7.set_ylabel('$|I_{Dsat}|$ [j.w.]')
ax7.legend()

ax8.plot(U_GS_pmos, beta_T1 * np.maximum(0, U_GS_pmos - 1.0), linewidth=2, label='$g_{msat}$ w $T_1$')
ax8.plot(U_GS_pmos, beta_T2 * np.maximum(0, U_GS_pmos - 1.0), linewidth=2, label='$g_{msat}$ w $T_2 > T_1$')
ax8.set_title('$g_{msat}$ w funkcji $|U_{GS}|$')
ax8.set_xlabel('$|U_{GS}|$ [V]')
ax8.set_ylabel('$g_{msat}$ [j.w.]')
ax8.legend()

fig5.tight_layout()

# Wyświetlenie wszystkich okien jednocześnie
plt.show()