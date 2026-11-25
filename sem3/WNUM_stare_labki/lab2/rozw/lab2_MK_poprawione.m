%% Lab 2, grupa B
% Imię i nazwisko: Michał Krystecki
% Uzupełnij miejsca oznaczone TODO. Skrypt ma działać po uruchomieniu w całości
% (Run) i generować wszystkie wymagane wykresy.
clear; close all; clc;

%% Zad. 1 (4 pkt)
% Przydatne funkcje:
% - @(x) ...: funkcja anonimowa
% - fzero: pierwiastek funkcji skalarnej (funkcja, przedział lub punkt, opcje przez optimset)
% - abs: wartość bezwzględna
% - loglog: wykres ze skalą logarytmiczną na obu osiach
% - hold on: dorysowywanie kolejnych krzywych na tym samym wykresie
% - xlabel, ylabel, legend: opisy osi, legenda
% - fprintf: sformatowane wypisanie wyników
% TODO
f=@(x) x^3-4*x+1;
fp=@(x) 3*x^2-4;
options=optimset('TolX',0);
xd=fzero(f,[1,2.5],options);

tolerancje={1e-1,1e-2,1e-3,1e-4,1e-5,1e-6,1e-7,1e-8,1e-9,1e-10,1e-11,1e-12,1e-13,1e-14,1e-15,1e-16};
tolerancje2=[1e-1,1e-2,1e-3,1e-4,1e-5,1e-6,1e-7,1e-8,1e-8,1e-9,1e-10,1e-11,1e-12,1e-13,1e-14,1e-15,1e-16];
for h=1:length(tolerancje)
toler=tolerancje{h};
[x,err,iter(h)]=newton1(f,fp,2.5,50,toler);
x_r(h)=abs(x(end)-xd);
fprintf("dla tolerancji %.e mamy %d iteracji a blad rzecz to %.6e\n",tolerancje{h},iter(h),x_r(h))
loglog(tolerancje{h},x_r(h),'o')
hold on;
end
loglog(tolerancje2,tolerancje2,'-')
hold off;


%% Zad. 2 (3 pkt)
% Przydatne funkcje:
% - diag, eye, ones: macierze diagonalne, jednostkowa, jedynek
% - \: operator lewego dzielenia macierzowego
% - norm: norma wektora (domyślnie 2-norma)
% - semilogy: wykres ze skalą logarytmiczną na osi y
% - polyfit(x, y, 1): dopasowanie prostej metodą najmniejszych kwadratów
% - find: indeksy elementów spełniających warunek
% - xlabel, ylabel, legend: opisy osi, legenda
% - fprintf: sformatowane wypisanie wyników
% TODO
M=3.5*eye(9);
n=9;
x_star=(1:n)' /n;
start=zeros(n,1);
for i=1:9
    for j=1:9
    if abs(i-j)==1
    M(i,j)=-1;
    end 
    end
end
b=M*x_star+x_star.^3;
f2=@(x) M*x+x.^3-b;
J=@(x) M+3*diag(x.^2);
[x2,err2,iter2]=newton2(f2,J,start,x_star);
b
f2(x2)
figure
semilogy(err2)
[idx,p]=indexer(err2);
p


%% Zad. 3 (2 pkt)
% Przydatne funkcje:
% - @(x) ...: funkcja anonimowa
% - plot, stairs: wykres liniowy, wykres schodkowy
% - isfinite: sprawdzenie, czy wartości są skończone
% - xlabel, ylabel, legend: opisy osi, legenda
% - fprintf: sformatowane wypisanie wyników
% TODO
f3=@(x) x^3-2*x+2;
fp3=@(x)3*x^2-2;
[x8,err8,iter8]=newton3_bs(f,fp,0,8);
x8
x_axis=linspace(-3,3,1201);

for k=1:length(x_axis)
x_k=x_axis(k);
[~,~,iterk(k)]=newton1(f3,fp3,x_k,100,1e-10);
end
plot(x_axis,iterk)

function [x,err,iter]=newton3_bs(f,fp,x0,n)
x_old=x0;
for i=1:n
x_new=x_old-f(x_old)/fp(x_old);
err(i)=abs(x_new-x_old);
x_old=x_new;
x(i)=x_new;
end
iter=i;
end

function [x,err,iter]=newton1(f,fp,x0,n,tol)
x_old=x0;
for i=1:n
x_new=x_old-f(x_old)/fp(x_old);
err(i)=abs(x_new-x_old);
x_old=x_new;
x(i)=x_new;
if err(i)<=tol
break
end
end
iter=i;
end

function [x,err,iter]=newton2(f,J,x0,xd)
x=x0;
i=0;
while norm(x-xd)>1e-12 && i<100
x=x-J(x)\f(x);
i=i+1;
err(i)=norm(x-xd);
end
iter=i;
end

function [idx,p] =indexer(err)
idx=find(err(1:end-1)>1e-12 & err(2:end)>1e-12);
px=polyfit(log(err(idx)),log(err(idx+1)),1);
p=px(1);
end
%% Zad. 4 (1 pkt). Komentarz
% Opisz zaobserwowane zjawiska i efekty numeryczne oraz wyjaśnij ich przyczyny.
% TODO (komentarz w tym miejscu)
%W zadaniu 1 bledy sa stale dla pewnych przedzialow. Znaczy to ze dla
%pewnych tolerancji w dana liczbe iteracji osiagamy zadana tolerancje przez
%to do pewnego momentu zmiany tolerancji beldy sa stale przedzialami.

%w zadaniu 2 jest pewien blad przez ktory wystepuje serializacja danych. p
%powinno wyjsc okolo 2 dla metody newtona, ale z powodu tego bledu p=ok1/3.
%W zadaniu 3 widzimy wyraźnie że metody są silnie zależne od punktu
%startowego. Dla niektorych punktow z tego przedzialu w ogole nie znajduja
%rozwiazania z zadana dokladnoscia , a dla innych punktow startowych robia
%w zaledwie kilka iteracji.