# Komendy i krótkie opisy — lab11

`import math` ; `print(math.sin(math.pi/4))` : Import modułu `math` i użycie `sin` oraz `pi`.

`from math import pi, sin` ; `print(sin(pi/4))` : Import konkretnych składowych modułu do bieżącej przestrzeni nazw.

`print("Bieżąca przestrzeń nazw", dir())` : Wyświetla nazwy w bieżącej przestrzeni nazw.

`!pip list` : Polecenie powłoki uruchamiane w Jupyter (pokazuje zainstalowane pakiety Pythona).

`from PIL import Image` ; `Image.open(path)` ; `print(firstImage.size, firstImage.format, firstImage.mode)` : Wczytanie obrazu przez Pillow i wyświetlenie podstawowych parametrów.

`firstImage.show()` : Otwiera obraz w zewnętrznej przeglądarce (komentarzowane w notatniku).

`firstImage.thumbnail((128,128))` ; `firstImage.save(path)` : Tworzenie miniaturki i zapis do pliku.

`firstImage.rotate(45)` ; `firstImage.transpose(Image.FLIP_LEFT_RIGHT)` ; `firstImage.transpose(Image.FLIP_TOP_BOTTOM)` ; `firstImage.transpose(Image.ROTATE_270)` ; `.save()` : Operacje obróbki obrazu i zapis wyników.

`firstImage.convert('1')` ; `firstImage.convert('L')` ; `.save()` : Konwersja przestrzeni kolorów i zapis.

`from PIL import ImageFilter` ; `firstImage.filter(ImageFilter.CONTOUR)` ; `.save()` : Zastosowanie filtrów obrazu i zapis rezultatów.

`import matplotlib.pyplot as plt` ; `plt.xlabel(...)` ; `plt.ylabel(...)` ; `plt.title(...)` ; `plt.grid()` ; `plt.plot(x,y)` ; `plt.show()` : Tworzenie wykresów 2D przy użyciu Matplotlib.

`import numpy as np` ; `np.arange(start, stop, step)` : Generowanie sekwencji liczb w `numpy`.

`y = np.sin(x)` : Operacje wektorowe (funkcje matematyczne na tablicach `numpy`).

`import pandas as pd` ; `pd.read_csv(path, sep=',')` ; `print(data)` : Wczytanie pliku CSV do `DataFrame` i wyświetlenie.

`plt.plot(data.x.values, data.y_1.values, 'ro')` ; `plt.plot(..., 'k-')` : Rysowanie punktów i linii na wykresie.

`plt.grid(linestyle=':')` ; `plt.savefig(path, format='pdf')` ; `plt.show()` : Ustawienia siatki, zapis wykresu i wyświetlenie.

`pd.read_csv(path, names=['day','night'], header=None, sep=' ')` : Wczytanie pliku tekstowego bez nagłówka i nadanie nazw kolumn.

`weather_data.day.values` / `weather_data.night.values` : Pobranie tablicy wartości z kolumn `pandas`.

`indexes = np.arange(len(cities))` : Tworzenie indeksów do osi X dla wykresu słupkowego.

`plt.bar(indexes, temp_at_night, bar_width, label='Noc')` ; `plt.bar(indexes+bar_width, daytime_temp, bar_width, label='Dzień')` : Rysowanie wykresu słupkowego dla kilku serii danych.

`plt.xticks(indexes+bar_width/2, cities)` : Ustawienie etykiet osi X.

`plt.ylabel('Temperatura ($\\mathrm{^o}$C)')` ; `plt.legend(loc='best')` : Ustawienie etykiety osi Y i legendy.

`plt.savefig('./python_part_2_pics/prognoza_pogody.png', format='png')` ; `plt.show()` : Zapis i wyświetlenie wykresu.
