import matplotlib.pyplot as plt
import numpy as np
import math

# Autor: Rozwiązanie Zadania 1
# Cel: Prezentacja subplotów i funkcji matematycznych

# Przygotowanie danych do wykresów
# 1. Krzywa parametryczna (Prawy Górny) [cite: 19, 20, 21, 22]
t = np.arange(0, 7, 0.05)
x_param = 1.5 * np.sin(t)**3
y_param = 3 * np.cos(t) - 1.2 * np.cos(2*t) - 0.6 * np.cos(3*t)

# 2. Funkcja sigmoidalna (Lewy Dolny) [cite: 23, 24, 25]
x_sig = np.arange(-5, 5, 0.1)
k = 2  # Przykładowy parametr
x0 = 0 # Przykładowy parametr
y_sig = 1 / (1 + np.exp(-k * (x_sig - x0)))

# Wczytanie obrazów (z wykorzystaniem biblioteki matplotlib.pyplot) [cite: 16, 17]
img_cat = plt.imread('cat.png')
img_corridor = plt.imread('corridor.png')

# Tworzenie figury i subplotów (2 wiersze, 2 kolumny) [cite: 15]
fig, axs = plt.subplots(2, 2, figsize=(10, 8))
fig.suptitle('Zadanie 1: Obrazy i Funkcje')

# Lewy górny: Kot [cite: 16]
axs[0, 0].imshow(img_cat)
axs[0, 0].set_title("Lewy Górny: Kot")
axs[0, 0].axis('off')

# Prawy górny: Krzywa parametryczna [cite: 19]
axs[0, 1].plot(x_param, y_param, color='purple')
axs[0, 1].set_title("Prawy Górny: Krzywa parametryczna")
axs[0, 1].grid(True)

# Lewy dolny: Sigmoida [cite: 23]
axs[1, 0].plot(x_sig, y_sig, color='green')
axs[1, 0].set_title("Lewy Dolny: Funkcja sigmoidalna")
axs[1, 0].grid(True)

# Prawy dolny: Korytarz [cite: 17]
axs[1, 1].imshow(img_corridor)
axs[1, 1].set_title("Prawy Dolny: Korytarz")
axs[1, 1].axis('off')

plt.tight_layout()
plt.show()