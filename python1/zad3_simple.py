import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

nazwa_pliku = 'inflacja.csv'

plik = pd.read_csv(nazwa_pliku, sep=';', encoding='cp1250')


plik['Wartość_liczba'] = plik['Wartość'].astype(str).str.replace(',', '.').astype(float)
kolumna_do_analizy = 'Wartość_liczba'


plik = plik.sort_values('Rok')

srednie_wartosci = plik[kolumna_do_analizy].to_numpy(dtype=float)
srednia = np.mean(srednie_wartosci)
odchylenie = np.std(srednie_wartosci, ddof=1)

print(f"--- WYNIKI ---")
print(f"Średnia inflacja: {srednia:.2f}")
print(f"Odchylenie standardowe: {odchylenie:.2f}")

plt.figure(figsize=(10, 6))
plt.plot(plik['Rok'], plik[kolumna_do_analizy], color='red', linestyle='-', label='Inflacja')
plt.title('Wskaźnik inflacji (GUS)')
plt.xlabel('Rok')
plt.ylabel('Wartość')
plt.grid(True)
plt.legend()
plt.show()
print("Wykres został wyświetlony.")
