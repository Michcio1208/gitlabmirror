from PIL import Image, ImageEnhance, ImageFilter
import matplotlib.pyplot as plt

cat = Image.open("cat.png").convert("RGB")
corridor = Image.open("corridor.png").convert("RGB")

img_paste = corridor.copy()
img_paste.paste(cat.resize((200, 150)), (300, 350))

enhancer = ImageEnhance.Sharpness(corridor)
img_sharp = enhancer.enhance(2.0)

noise = Image.effect_noise(cat.size, 50).convert("RGB")
img_noisy_cat = Image.blend(cat, noise, 0.5)

img_filter_cat = cat.filter(ImageFilter.DETAIL)
img_filter_corridor = corridor.filter(ImageFilter.MedianFilter(size=9))

fig, axs = plt.subplots(2, 3, figsize=(15, 10))

axs[0, 0].imshow(img_paste)
axs[0, 1].imshow(img_sharp)
axs[0, 2].imshow(img_noisy_cat)
axs[1, 0].imshow(img_filter_cat)
axs[1, 1].imshow(img_filter_corridor)
axs[1, 2].axis('off')

plt.show()