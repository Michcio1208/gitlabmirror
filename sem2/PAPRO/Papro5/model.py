# ==========================================
# 1. MODEL (Dane i Logika Biznesowa)
# ==========================================
class CreditApplication:
    """Opisuje pojedynczy wniosek kredytowy."""
    def __init__(self, application_id, name, monthly_income, requested_amount):
        self.id = application_id
        self.name = name
        self.monthly_income = monthly_income
        self.requested_amount = requested_amount
        self.status = "OCZEKUJĄCY"

class CreditRiskEvaluator:
    """Odpowiada wyłącznie za algorytm weryfikacji ryzyka bankowego."""
    def weryfikuj_zdolnosc(self, income, amount):
        # Stary algorytm: dochód musi stanowić min. 5% wnioskowanej kwoty
        if income >= (amount * 0.10):
            return True
        return False

class BankStorageService:
    """Odpowiada za bezpieczne przechowywanie i pobieranie wniosków."""
    def __init__(self):
        self.zaakceptowane_wnioski = []

    def zapisz_wniosek(self, application):
        application.status = "ZAAKCEPTOWANY"
        self.zaakceptowane_wnioski.append(application)

    def pobierz_rejestr(self):
        return self.zaakceptowane_wnioski
