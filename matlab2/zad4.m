clear variables
clc
close all

x = -5:0.5:15;
y = -5:0.5:15;
[X, Y] = meshgrid(x, y);

Z = (X - 5).^2 + (Y - 3).^2;
figure;
mesh(X, Y, Z);

title('Wykres funkcji f(x, y) = (x - 5)^2 + (y - 3)^2');
xlabel('Oś X');
ylabel('Oś Y');
zlabel('f(x, y)');
grid on;
%%
clear variables
clc
close all

t = 0:0.05:100; 


A = 1; B = 1;
a = 3; b = 4; 
delta = pi/2;

x = A * sin(a * t + delta);
y = B * sin(b * t);
z = t; 

figure;
plot(x, y); 
title('Krzywa Lissajous 2D');
grid on;

figure;
plot3(x, y, z);
title('Krzywa Lissajous w 3D');
xlabel('x'); ylabel('y'); zlabel('czas');
grid on;