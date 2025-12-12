#!/bin/bash
echo "Podaj sciezke: "
read p
echo "podaj rozszerzenie: "
read e
mkdir -p "$HOME/backup"
find "$HOME/$p" -name "*.$e" -exec cp {} "$HOME/backup" \;
echo "Skopiowano"

