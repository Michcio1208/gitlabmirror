# Potrzebne importy
from model import BankStorageService, CreditRiskEvaluator, BankStorageService
from widok import BankView
from kontroler import BankController, HardwareSecurityController

# Uruchomienie systemu
if __name__ == "__main__":
    magazyn = BankStorageService()
    ryzyko = CreditRiskEvaluator()
    widok = BankView()
    zabezpieczenia = HardwareSecurityController()
    app = BankController(magazyn, ryzyko, widok, zabezpieczenia)
    app.uruchom()
