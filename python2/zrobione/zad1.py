import matplotlib.pyplot as plt
import numpy as np

t = np.arange(0, 7, 0.05)
x_param = 1.5 * np.sin(t)**3
y_param = 3 * np.cos(t) - 1.2 * np.cos(2*t) - 0.6 * np.cos(3*t)

x_sig = np.arange(-5, 5, 0.1)
k = 2
x0 = 0
y_sig = 1 / (1 + np.exp(-k * (x_sig - x0)))

img_cat = plt.imread('cat.png')
img_corridor = plt.imread('corridor.png')

fig, axs = plt.subplots(2, 2, figsize=(10, 8))

axs[0, 0].imshow(img_cat)
axs[0, 1].plot(x_param, y_param)
axs[0, 1].grid(True)

axs[1, 0].plot(x_sig, y_sig)
axs[1, 0].grid(True)

axs[1, 1].imshow(img_corridor)

plt.show()