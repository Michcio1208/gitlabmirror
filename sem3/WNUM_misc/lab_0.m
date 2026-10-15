clear; clc; close all;

%% Zadanie 1
% 361 punktów równomiernie rozłożonych od 0 do 2*pi (krok co 1 stopień)
t = linspace(0, 2*pi, 361);

% Sprawdzenie warunku sin(t) > cos(t)
warunek = sin(t) > cos(t);
ile_punktow = sum(warunek);

% Znalezienie indeksu pierwszego punktu spełniającego warunek
indeks_pierwszego = find(warunek, 1);
kat_stopnie = rad2deg(t(indeks_pierwszego));

fprintf('--- ZADANIE 1 ---\n');
fprintf('Liczba punktów, w których sin(t) > cos(t): %d\n', ile_punktow);
fprintf('Pierwszy taki kąt to: %.2f stopni\n\n', kat_stopnie);

% WYJAŚNIENIE:
% Wynik to 46 stopni, a nie 45 stopni, z dwóch powodów:
% 1. Dla dokładnie 45 stopni (pi/4) sin(t) i cos(t) są sobie matematycznie równe, 
%    więc ostra nierówność sin(t) > cos(t) nie jest spełniona.
% 2. Nasza siatka 361 punktów ma krok dokładnie 1 stopnia (360 / (361-1) = 1),
%    więc kolejnym badanym punktem po 45 stopniach jest dopiero 46 stopni.
%    (Dodatkowo w arytmetyce zmiennoprzecinkowej sin(pi/4) < cos(pi/4) na ostatnim miejscu znaczącym).

%% Zadanie 2
x = linspace(-2, 2, 200);

% Funkcja dokładna oraz wielomiany Taylora wokół x0 = 0
y_dokl = exp(x);
T1 = 1 + x;
T2 = 1 + x + x.^2 / 2;
T3 = 1 + x + x.^2 / 2 + x.^3 / 6;

figure;
plot(x, y_dokl, 'k-', 'LineWidth', 2);
hold on;
plot(x, T1, 'r--');
plot(x, T2, 'b-.');
plot(x, T3, 'g:', 'LineWidth', 1.5);
hold off;

grid on;
xlabel('x');
ylabel('y');
title('Przybliżenia funkcji e^x wielomianami Taylora');
legend('e^x', 'Rząd 1 (T1)', 'Rząd 2 (T2)', 'Rząd 3 (T3)', 'Location', 'northwest');

% WYJAŚNIENIE:
% Przybliżenia są dobre w otoczeniu punktu rozwinięcia, czyli blisko x = 0.
% Im wyższy rząd wielomianu Taylora, tym szerszy jest przedział wokół zera,
% w którym przybliżenie pokrywa się z funkcją e^x.

%% Zadanie 3
wynik = exp(pi) - pi;

fprintf('--- ZADANIE 3 ---\n');
fprintf('5 cyfr znaczących: %.5g\n', wynik);
fprintf('Szerokość 12, 4 miejsca po przecinku: %12.4f\n\n', wynik);

%% Zadanie 4
rng(1);
A = rand(4);

gornotrojkatna = triu(A);
suma_glowna = sum(diag(A));               % alternatywnie: trace(A)
suma_anty = sum(diag(fliplr(A)));         % fliplr odwraca macierz poziomo

B = A' * A;
czy_symetryczna = issymmetric(B);         % zwraca 1 (true), jeśli symetryczna

fprintf('--- ZADANIE 4 ---\n');
disp('Część górnotrójkątna macierzy A:');
disp(gornotrojkatna);
fprintf('Suma głównej przekątnej: %.4f\n', suma_glowna);
fprintf('Suma drugiej (anty) przekątnej: %.4f\n', suma_anty);
fprintf('Czy A''*A jest symetryczna? (1=tak, 0=nie): %d\n\n', czy_symetryczna);

%% Zadanie 5
% Sposób 1: Pętla for
H_for = zeros(1, 30);
suma = 0;
for n = 1:30
    suma = suma + 1/n;
    H_for(n) = suma;
end

% Sposób 2: Jedna linia z użyciem cumsum
H_cumsum = cumsum(1 ./ (1:30));

fprintf('--- ZADANIE 5 ---\n');
fprintf('H(30) z pętli for: %.6f\n', H_for(end));
fprintf('H(30) z cumsum:    %.6f\n\n', H_cumsum(end));

%% Zadanie 6
n = 0;
H = 0;
while H <= 10
    n = n + 1;
    H = H + 1/n;
end

fprintf('--- ZADANIE 6 ---\n');
fprintf('Najmniejsze n, dla którego H(n) > 10 to: %d (H = %.6f)\n\n', n, H);

% WYJAŚNIENIE:
% Pętla 'for' wymaga z góry określonej liczby iteracji (zakresu), a przed 
% wykonaniem obliczeń nie wiemy, dla jakiego n suma przekroczy 10. 
% Pętla 'while' działa dopóki warunek jest spełniony, więc sama zatrzymuje się 
% dokładnie w odpowiednim momencie (dla n = 12367).

%% Zadanie 7
% Znalezienie liczb pierwszych <= 100 za pomocą isprime i find
liczby_pierwsze = find(isprime(1:100));

ile_pierwszych = length(liczby_pierwsze);
suma_pierwszych = sum(liczby_pierwsze);

% diff oblicza różnice między kolejnymi liczbami pierwszymi
pary_blizniacze = sum(diff(liczby_pierwsze) == 2);

fprintf('--- ZADANIE 7 ---\n');
fprintf('Liczba liczb pierwszych <= 100: %d\n', ile_pierwszych);
fprintf('Suma tych liczb: %d\n', suma_pierwszych);
fprintf('Liczba par różniących się o 2: %d\n\n', pary_blizniacze);

%% Zadanie 8
fprintf('--- ZADANIE 8 ---\n');
fprintf(' k |         (1 - cos(x))/x^2      |      2*sin^2(x/2)/x^2\n');
fprintf('--------------------------------------------------------------\n');

for k = 1:9
    x = 10^(-k);
    wzor1 = (1 - cos(x)) / x^2;
    wzor2 = 2 * sin(x/2)^2 / x^2;
    fprintf('%2d | %29.15f | %25.15f\n', k, wzor1, wzor2);
end

% WYJAŚNIENIE:
% Dla dużych k (gdy x jest bardzo bliskie 0), wartość cos(x) jest ekstremalnie 
% bliska 1. W pierwszym wzorze odejmujemy od siebie dwie niemal identyczne liczby 
% (1 - cos(x)), co w arytmetyce zmiennoprzecinkowej powoduje tzw. redukcję cyfr 
% znaczących (catastrophic cancellation). W efekcie tracimy precyzję, a dla k >= 8 
% komputer zaokrągla cos(x) do dokładnie 1, przez co wzór pierwszy daje wynik 0.
% Drugi wzór unika odejmowania bliskich sobie liczb i zachowuje pełną dokładność (0.5).