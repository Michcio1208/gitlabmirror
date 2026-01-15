clear all
clc
close all

a=1;
b=[1;2;3];
c=eye(3,3);
a
b
c
%% 
clear all
clc
close all

x1=[1;2;3]
m1=[1,2,3;4,5,6;7,8,9]
mn=m1 * x1
x2=[4;5;6]
skal=x1.'*x2 %%iloczyn skalarny
skal2=dot(x1,x2)
zewn=x1*x2.' %% iloczyn zewnętrzny
t=[0:0.01:10];
f=1;
s=sin(2*pi*f*t)

