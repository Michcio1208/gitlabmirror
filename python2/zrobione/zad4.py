def gnome_sort(arr):
    n = len(arr)
    i = 1
    j = 2
    
    while i < n:
        if arr[i-1] <= arr[i]:
            i = j
            j = j + 1
        else:
            arr[i-1], arr[i] = arr[i], arr[i-1]
            i = i - 1
            if i == 0:
                i = 1
                j = 2
    return arr

if __name__ == '__main__':
    data = [34, 2, 10, -5, 8, 100, 1]
    print(gnome_sort(data))