import numpy as np
import matplotlib.pyplot as plt

# --- Zadanie 6 Calculations ---
# Constants
q = 1.602e-19 # C
eps_s = 11.7 * 8.854e-14 # F/cm
k = 1.38e-23 # J/K
T = 300 # K
VT = k*T/q # V (approx 0.0258 V)
ni = 1.5e10 # cm^-3 

Na = 1e18 # cm^-3
Nd = 1e15 # cm^-3
Js = 1e-10 # A/cm^2
tau_p = 2e-6 # s
U_val = 0.45 # V

# Uj calculation
Uj = VT * np.log(Na * Nd / (ni**2))

# Cj at U = 0.45V
Cj_045 = np.sqrt( q * eps_s * Na * Nd / (2 * (Na + Nd) * (Uj - U_val)) )

# Cd at U = 0.45V
Cd_045 = (tau_p / VT) * Js * np.exp(U_val / VT)

ratio = Cj_045 / Cd_045
print(f"VT: {VT:.4f} V")
print(f"Uj: {Uj:.4f} V")
print(f"Cj(0.45V): {Cj_045:.4e} F/cm^2")
print(f"Cd(0.45V): {Cd_045:.4e} F/cm^2")
print(f"Ratio Cj/Cd: {ratio:.4f}")

# --- Plotting ---
plt.figure(figsize=(12, 6))

# Subplot 1: Zadanie 1 (Zależność C_j od U)
plt.subplot(1, 2, 1)
U_arr1 = np.linspace(-5, Uj-0.05, 400)
Cj_skokowe = 1 / np.sqrt(1 - U_arr1/Uj) 
Cj_dyfuzyjne = 1 / (1 - U_arr1/Uj)**(0.333)

plt.plot(U_arr1, Cj_skokowe, label='Złącze skokowe ($m=1/2$)')
plt.plot(U_arr1, Cj_dyfuzyjne, label='Złącze dyfuzyjne ($m=1/3$)')
plt.title('Zadanie 1: Znormalizowana poj. złączowa $C_j/C_{j0}$')
plt.xlabel('Napięcie polaryzacji U [V]')
plt.ylabel('Znormalizowana pojemność $C_j / C_{j0}$')
plt.axvline(x=0, color='gray', linestyle='--', linewidth=0.5)
plt.grid(True)
plt.legend()

# Subplot 2: Zadanie 6 (C_j i C_d od U)
plt.subplot(1, 2, 2)
U_arr2 = np.linspace(-0.5, 0.6, 400)
Cj_arr = np.sqrt( q * eps_s * Na * Nd / (2 * (Na + Nd) * (Uj - U_arr2)) )
Cd_arr = (tau_p / VT) * Js * np.exp(U_arr2 / VT)

plt.plot(U_arr2, Cj_arr, label='Pojemność złączowa $C_j$', color='blue')
plt.plot(U_arr2, Cd_arr, label='Pojemność dyfuzyjna $C_d$', color='orange')
plt.yscale('log')
plt.title('Zadanie 6: Zależność $C_j$ i $C_d$ od napięcia')
plt.xlabel('Napięcie polaryzacji U [V]')
plt.ylabel('Pojemność [F/cm$^2$]')
plt.axvline(x=0.45, color='red', linestyle='--', label='U = 0.45 V')
plt.grid(True, which="both", ls="--", alpha=0.5)
plt.legend()

plt.tight_layout()
plt.show()