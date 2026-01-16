clear variables
clc
close all

X = zeros(4,4);
X(1:2, 3:4) = 1; 
X(3:4, 1:2) = 1;
figure(1);
imagesc(X);
%%
Y=zeros(64,64);
indeksy = mod(0:63, 4) + 1;
Y=X(indeksy,indeksy);
figure(2);
imagesc(Y);
%%
Z=[X, X ; X , X]; % 4x4
Z=[Z,Z ; Z, Z]; % 16x16
Z=[Z,Z ; Z, Z]; % 32x32
Z=[Z,Z ; Z, Z]; % 64x64
figure(3);
imagesc(Z);
