"""
Zadanie: Wyścig (race condition) na współdzielonym liczniku

OPIS:
Wywołanie funkcji get_one() powoduje przerwanie – wątek może się przełączyć
w krytycznym momencie (po odczycie counter, ale przed zapisem).

URUCHOMIENIE:
    python race_condition.py
"""

import threading
import time

# ============================================================
# CZĘŚĆ 1: KOD Z WYŚCIGIEM
# ============================================================

counter1 = 0

def get_one():
    """Funkcja zwraca wartość 1. Konieczna do wywołania wyścigu."""
    return 1

def increment_race():
    global counter1
    for _ in range(1_000_000):
        counter1 += get_one()


def test_race(num_threads):
    global counter1
    counter1 = 0
    
    threads = [threading.Thread(target=increment_race) for _ in range(num_threads)]
    
    start = time.time()
    for t in threads: t.start()
    for t in threads: t.join()
    end = time.time()
    
    expected = num_threads * 1_000_000
    lost = expected - counter1
    
    print(f"\n--- WYŚCIG: {num_threads} wątki/ów ---")
    print(f"Oczekiwana: {expected:,}")
    print(f"Rzeczywista: {counter1:,}")
    print(f"Utracone: {lost:,} ({lost/expected*100:.2f}%)")
    print(f"Czas: {end - start:.2f} s")


# ============================================================
# CZĘŚĆ 2: KOD Z BLOKADĄ (POPRAWNY)
# ============================================================

counter2 = 0
lock = threading.Lock()

def increment_safe():
    global counter2
    for _ in range(1_000_000):
        with lock:
            counter2 += get_one()


def test_safe(num_threads):
    global counter2
    counter2 = 0
    
    threads = [threading.Thread(target=increment_safe) for _ in range(num_threads)]
    
    start = time.time()
    for t in threads: t.start()
    for t in threads: t.join()
    end = time.time()
    
    expected = num_threads * 1_000_000
    
    print(f"\n--- BLOKADA (poprawny): {num_threads} wątki/ów ---")
    print(f"Oczekiwana: {expected:,}")
    print(f"Rzeczywista: {counter2:,}")
    print(f"Błąd: {expected - counter2} (powinno być 0!)")
    print(f"Czas: {end - start:.2f} s")


# ============================================================
# CZĘŚĆ 3: ZŁY WZORZEC (blokada przed pętlą)
# ============================================================

counter3 = 0
lock_bad = threading.Lock()

def increment_bad_lock():
    global counter3
    with lock_bad:  # <-- BLOKADA PRZED PĘTLĄ!
        for _ in range(1_000_000):
            counter3 += get_one()


def test_bad_lock(num_threads):
    global counter3
    counter3 = 0
    
    threads = [threading.Thread(target=increment_bad_lock) for _ in range(num_threads)]
    
    start = time.time()
    for t in threads: t.start()
    for t in threads: t.join()
    end = time.time()
    
    expected = num_threads * 1_000_000
    
    print(f"\n--- ZŁY WZORZEC (blokada przed pętlą): {num_threads} wątki/ów ---")
    print(f"Oczekiwana: {expected:,}")
    print(f"Rzeczywista: {counter3:,}")
    print(f"Czas: {end - start:.2f} s")


# ============================================================
# MAIN
# ============================================================

def main():
    print("=" * 60)
    print("WYŚCIG NA WSPÓLNYM LICZNIKU - ĆWICZENIE")
    print("=" * 60)
    
    # ========================================================
    # ODKOMENTUJ DOKŁADNIE JEDNĄ Z PONIŻSZYCH SEKCJI
    # ========================================================
    
    # --- SEKCJA 1: WYŚCIG ---
    for n in [2, 4, 8, 16]:
        test_race(n)
        input("\nNaciśnij Enter...")
    
    # --- SEKCJA 2: Z BLOKADĄ (poprawny) ---
    #for n in [2, 4, 8, 16]:
    #    test_safe(n)
    #     input("\nNaciśnij Enter...")
    
    # --- SEKCJA 3: ZŁY WZORZEC ---
    #for n in [2, 4, 8, 16]:
     # test_bad_lock(n)
    #     input("\nNaciśnij Enter...")
    
    # ========================================================
    
    print("\n" + "=" * 60)
    print("KONIEC. Odpowiedz na pytania w sprawozdaniu.")
    print("=" * 60)


if __name__ == "__main__":
    main()