#!/bin/bash
echo "Podaj sciezke: "
read p
echo "podaj rozszerzenie: "
read e
find "$HOME/$p" -name "*$e" -exec cp {} $HOME\backup \;
echo "Skopiowano"

