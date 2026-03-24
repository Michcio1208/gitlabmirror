```
Wstępdoinformatyki–WINF
Laboratorium nr 10 (Po prostu Python - cz. 1)
```
```
G.Nieradka, M. Linczuk
Warszawa, Grudzień 2025
```
```
Uwagidowykonaniazadań.
Pierwsze dwa zadania są w formacie notatnika programuJupyter, czyli programu, który jest bliski
realizacji styluprogramowania piśminnego. W czasie realizacji zadania notatniki powinny być mo-
dyfikowane przez dodanie odpowiednich komórek zawierających kod wykonywalny językaPython
oraz opisy w formaciemarkdown.
Jako wynik proszę zapisać notatniki, pliki o rozszerzaniu.ipynb, z zawartościami komórek, za-
wierającymi efekty Państwa pracy i umieścić je na serwerze LeON.
Pozostałe dwa zadania (nr 3 i 4) są zadaniami, których efektem powinny być skrypty w języku
Python, czyli pliki z rozszerzeniem.py. Aby napisać te pliki można używać dowolnego edytora tek-
stowego, ale można również wesprzeć się dedykowanym ku temu celowi programem. Chyba jednym
z najpolularniejszych tego typu programów jestSpyder. Jest to dosyć popularne oprogramowanie,
które umożliwia również pracępracę zdalną na serwerzea po zainstalowaniu odpowiedniejwtyczki
również edycję plików w formacie notatników Jupytera (.ipynb).
Niestety na komputera laboratoryjnych nie zostało ono zainstalowane ale można przeprowadzić
jego instalację bez praw administratora (np. prowadzący na swoim koncie wykonał taki zestaw in-
strukcji):
```
1 mkdirspyder-ide
2 cd spyder-ide
3 wget
↪ https://github.com/spyder-ide/spyder/releases/latest/download/Spyder-Linux-x86_64.sh
4 chmod+x Spyder-Linux-x86_64.sh
5 ./Spyder-Linux-x86_64.sh

```
Po niestety dłuższej chwili wszystko przebiegło bez problemów i można było uruchomić i używać
Spyder-a.
Uwaga! Propozycja używania Spydera – jest jedynie propozycją![sic!]. Do Państwa należy wybór ja-
kiego edytora będą Państwo używać – popularny jest teżVSCode. Jeżeli ktoś lubi można także te
zadania wykonać w Jupyterze i jako wynik zamieścić pliki notatników.ipynb.
```
```
∀bugs∃fix() ⇒ coffee++ Programming all day , debugging all night!
```
```
Zadanie3.
Ze stron GUS ściągnąćplik CSV dotyczący rocznych wskaźników cen towarów i usług konsumpcyj-
nych od 1950 roku. Napisać program, który:
```
- wczytadaneztegoplikujakosłownik,któregokluczembędzierok,awartościąwskaźnikinflacji
- obliczy,wykorzystującfunkcjezmodułunumpy,wartośćśredniąiodchyleniestandardowewskaź-
    nika inflacji
- Dla chętnych!:wyświetli, przy użyciu funkcji modułumatplotlib, wykres wskaźnika inflacji;
    wykres ten powinien być opatrzony tytułem i opisami osi, narysowany linią ciągłą w kolorze
    czerwonym


**Zadanie4.**
Napisać skrypt, który wykorzystując mechnizm listy składanej:

- Utworzy listę wartości zawierającą wartości temperatury w stopniach Fahrenheita dla zadanej
    listy wartości temperatur w stopniach Celsjusza. Listę wartości w stopniach Celsjusza zdefinio-
    wać w skrypcie.
- Utworzy listę zawierającą same samogłoski, znajdujące się z zmiennejtekst.
    Zmiennatekstmoże być dowolnym łańcuchem znaków, w szczególności np. być tekstem wier-
    sza „Stefek Burczymucha”:
       tekst = "
       Jak był Stefek Burczymucha...
       — Ja nikogo się nie boję!
       Choćby niedźwiedź... to dostoję!
       Wilki?.. Ja ich całą zgraję
       Pozabijam i pokraję!
       Te hijeny, te lamparty,
       To są dla mnie czyste żarty!
       A pantery i tygrysy
       Na sztyk wezmę u swej spisy!
       Lew!... Cóż lew jest? — kociak duży!
       Naczytałem się podróży!
       I znam tego jegomości,
       Co zły tylko kiedy pości.
       Szakal, wilk?... Straszna nowina!
       To jest tylko większa psina!...
       (Brysia mijam zaś zdaleka,
       Bo nie lubię, gdy kto szczeka!)
       Komu zechcę, to dam radę!
       Zaraz na ocean jadę,
       I nie będę Stefkiem chyba,
       Jak nie chwycę wieloryba!"
       tak przez dzień boży cały
       Zuch nasz trąbi swe pochwały.
       Aż raz usnął gdzieś na sianie...
       Wtem się budzi niespodzianie,
       Patrzy, a tu jakieś zwierzę
       Do śniadania mu się bierze.
       Jak nie zerwie się na nogi,
       Jak nie wrzaśnie z wielkiej trwogi —
       Pędzi, jakby chart ze smyczy...
       — Tygrys, tato! tygrys! — krzyczy.
       — Tygrys?... ojciec się zapyta.
       — Ach, lew może!... miał kopyta
       Straszne! Trzy czy cztery nogi,
       Paszczę taką! Przytem rogi...
       — Gdzież to było?
       — Tam na sianie,
       Właśnie porwał mi śniadanie...
       Idzie ojciec, służba cała,
       Patrzą... a tu myszka mała,
       Polna myszka siedzi sobie
       I ząbkami serek skrobie!...


Dobrze jest się uczyć Python’a

```
https://xkcd.com/353/
```

