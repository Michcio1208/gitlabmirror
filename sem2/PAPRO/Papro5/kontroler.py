# ==========================================
# 3. KONTROLER (Orkiestracja i Zabezpieczenia)
# ==========================================
# Potrzebne importy
from model import CreditApplication


class HardwareSecurityController:
    """Integracja z fizycznymi zabezpieczeniami (np. czytnik kart)."""
    def weryfikuj_stanowisko(self):
        # Symulacja sprawdzania urządzeń peryferyjnych przy wyjściu
        pass

class BankController:
    """Główny koordynator sterujący działaniem aplikacji."""
    def __init__(self, storage, evaluator, view, hardware):
        self.storage = storage
        self.evaluator = evaluator
        self.view = view
        self.hardware = hardware
        self.app_id_counter = 1

    def uruchom(self):
        while True:
            wybor = self.view.wyswietl_menu()

            if wybor == "1":
                name, income, amount = self.view.pobierz_dane_wniosku()
                wniosek = CreditApplication(self.app_id_counter, name, income, amount)
                self.app_id_counter += 1
                
                ma_zdolnosc = self.evaluator.weryfikuj_zdolnosc(wniosek.monthly_income, wniosek.requested_amount)
                
                if ma_zdolnosc:
                    self.storage.zapisz_wniosek(wniosek)
                    self.view.wyswietl_wynik_weryfikacji(True)
                else:
                    self.view.wyswietl_wynik_weryfikacji(False)

            elif wybor == "2":
                rejestr = self.storage.pobierz_rejestr()
                self.view.wyswietl_rejestr(rejestr)

            elif wybor == "3":
                self.hardware.weryfikuj_stanowisko()
                print("Zamykanie systemu...")
                break
