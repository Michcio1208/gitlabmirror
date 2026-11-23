%Zad1
clear all
f=@(x) x^3-3*x+1;
fp=@(x) 3*x^2-3;
options=optimset('TolX',0);
xd=fzero(f,[1,2],options);
x0=2;
x1=1.8;

[x_n,err_n]=newton(f,fp,x0,xd);
[x_b,err_b]=bisekcja(f,1,2,xd);
[x_s,err_s]=sieczne(f,x0,x1,xd);


figure(1)
semilogy(err_n)
hold on;
semilogy(err_b)
semilogy(err_s)
legend('newton','bisekcja','sieczne')
hold off;

[idx_b,p_b]=logarytmy(err_b);
[idx_n,p_n]=logarytmy(err_n);
[idx_s,p_s]=logarytmy(err_s);

fprintf('Rząd zbieżności p: bisekcja = %.4f, newton = %.4f, sieczne = %.4f\n', p_b, p_n, p_s); % wypisuje wyznaczone wartości rzędu zbieżności p dla trzech metod

C_n = err_n(idx_n(end)+1) / (err_n(idx_n(end))^2); % wyznacza współczynnik C dla metody Newtona (p = 2) z ostatniej iteracji spełniającej warunek > 1e-12
C_s = err_s(idx_s(end)+1) / (err_s(idx_s(end))^((1+sqrt(5))/2)); % wyznacza współczynnik C dla metody siecznych (p = (1+sqrt(5))/2) z ostatniej iteracji spełniającej warunek > 1e-12
fprintf('Współczynnik C: newton = %.4f, sieczne = %.4f\n', C_n, C_s); % wypisuje wyznaczone wartości współczynnika C

figure(2)
loglog(err_b(1:end-1), err_b(2:end), 'o') % rysuje zależność błędu następnego od bieżącego (Delta_{i+1} od Delta_i) dla bisekcji zamiast błędu od numeru iteracji
hold on;
loglog(err_n(1:end-1), err_n(2:end), 'o') % rysuje zależność Delta_{i+1} od Delta_i dla metody Newtona
loglog(err_s(1:end-1), err_s(2:end), 'o') % rysuje zależność Delta_{i+1} od Delta_i dla metody siecznych
legend('bisekcja','newton','sieczne') % poprawia kolejność etykiet w legendzie, aby odpowiadała kolejności wywołań loglog
xlabel('\Delta_i'); % dodaje opis osi poziomej
ylabel('\Delta_{i+1}'); % dodaje opis osi pionowej
title('Zależność \Delta_{i+1} od \Delta_i w skali log-log'); % dodaje tytuł wykresu
hold off;

%fucnkje

function [idx,p]=logarytmy(err)
idx=find(err(1:end-1)>1e-12 & err(2:end)>1e-12);
px=polyfit(log(err(idx)),log(err(idx+1)),1);
p=px(1);
end

function [x,err]=newton(f,fp,x0,xd)
i=0;
x=x0;
while i<100 && abs(x-xd)>1e-14
x=x-f(x)/fp(x);
i=i+1;
err(i)=abs(x-xd);
end
end 


function [x,err]=bisekcja(f,x0,x1,xd)
i=0;
x=x0;
while abs(x-xd)>1e-14 && i<100
x=(x0+x1)/2;
i=i+1;
if f(x0)*f(x)<0
x1=x;
else 
x0=x;
end
err(i)=abs(x-xd);
end
end

function [x,err]=sieczne(f,x0,x1,xd)
i=0;
x_old=x1;
x_older=x0;
while abs(x_old-xd)>1e-14 && i<100
x_new=x_old-f(x_old)*(x_old-x_older)/(f(x_old)-f(x_older));
i=i+1;
err(i)=abs(x_new-xd);
x_older=x_old;
x_old=x_new;
end
x=x_new;
end
%% Zad2

