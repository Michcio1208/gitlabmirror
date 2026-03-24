#!/bin/bash
echo "Naciśnij 'q', aby zakończyć działanie skryptu."
sleep 2
while true; do
    clear
    echo "=== MONITOR SYSTEMU ==="
    echo "Nazwa hosta: $(hostname)"
    echo "Wersja jądra: $(uname -r)"
    echo "Czas działania: $(uptime -p)"
    echo -n "Wykorzystanie CPU: "
    mpstat | tail -1 | awk '{print 100-$12"%"}'
    echo "Użycie dysku (Total):"
    df -h --total | tail -1
    echo "---------------------------------"
    echo "5 najbardziej zasobożernych procesów:"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6
    read -t 1 -N 1 input
    if [[ "$input" == "q" ]]; then
        echo -e "\nZakończono działanie."
        break
    fi
done