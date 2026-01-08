# Autor: Rozwiązanie Zadania 4
# Cel: Implementacja algorytmu Gnome Sort

def gnome_sort(arr_in):
    """
    Funkcja sortująca algorytmem gnoma.
    Oparta na pseudokodzie z Zadania 4.
    """
    A = arr_in.copy() # Pracujemy na kopii, żeby nie zmieniać oryginału
    n = len(A) # [cite: 45]
    i = 1      # [cite: 45]
    j = 2      # [cite: 45]
    
    while i < n: # [cite: 45]
        if A[i-1] <= A[i]: # [cite: 45]
            i = j          # [cite: 45]
            j = j + 1      # [cite: 45]
        else:              # [cite: 45]
            # Zamień miejscami A[i-1] i A[i]
            A[i-1], A[i] = A[i], A[i-1] # [cite: 45]
            i = i - 1      # [cite: 45]
            if i == 0:     # [cite: 45]
                i = 1      # [cite: 45]
                j = 2      # Korekta względem pseudokodu dla bezpieczeństwa pętli, choć pseudokod mówi i=1
    return A

# Deklaracja miejsca rozpoczęcia wykonywania skryptu [cite: 47, 48]
if __name__ == '__main__':
    # Definicja testowej tablicy [cite: 53]
    test_array = [34, 2, 10, -5, 8, 100, 1]
    
    print("Przed sortowaniem:", test_array)
    
    # Wywołanie funkcji i wyświetlenie wyniku [cite: 53]
    sorted_array = gnome_sort(test_array)
    
    print("Po sortowaniu:    ", sorted_array)