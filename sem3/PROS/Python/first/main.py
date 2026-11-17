def sum(a,b):
    return a + b    

a=int(input("Enter first number: "))
b=int(input("Enter second number: "))
result = sum(a,b)
print("The sum of", a, "and", b, "is:", result)
# python defaultowo jest obiektowy; nawet jedna liczba ma
# od cholery metod i atrybutów, np. 5.__add__(3) daje 8, czyli to samo co 5+3