import pandas as pd
import matplotlib.pyplot as plt




# --- KROK 2: Wczytanie i analiza danych (PANDAS) ---

# Wczytujemy dane. Pandas świetnie radzi sobie z formatem CSV.
# sep=';' oznacza, że kolumny są oddzielone średnikiem.
# decimal=',' oznacza, że w liczbach (np. 107,5) używany jest przecinek zamiast kropki.
df = pd.read_csv('~/LAB/repo/python1/inflacja.csv', sep=';', decimal=',')

# Wyświetlamy pierwsze 5 wierszy dla sprawdzenia
print("\nPierwsze 5 wierszy:")
print(df.head())

# Obliczamy średnią i odchylenie standardowe całej kolumny 'Wskaznik'
srednia = df['Wskaznik'].mean()
odchylenie = df['Wskaznik'].std()

print(f"\nŚrednia inflacja (1950-2024): {srednia:.2f}")
print(f"Odchylenie standardowe: {odchylenie:.2f}")

# --- KROK 3: Wykres (Pandas + Matplotlib) ---

plt.figure(figsize=(12, 6))

# Rysujemy wykres bezpośrednio z DataFrame
# x='Rok', y='Wskaznik', kind='line' (domyślny), color='red'
plt.plot(df['Rok'], df['Wskaznik'], color='red', linestyle='-')

# Tytuł i opisy
plt.title("Roczne wskaźniki cen towarów i usług konsumpcyjnych (1950-2024) [źródło: GUS]")
plt.xlabel("Rok")
plt.ylabel("Wskaźnik inflacji (%)")
plt.grid(True)

# Wyświetlenie wykresu
plt.show()