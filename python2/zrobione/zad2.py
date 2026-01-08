import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 10 * np.pi, 500)
A = 1.0
lambda_coeff = 0.05
y_sin = A * np.exp(-lambda_coeff * x) * np.sin(x)
y_env_upper = A * np.exp(-lambda_coeff * x)
y_env_lower = -A * np.exp(-lambda_coeff * x)

plt.plot(x, y_sin, label='Tłumiona sinusoida', linestyle='-')
plt.plot(x, y_env_upper, label='Obwiednia', linestyle='--')
plt.plot(x, y_env_lower, linestyle='--')

plt.title("Wykres tłumionej sinusoidy")
plt.xlabel("t")
plt.ylabel("A")
plt.legend()
plt.show()