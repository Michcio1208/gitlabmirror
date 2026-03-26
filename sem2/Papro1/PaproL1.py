#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import psutil
import time
import matplotlib.pyplot as plt


def zadanie1(n):
    out = 0
    for i in range(n):
        out += i
    return out


def zadanie2(n):
    out = 0
    for i in range(n):
        for j in range(n):
            out += i * j
    return out


def zadanie3(arr):
    "Insertion sort - sortowanie przez wstawianie"
    arr = arr.copy()
    n = len(arr)
    for i in range(1, n):
        key = arr[i]
        j = i - 1
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key
    return arr


def main():
    AKTYWNE_ZADANIE = "zad3"  # zad1 / zad2 / zad3

    # Które zadanie będzie rozwiązywane
    if AKTYWNE_ZADANIE == 'zad1':
        nsize = [10, 100, 500, 1000, 2000, 3000, 5000]
        times = []

        # Aktualne częstotliwość taktowania w MHz
        cpu_freq = psutil.cpu_freq().current
        # Konwersja na Hz (konwersja cykle na sekundę)
        cpu_hz = cpu_freq * 1_000_000
        print(f"Aktualne taktowanie procesora: {cpu_hz / 1e9:.2f} GHz")
        print(f"Czas jednej opeacji procesora: {1/cpu_hz *1e9:.4f} ns")

        n_for_time = 1_000_000
        start = time.perf_counter()
        zadanie1(n_for_time)
        end = time.perf_counter()
        total_time = end - start
        time_per_iteration = total_time / n_for_time

        print(f"Jedna iteracja trwa: {time_per_iteration * 1e9:.4f} ns")
        # Ile cykli procesora zajmuje jedna iteracja w Pythonie
        cycles_per_iter = time_per_iteration / (1 / cpu_hz)
        print(f"Jedna iteracja to ok. {int(cycles_per_iter)} cykli procesora")

        for n_val in nsize:
            start = time.perf_counter()
            zadanie1(n_val)
            end = time.perf_counter()
            total_time = end - start
            times.append(total_time)

        plt.figure(figsize=(10, 6))
        plt.plot(nsize, times, marker='o', linestyle='-', label='Czas wykonania')
        plt.xscale('log')
        plt.yscale('log')
        plt.title('Zależność czasu od rozmiaru danych (n)')
        plt.xlabel('Wartość n (skala log)')
        plt.ylabel('Czas [s] (skala log)')
        plt.grid(True, which='both', ls='-', alpha=0.5)
        plt.legend()
        plt.show()

    if AKTYWNE_ZADANIE == "zad2":
        nsize = [10, 100, 500, 1000, 2000, 3000, 5000]
        times = []

       # Aktualne częstotliwość taktowania w MHz
        cpu_freq = psutil.cpu_freq().current
        # Konwersja na Hz (konwersja cykle na sekundę)
        cpu_hz = cpu_freq * 1_000_000
        print(f"Aktualne taktowanie procesora: {cpu_hz / 1e9:.2f} GHz")
        print(f"Czas jednej opeacji procesora: {1/cpu_hz *1e9:.4f} ns")

        n_for_time = 1_000_000
        start = time.perf_counter()
        zadanie1(n_for_time)
        end = time.perf_counter()
        total_time = end - start
        time_per_iteration = total_time / n_for_time

        print(f"Jedna iteracja trwa: {time_per_iteration * 1e9:.4f} ns")
        # Ile cykli procesora zajmuje jedna iteracja w Pythonie
        cycles_per_iter = time_per_iteration / (1 / cpu_hz)
        print(f"Jedna iteracja to ok. {int(cycles_per_iter)} cykli procesora")

        for n_val in nsize:
            start = time.perf_counter()
            zadanie2(n_val)
            end = time.perf_counter()
            total_time = end - start
            times.append(total_time)

        plt.figure(figsize=(10, 6))
        plt.plot(nsize, times, marker='o', linestyle='-', label='Czas wykonania')
        plt.title('Zależność czasu od rozmiaru danych (n)')
        plt.xlabel('Wartość n')
        plt.ylabel('Czas [s] ')
        plt.grid(True, which='both', ls='-', alpha=0.5)
        plt.legend()
        plt.show()
        # Narysować czas w funkcji rozmiaru danych wejściowych

    if AKTYWNE_ZADANIE == "zad3":
        import random
        nsize = [100, 500, 1000, 2000, 3000, 5000, 7500, 10000]

        times_random   = []
        times_sorted   = []
        times_reversed = []

        for n_val in nsize:
            arr_random   = [random.randint(0, 10 * n_val) for _ in range(n_val)]
            arr_sorted   = list(range(n_val))
            arr_reversed = list(range(n_val, 0, -1))

            start = time.perf_counter()
            zadanie3(arr_random)
            times_random.append(time.perf_counter() - start)

            start = time.perf_counter()
            zadanie3(arr_sorted)
            times_sorted.append(time.perf_counter() - start)

            start = time.perf_counter()
            zadanie3(arr_reversed)
            times_reversed.append(time.perf_counter() - start)

            print(f"n={n_val:6d} | losowa: {times_random[-1]:.6f}s | "
                  f"posortowana: {times_sorted[-1]:.6f}s | "
                  f"odwrotna: {times_reversed[-1]:.6f}s")

        #  Wykres liniowy 
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

        ax1.plot(nsize, times_random,   marker='o', label='Losowa (przypadek średni)')
        ax1.plot(nsize, times_sorted,   marker='s', label='Posortowana (najlepszy przypadek)')
        ax1.plot(nsize, times_reversed, marker='^', label='Odwrotna (najgorszy przypadek)')
        ax1.set_title('Skala liniowa')
        ax1.set_xlabel('Rozmiar danych wejściowych n')
        ax1.set_ylabel('Czas [s]')
        ax1.grid(True)
        ax1.legend()

        #  Wykres log-log 
        ax2.plot(nsize, times_random,   marker='o', label='Losowa (przypadek średni)')
        ax2.plot(nsize, times_sorted,   marker='s', label='Posortowana (najlepszy przypadek)')
        ax2.plot(nsize, times_reversed, marker='^', label='Odwrotna (najgorszy przypadek)')
        ax2.set_xscale('log')
        ax2.set_yscale('log')
        ax2.set_title('Skala log-log')
        ax2.set_xlabel('Rozmiar danych wejściowych n (skala log)')
        ax2.set_ylabel('Czas [s] (skala log)')
        ax2.grid(True, which='both', ls='-', alpha=0.5)
        ax2.legend()

        plt.suptitle('Złożoność czasowa - sortowanie przez wstawianie', fontsize=13)
        plt.tight_layout()
        plt.show()


if __name__ == "__main__":
    main()