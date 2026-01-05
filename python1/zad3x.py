import pandas as pd
import matplotlib.pyplot as plt
import numpy as np


plik = pd.read_csv('inflacja.csv', sep=';', encoding='cp1250')


plik['Wartość_liczba'] = plik['Wartość'].astype(str).str.replace(',', '.').astype(float)



plik = plik.sort_values('Rok')

srednie_wartosci = plik['Wartość_liczba'].to_numpy(dtype=float)
srednia = np.mean(srednie_wartosci)
odchylenie = np.std(srednie_wartosci, ddof=1)

print("--- WYNIKI ---")
print(f"Średnia inflacja: {srednia}")
print(f"Odchylenie standardowe: {odchylenie}")

plt.figure(figsize=(10, 6))
plt.plot(plik['Rok'], plik['Wartość_liczba'], color='red', linestyle='-', label='Inflacja')
plt.title('Wskaźnik inflacji (GUS)')
plt.xlabel('Rok')
plt.ylabel('Wartość')
plt.grid(True)
plt.legend()
plt.show()
print("Wykres został wyświetlony.")
