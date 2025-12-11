#!/bin/zsh
echo "Podaj sciezke: "
read p
echo "podaj rozszerzenie: "
read e
find $p *.$e | xargs cp ~/backup 
