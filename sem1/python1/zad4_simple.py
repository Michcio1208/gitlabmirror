"""Proste rozwiązanie zadania 4.
 - generuje listę temperatur w Fahrenheita z listy temperatur w Celsjuszu (lista składana),
 - tworzy listę samogłosek występujących w zadanym tekście (lista składana z filtrem).
"""

POLISH_VOWELS = set("aeiouyąęóAEIOUYĄĘÓ")


def celsius_to_fahrenheit(c_list):
    """Zwraca listę Fahrenheitów odpowiadającą listcie Celsiusów."""
    return [c * 9 / 5 + 32 for c in c_list]


def extract_vowels(text: str):
    """Zwraca listę samogłosek występujących w tekście (kolejność i powtórzenia zachowane)."""
    return [ch for ch in text if ch in POLISH_VOWELS]



celsius = [0, 20, 37, 100]
fahrenheit = celsius_to_fahrenheit(celsius)
print("Celsius:", celsius)
print("Fahrenheit:", [round(x, 2) for x in fahrenheit])

# Przykładowy tekst (można zastąpić dłuższym tekstem)
text = "Jak był Stefek Burczymucha - ja nikogo się nie boję!"
vowels = extract_vowels(text)
print("\nTekst:\n", text)
print("Lista samogłosek:")
print(vowels)
print("Połączone:", ''.join(vowels))