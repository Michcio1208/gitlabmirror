## Autor: Michał Krystecki 342906

from PIL import Image, ImageEnhance, ImageFilter
import matplotlib.pyplot as plt

cat = Image.open("cat.png").convert("RGB")
corridor = Image.open("corridor.png").convert("RGB")

img_paste = corridor.copy()
img_paste.paste(cat.resize((200, 150)), (850, 650))

enhancer = ImageEnhance.Sharpness(corridor)
img_sharp = enhancer.enhance(2.0)

noise = Image.effect_noise(cat.size, 50).convert("RGB")
img_noisy_cat = Image.blend(cat, noise, 0.5)

img_filter_cat = cat.filter(ImageFilter.DETAIL)
img_filter_corridor = corridor.filter(ImageFilter.MedianFilter(size=9))

fig, axs = plt.subplots(3, 4, figsize=(15, 10))
fig.suptitle('Zadanie 3: Przetwarzanie obrazów PIL')

axs[0, 0].imshow(corridor)
axs[0, 0].set_title("Original: Korytarz")
axs[0, 0].axis('off')

axs[0, 1].imshow(img_paste)
axs[0, 1].set_title("Paste: Kot w korytarzu")
axs[0, 1].axis('off')

axs[0, 2].imshow(img_sharp)
axs[0, 2].set_title("Sharpness: Wyostrzony korytarz")
axs[0, 2].axis('off')

axs[0, 3].imshow(img_filter_corridor)
axs[0, 3].set_title("Filter: Korytarz Median(9)")
axs[0, 3].axis('off')


axs[1, 0].imshow(cat)
axs[1, 0].axis('off')
axs[1, 0].set_title("Original: Kot")



axs[1, 1].imshow(img_filter_cat)
axs[1, 1].set_title("3. Filter: Kot DETAIL")
axs[1, 1].axis('off')

axs[1, 2].imshow(img_noisy_cat)
axs[1, 2].set_title("2. Blend: Zaszumiony kot")
axs[1, 2].axis('off')

axs[1, 3].axis('off')
axs[2, 0].axis('off')
axs[2, 1].axis('off')
axs[2, 2].axis('off')
axs[2, 3].axis('off')


plt.tight_layout()

plt.show()