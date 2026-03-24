% WINF lab 14, sem. 2025Z
% rozprzestrzenianie siê Koronawirusa w Województwie Mazowieckim

clear
load covid1.txt

figure(1)
plot(covid1);
title('ca³kowita liczba zaka¿eñ od 08.03.2020');
xlabel('dzieñ pandemii');
ylabel('wykryta liczba zaka¿eñ');

figure(2)
x=covid1(184:1:214);    % wybieramy dni do analizy, to jest x[n]
plot(184:1:214,x);
title('liczba zaka¿eñ od 184 do 214 dnia pandemii');
xlabel('dzien pandemii');
ylabel('wykryta liczba zaka¿eñ');

N=length(x);            % liczba analizowanych dnia pandemii

% wyznacz wspó³czynnik k zgodnie ze wzorem (4)
% k = 
disp('Wspó³czynnik transmisji wirusa:');
disp(k)

% wyznacz zgodnie ze wzorem 8 
% wektorK=
% x1 = 
disp('Liczba zaka¿eñ pierwszego dnia:');
disp(x1)

% wyznacz zgodnie ze wzorem 9 
% xn = 

figure(3)
plot(184:1:214,x,'b');
hold on
plot(184:1:214,xn,'r');
title('liczba zaka¿eñ od 184 do 214 dnia pandemii');
xlabel('dzien pandemii');
ylabel('liczba zaka¿eñ');


