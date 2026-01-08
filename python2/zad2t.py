import matplotlib.pyplot as plt
import numpy as np

# Autor: Rozwiązanie Zadania 2
# Cel: Wizualizacja tłumionej sinusoidy

# Dane
# 5 okresów sinusoidy (10pi), tłumienie dobrane eksperymentalnie [cite: 28, 29]
x = np.linspace(0, 10 * np.pi, 500)
A = 1.0
lambda_coeff = 0.022 # Dobrane tak, by amplituda spadła ok. 2-krotnie na końcu
y_sin = A * np.exp(-lambda_coeff * x) * np.sin(x)

# Obwiednie [cite: 30, 33]
y_env_upper = A * np.exp(-lambda_coeff * x)
y_env_lower = -A * np.exp(-lambda_coeff * x)

# Rysowanie
plt.figure(figsize=(10, 6))

# Sinusoida (inny kolor/linia) [cite: 31]
plt.plot(x, y_sin, label='Tłumiona sinusoida', color='blue', linewidth=2)

# Obwiednie (inny kolor/linia) [cite: 31]
plt.plot(x, y_env_upper, label=r'Obwiednia: $e^{-0.022x}$', color='red', linestyle='--')
plt.plot(x, y_env_lower, color='red', linestyle='--') # Bez labela, żeby nie dublować legendy

plt.title("Wykres tłumionej sinusoidy") # [cite: 32]
plt.xlabel("Czas (t)") # [cite: 32]
plt.ylabel("Amplituda") # [cite: 32]
plt.legend() # [cite: 32]
plt.grid(True)
plt.show()