"""
Zadanie: Wątki vs Procesy – współdzielenie pamięci

CEL:
Zrozumieć, że wątki dzielą pamięć, a procesy (domyślnie) NIE.

Uruchomienie:
    python threads_vs_processes.py
"""

import threading
import multiprocessing
import time

# ============================================================
# ZMIENNA GLOBALNA
# ============================================================

counter = 0

def increment():
    """Dodaje 1 do licznika"""
    global counter
    local = counter
    time.sleep(0.1)  # Symulacja pracy
    counter = local + 1


# ============================================================
# EKSPERYMENT 1: WĄTKI (DZIELĄ PAMIĘĆ)
# ============================================================

def experiment_threads():
    global counter
    counter = 0
    
    print("\n" + "="*60)
    print("EKSPERYMENT 1: WĄTKI – DZIELĄ PAMIĘĆ")
    print("="*60)
    
    threads = []
    for _ in range(4):
        t = threading.Thread(target=increment)
        threads.append(t)
        t.start()
    
    for t in threads:
        t.join()
    
    print(f"Końcowa wartość counter: {counter}")
    print("\U00002705 Wątki współdzielą pamięć – wszystkie modyfikowały tę samą zmienną.")


# ============================================================
# EKSPERYMENT 2: PROCESY (NIE DZIELĄ PAMIĘCI)
# ============================================================

def experiment_processes():
    global counter
    counter = 0
    
    print("\n" + "="*60)
    print("EKSPERYMENT 2: PROCESY – NIE DZIELĄ PAMIĘCI")
    print("="*60)
    
    processes = []
    for _ in range(4):
        p = multiprocessing.Process(target=increment)
        processes.append(p)
        p.start()
    
    for p in processes:
        p.join()
    
    print(f"Końcowa wartość counter: {counter}")
    print("\U0000274C Procesy NIE współdzielą pamięci – każdy pracował na własnej kopii.")
    print("   Zmienna w głównym procesie pozostała 0!")


# ============================================================
# EKSPERYMENT 3: CO JEST SZYBSZE?
# ============================================================

def test_speed():
    print("\n" + "="*60)
    print("EKSPERYMENT 3: PORÓWNANIE CZASU (1000 uruchomień)")
    print("="*60)
    
    # Test wątków
    start = time.time()
    for _ in range(1000):
        t = threading.Thread(target=lambda: None)
        t.start()
        t.join()
    thread_time = time.time() - start
    
    # Test procesów
    start = time.time()
    for _ in range(1000):
        p = multiprocessing.Process(target=lambda: None)
        p.start()
        p.join()
    process_time = time.time() - start
    
    print(f"Czas utworzenia 1000 wątków:  {thread_time:.3f}s")
    print(f"Czas utworzenia 1000 procesów: {process_time:.3f}s")
    print(f"\n\U00002705 Wątki są szybsze (~{process_time/thread_time:.0f}× szybsze od procesów)")


# ============================================================
# MAIN
# ============================================================

def main():
    print("="*60)
    print("WĄTKI vs PROCESY – WSPÓŁDZIELENIE PAMIĘCI")
    print("="*60)
    
    # ODKOMENTUJ DOKŁADNIE JEDEN EKSPERYMENT
    # ========================================
    
    #experiment_threads()      # 1. Wątki – dzielą pamięć i się ścigają
    experiment_processes()   # 2. Procesy – NIE dzielą pamięci
    #test_speed()             # 3. Porównanie szybkości
    
    # ========================================

if __name__ == "__main__":
    main()