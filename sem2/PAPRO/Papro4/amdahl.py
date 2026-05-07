"""
Zadanie: Prawo Amdahla – odkrywanie granic zrównoleglenia

CEL:
Zrozumieć, że nawet przy wielu rdzeniach przyspieszenie jest ograniczone
przez SEKWENCYJNĄ część obliczeń.

Uruchomienie:
    python amdahl_simple.py
"""

import threading
import time
import math

# ============================================================
# OBLICZENIA – ta sama funkcja używana zarówno do części
# sekwencyjnej, jak i równoległej (z różną liczbą iteracji)
# ============================================================

def calculate(iterations):
    """Oblicza sumę pierwiastków – tyle iteracji ile zadane"""
    result = 0
    for i in range(iterations):
        result += math.sqrt(i)
    return result


def calculate_parallel(iterations, num_threads):
    """Wykonuje obliczenia równolegle na zadanej liczbie wątków"""
    chunk_size = iterations // num_threads
    results = [0] * num_threads
    
    def worker(thread_id):
        start = thread_id * chunk_size
        end = start + chunk_size if thread_id < num_threads - 1 else iterations
        s = 0
        for i in range(start, end):
            s += math.sqrt(i)
        results[thread_id] = s
    
    threads = []
    for i in range(num_threads):
        t = threading.Thread(target=worker, args=(i,))
        threads.append(t)
        t.start()
    
    for t in threads:
        t.join()
    
    return sum(results)


def test_amdahl(parallel_fraction, total_iterations, max_threads):
    """
    Testuje prawo Amdahla.
    
    parallel_fraction: jaka część ITERACJI jest równoległa (0.0 do 1.0)
    total_iterations: całkowita liczba iteracji do wykonania
    """
    sequential_iterations = int(total_iterations * (1 - parallel_fraction))
    parallel_iterations = int(total_iterations * parallel_fraction)
    
    print(f"\n{'='*55}")
    print(f"P = {parallel_fraction} ({parallel_fraction*100:.0f}% iteracji równoległych)")
    print(f"Część sekwencyjna: {sequential_iterations:,} iteracji")
    print(f"Część równoległa:   {parallel_iterations:,} iteracji")
    print(f"{'='*55}")
    print(f"{'Wątki':>6} | {'Czas [s]':>10} | {'Przyspieszenie':>14} | {'Teoria':>10}")
    print(f"{'-'*55}")
    
    baseline = None
    
    for num_threads in range(1, max_threads + 1):
        start = time.time()
        
        # CZĘŚĆ SEKWENCYJNA (zawsze 1 wątek, tyle iteracji ile ustalono)
        calculate(sequential_iterations)
        
        # CZĘŚĆ RÓWNOLEGŁA (dzielona między num_threads wątków)
        if parallel_iterations > 0:
            calculate_parallel(parallel_iterations, num_threads)
        
        elapsed = time.time() - start
        
        if num_threads == 1:
            baseline = elapsed
            speedup = 1.0
        else:
            speedup = baseline / elapsed
        
        # Teoretyczne przyspieszenie (prawo Amdahla)
        theoretical = 1 / ((1 - parallel_fraction) + (parallel_fraction / num_threads))
        
        print(f"{num_threads:6d} | {elapsed:10.4f} | {speedup:14.2f}x | {theoretical:10.2f}x")

# ============================================================
# EKSPERYMENTY
# ============================================================

def experiment_1():
    """95% iteracji równoległych – OPTYMISTYCZNY przypadek"""
    print("\n" + "\u2588"*55)
    print("EKSPERYMENT 1: OPTYMISTYCZNY – 95% iteracji równoległych")
    print("\u2588"*55)
    test_amdahl(parallel_fraction=0.95, total_iterations=10_000_000, max_threads=16)


def experiment_2():
    """70% iteracji równoległych – REALISTYCZNY przypadek"""
    print("\n" + "\u2588"*55)
    print("EKSPERYMENT 2: REALISTYCZNY – 70% iteracji równoległych")
    print("\u2588"*55)
    test_amdahl(parallel_fraction=0.70, total_iterations=10_000_000, max_threads=16)


def experiment_3():
    """50% iteracji równoległych – PESYMISTYCZNY przypadek"""
    print("\n" + "\u2588"*55)
    print("EKSPERYMENT 3: PESYMISTYCZNY – 50% iteracji równoległych")
    print("\u2588"*55)
    test_amdahl(parallel_fraction=0.50, total_iterations=10_000_000, max_threads=16)


# ============================================================
# MAIN
# ============================================================

def main():
    print("="*60)
    print("PRAWO AMDAHLA – GRANICE ZRÓWNOLEGLENIA")
    print("="*60)
    print("\n\U0001F4A1 Najważniejszy wniosek:")
    print("   Nawet przy 95% kodu równoległego, przyspieszenie ≤ 20×")
    print("   Część sekwencyjna to wąskie gardło!\n")
    
    # ========================================================
    # ODKOMENTUJ DOKŁADNIE JEDEN EKSPERYMENT
    # ========================================================
    
    #experiment_1()      # P = 0.95 – zobaczysz, że 16 wątków daje ~10-15x
    experiment_2()    # P = 0.70 – zobaczysz, że 16 wątków daje ~3x
    #experiment_3()    # P = 0.50 – zobaczysz, że 16 wątków daje tylko ~2x
    
    # ========================================================
    

if __name__ == "__main__":
    main()