from PIL import Image, ImageEnhance, ImageFilter, ImageChops
import matplotlib.pyplot as plt

# Autor: Rozwiązanie Zadania 3
# Cel: Manipulacje na obrazach przy użyciu PIL (Pillow)

# Ładowanie obrazów
cat = Image.open("cat.png").convert("RGB")
corridor = Image.open("corridor.png").convert("RGB")

# --- Podpunkt 1: Paste --- [cite: 35, 36]
# Tworzymy kopię, żeby nie psuć oryginału
img_paste = corridor.copy()
# Skalujemy kota, żeby zmieścił się ładnie w korytarzu (opcjonalne, dla estetyki)
cat_small = cat.resize((200, 150))
img_paste.paste(cat_small, (300, 350)) # Wklejamy w przykładowym miejscu

# --- Podpunkt 2: Sharpness, Noise, Blend --- [cite: 37, 38]
# Wyostrzanie korytarza (współczynnik 2)
enhancer = ImageEnhance.Sharpness(corridor)
img_sharp = enhancer.enhance(2.0)

# Szum i blendowanie z kotem
# Generujemy szum o rozmiarze kota (sigma=50 dla silnego efektu)
noise = Image.effect_noise(cat.size, 50).convert("RGB") 
# Suma ważona (blend) ze współczynnikiem 0.5
img_noisy_cat = Image.blend(cat, noise, 0.5)

# --- Podpunkt 3: Filtry --- [cite: 40, 41, 42]
# Filtr DETAIL dla kota
img_filter_cat = cat.filter(ImageFilter.DETAIL)

# Filtr Medianowy (9x9) dla korytarza. 
# ImageFilter.MedianFilter przyjmuje nieparzysty rozmiar (size).
img_filter_corridor = corridor.filter(ImageFilter.MedianFilter(size=9))

# --- Wyświetlanie wyników na jednej figurze (wieloczęściowej) --- [cite: 39, 42]
fig, axs = plt.subplots(2, 3, figsize=(15, 10))
fig.suptitle('Zadanie 3: Przetwarzanie obrazów PIL')

# Wiersz 1: Paste i Blend
axs[0, 0].imshow(img_paste)
axs[0, 0].set_title("1. Paste: Kot w korytarzu")
axs[0, 0].axis('off')

axs[0, 1].imshow(img_sharp)
axs[0, 1].set_title("2. Sharpness: Wyostrzony korytarz")
axs[0, 1].axis('off')

axs[0, 2].imshow(img_noisy_cat)
axs[0, 2].set_title("2. Blend: Zaszumiony kot")
axs[0, 2].axis('off')

# Wiersz 2: Filtry
axs[1, 0].imshow(img_filter_cat)
axs[1, 0].set_title("3. Filter: Kot DETAIL")
axs[1, 0].axis('off')

axs[1, 1].imshow(img_filter_corridor)
axs[1, 1].set_title("3. Filter: Korytarz Median(9)")
axs[1, 1].axis('off')

# Puste miejsce
axs[1, 2].axis('off')

plt.tight_layout()
plt.show()