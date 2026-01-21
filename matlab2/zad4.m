t = 0:0.05:100; 


A = 1; B = 1;
a = 3; b = 4; 
delta = pi/2;

x = A * sin(a * t + delta);
y = B * sin(b * t);
z = t; 

figure;
a=
b=
c=()
plot()

figure;
plot(x, y); 
title('Krzywa Lissajous 2D');
grid on;


figure;
plot3(x, y, z);
title('Krzywa Lissajous w 3D');
xlabel('x'); ylabel('y'); zlabel('czas');
grid on;