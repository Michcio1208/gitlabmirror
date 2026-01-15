clear all
clc
close all
t = 0:0.1:10;
figure;             
plot(t, t, 'b');    % f(x) = x
hold on            
plot(t, t.^2, 'r'); % f(x) = x^2 (potęgowanie element po elemencie .^) 
plot(t, t.^3, 'g'); % f(x) = x^3
hold off            