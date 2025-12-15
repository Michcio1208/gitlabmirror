#!/usr/bin/env python3
import sys
import math
if len(sys.argv) != 4:
    print("Blad: Podaj dokladnie 3 liczby")
    sys.exit()
a = float(sys.argv[1])
b = float(sys.argv[2])
c = float(sys.argv[3])
if a > 0 and b > 0 and c > 0:
    suma = math.sqrt(a) + math.sqrt(b) + math.sqrt(c)
    print("Suma pierwiastkow:", suma)
else:
    print("Blad: Liczby musza byc dodatnie")
