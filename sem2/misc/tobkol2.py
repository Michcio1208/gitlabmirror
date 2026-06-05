import numpy as np
import matplotlib.pyplot as plt

# Definicja przedziałów czasowych
t_neg = np.linspace(-5, 0, 500)
t_pos = np.linspace(0, 15, 1000)

# Obliczenie wartości prądu
i_neg = np.full_like(t_neg, 2.0)
i_pos = 1.2 + (2/15) * np.exp(-t_pos / 3)

# Tworzenie wykresu
plt.figure(figsize=(10, 6))

# Rysowanie linii dla obu stanów
plt.plot(t_neg, i_neg, label='$i(t) = 2$ A dla $t < 0$', color='blue', linewidth=2.5)
plt.plot(t_pos, i_pos, label='$i(t) = 1.2 + \\frac{2}{15} e^{-t/3}$ A dla $t \ge 0$', color='red', linewidth=2.5)

# Oznaczenie punktu skoku (t=0)
plt.plot(0, 2.0, 'bo', markerfacecolor='white', markersize=8) # Koniec przed komutacją (okrąg pusty)
plt.plot(0, 1.2 + 2/15, 'ro', markersize=8) # Początek po komutacji (okrąg pełny)

# Opis i siatka
plt.title('Przebieg prądu $i(t)$ w dziedzinie czasu', fontsize=14, pad=15)
plt.xlabel('Czas $t$ [s]', fontsize=12)
plt.ylabel('Prąd $i(t)$ [A]', fontsize=12)
plt.axhline(0, color='black', linewidth=1)
plt.axvline(0, color='black', linewidth=1)
plt.grid(True, linestyle='--', alpha=0.7)
plt.legend(fontsize=12)

# Wyświetlenie wykresu
plt.tight_layout()
plt.show()