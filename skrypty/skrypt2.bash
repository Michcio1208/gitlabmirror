#!/bin/bash

echo "Naciśnij 'q', aby zakończyć działanie skryptu."
sleep 2

while true; do
    # Wyczyszczenie ekranu dla efektu odświeżania
    clear

    echo "=== MONITOR SYSTEMU ==="
    # Nazwa hosta [cite: 17]
    echo "Nazwa hosta: $(hostname)"
    
    # Wersja jądra [cite: 18]
    echo "Wersja jądra: $(uname -r)"
    
    # Czas działania [cite: 19]
    echo "Czas działania: $(uptime -p)"
    
    # Użycie procesora (komenda z instrukcji) [cite: 20]
    # Uwaga: wymaga pakietu sysstat. Jeśli go nie ma, mpstat może nie działać.
    echo -n "Wykorzystanie CPU: "
    mpstat | tail -1 | awk '{print 100-$12"%"}'
    
    # Użycie dysku (formatowanie head/tail zgodnie z instrukcją) [cite: 22]
    echo "Użycie dysku (Total):"
    df -h --total | tail -1
    
    echo "---------------------------------"
    echo "5 najbardziej zasobożernych procesów:"
    # Komenda z instrukcji [cite: 22, 23]
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6
    
    # Oczekiwanie na klawisz 'q' przez 1 sekundę
    read -t 1 -N 1 input
    if [[ "$input" == "q" ]]; then
        echo -e "\nZakończono działanie."
        break
    fi
done