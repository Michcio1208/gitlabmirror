# ==========================================
# 2. WIDOK (Interfejs i Prezentacja Danych)
# ==========================================
class BankView:
    """Odpowiada za wyświetlanie menu i pobieranie danych od bankiera."""
    def pobierz_dane_wniosku(self):
        print("\n--- FORMULARZ NOWEGO WNIOSKU KREDYTOWEGO ---")
        name = input("Imię i Nazwisko klienta: ")
        income = float(input("Miesięczny dochód (PLN): "))
        amount = float(input("Wnioskowana kwota kredytu (PLN): "))
        return name, income, amount

    def wyswietl_wynik_weryfikacji(self, sukces):
        if sukces:
            print("[WIDOK]: Decyzja pozytywna. Wniosek spełnia kryteria.")
        else:
            print("[WIDOK]: ODRZUCENIE WNIOSKU. Brak zdolności kredytowej.")

    def wyswietl_rejestr(self, wnioski):
        print("\n--- REJESTR ZAAKCEPTOWANYCH WNIOSKÓW ---")
        if not wnioski:
            print("Brak zatwierdzonych wniosków w systemie.")
        for w in wnioski:
            print(f"Wniosek #{w.id} | Identyfikator Klienta: *{w.name}* | Kwota: {w.requested_amount} PLN | Status: {w.status}")

    def wyswietl_menu(self):
        print("\n=== KORPORACYJNY SYSTEM BANKOWY v0.46 ===")
        print("1. Procesuj nowy wniosek kredytowy")
        print("2. Wyświetl rejestr zaakceptowanych wniosków")
        print("3. Wyjście z systemu")
        return input("Wybierz opcję (1-3): ")
