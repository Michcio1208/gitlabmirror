## Autor: Michał Krystecki 342906

import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 10 * np.pi, 500)
A = 1.0
lambda_coeff = 0.05
y_sin = A * np.exp(-lambda_coeff * x) * np.sin(x)
y_env_upper = A * np.exp(-lambda_coeff * x)
y_env_lower = -A * np.exp(-lambda_coeff * x)

plt.figure(figsize=(10, 6))

plt.plot(x, y_sin, label='Tłumiona sinusoida', linestyle='-')
plt.plot(x, y_env_upper, label=r'Gorna obwiednia $A e^{-\lambda x}$', linestyle='-.', color='red')
plt.plot(x, y_env_lower, label=r'Dolna obwiednia $-A e^{-\lambda x}$', linestyle='--', color='orange')

plt.title("Wykres tłumionej sinusoidy")
plt.xlabel("Czas (t)")
plt.ylabel("Amplituda")
plt.legend()
plt.grid(True)
plt.show() 