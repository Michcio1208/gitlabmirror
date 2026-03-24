clear all
clc
close all
t = 0:0.01:10;
figure(1);
s=5*sin(2*pi*t);
plot(t,s);
grid()
xlabel('Czas')
ylabel('wartosc')
title('sinus')
ylim([-6 6])


figure(2);
plot(t, t, 'b');    % f(x) = x
hold on            
plot(t, t.^2, 'r'); % f(x) = x^2  
plot(t, t.^3, 'g'); % f(x) = x^3
hold off  

figure(3);
loglog(t,t.^2+1); % f(x) = x^2+1 w skali logarytmicznej 

figure(4);
plot(t,t.^2+1); % f(x) = x^2+1 w skali logarytmicznej 
yscale("log")

figure(5);
subplot(3,1,1);
plot(t, t, 'b');    % f(x) = x
xlabel('Czas')
ylabel('wartosc')
title('x')
subplot(3,1,2)
plot(t, t.^2, 'r'); % f(x) = x^2  
xlabel('Czas')
ylabel('wartosc')
title('x^2')
subplot(3,1,3);
plot(t, t.^3, 'g'); % f(x) = x^3
xlabel('Czas')
ylabel('wartosc')
title('x^3')
figura_5=figure(5);
savefig(figura_5,"Figura_nr_5");
