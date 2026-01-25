% WINF lab 14, sem. 2025Z
% Rozprzestrzenianie się Koronawirusa w Województwie Mazowieckim

clear
clc
clear variables
load covid1.txt

% --- Wizualizacja wszystkich danych ---
figure(1)
plot(covid1);
title('całkowita liczba zakażeń od 08.03.2020');
xlabel('dzień pandemii');
ylabel('wykryta liczba zakażeń');

% --- Wybór zakresu danych (dni 184-214) ---
figure(2)
x=covid1(184:1:214);    % wybieramy dni do analizy, to jest x[n]
plot(184:1:214,x);
title('liczba zakażeń od 184 do 214 dnia pandemii');
xlabel('dzien pandemii');
ylabel('wykryta liczba zakażeń');

N=length(x);            % liczba analizowanych dni pandemii

% --- ZADANIE 1: Wyznacz współczynnik k (Wzór 4) ---

licznik_k = sum(x(1:N-1) .* x(2:N));
mianownik_k = sum(x(1:N-1).^2);
k = licznik_k / mianownik_k;

disp('Współczynnik transmisji wirusa:');
disp(k) 


% --- ZADANIE 2: Wyznacz x1 (Wzór 8) ---


n_vec = 1:(N-1);      
wektorK = k .^ n_vec;   

licznik_x1 = sum(wektorK .* x(2:N)'); 
mianownik_x1 = sum(wektorK .^ 2);

x1 = licznik_x1 / mianownik_x1;

disp('Liczba zakażeń pierwszego dnia:');
disp(x1)

% --- ZADANIE 3: Wyznacz wektor predykcji xn (Wzór 9) ---
% x[n] = x1 * k^(n-1). Generujemy potęgi od 0 do N-1.

potegi = 0:(N-1);
xn = x1 * (k .^ potegi); 

% --- Wizualizacja wyników ---
figure(3)
plot(184:1:214,x,'b'); % Dane rzeczywiste (niebieski)
hold on
plot(184:1:214,xn,'r'); % Model teoretyczny (czerwony)
title('Porównanie: Rzeczywistość vs Model (dni 184-214)');
xlabel('dzien pandemii');
ylabel('liczba zakażeń');
legend('Dane rzeczywiste', 'Model estymowany');
grid on;