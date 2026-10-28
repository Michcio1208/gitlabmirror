% u1 u2 u3 u4 i1 i3 i5 i7
clear
r1=2; r3=2; r5=2;
r7=1; r8=1; r2=4; r4=4;r6=4;
e0=12;
r=[r1 r2 r3 r4 r5 r6 r7 r8];
A=[1 0 0 0 r1 0 0 0;
    1 -1 0 0 0 -r3 0 0;
    0 1 -1 0 0 0 -r5 0
    0 0 1 -1 0 0 0 -r7
    0 0 0 1 0 0 0 -r8
    0 0 1 0 0 0 -r6 r6
    0 1 0 0 0 -r4 r4 0
    1 0 0 0 -r2 r2 0 0
    ];
b=[e0 0 0 0 0 0 0 0]';
x=A\b;
u_3=x(3);
% e0 - i1*r1=u1 ->u1 + i1*r1 =e0
% u1 -i3*r3=u2-> u1 -u2-i3*r3=0
% u2-i5*r5=u3-> u2 -u3 -i5*r5=0
% u3-i7*r7=u4->u3-u4-i7*r7=0
% u4=r8*i7->u4-r8*i7=0
% u3= r6*(i7-i5)-> -u3+r6*i7-r6*i5=0
% u2= r4*(i5-i3)-> -u2+r4*i5-r4*i3=0 
% u1= r2*(i3-i1)-> -u1+r2*i3-r2*i1=0
%%
r5_z=r5*(1+0.01*(2*rand-1));
A(3,7)=-r5_z;
xn=A\b;
zmiana_U3_1=abs(xn(3)-x(3));
%%
for i=1:100
r5_z=r5*(1+0.01*(2*rand-1));
A(3,7)=-r5_z;
xz=A\b;
blad(i)=abs(xz(3)-u_3)/abs(u_3);
end
mean(blad)
max(blad)

%%
clear
N=6;
for i=1:N
    for j=1:N
        A(i,j)=1/(i+j+6);
    end
end
b=sum(A,2);
x=A\b;
delta_x=norm(x-ones(N,1))/norm(ones(N,1))
fprintf("cond(A)=%d\n",cond(A))
%%
clear
for N=3:15
for i=1:N
    for j=1:N
        A(i,j)=1/(i+j+6);
    end
end
b=sum(A,2);
x=A\b;
delta_x(N)=norm(x-ones(N,1))/norm(ones(N,1));
wskaz(N)=cond(A);
%fprintf("cond(A)=%d\n",cond(A))
end
semilogy(delta_x)
hold on;
semilogy(wskaz)


for N1=3:15
for i=1:N1
    for j=1:N1
        A1(i,j)=1/(i+j+6);
    end
end
A1=A1+16*eye(N1);
b1=sum(A1,2);
x1=A1\b1;
delta_x1(N1)=norm(x1-ones(N1,1))/norm(ones(N1,1));
wskaz1(N1)=cond(A);
%fprintf("cond(A)=%d\n",cond(A))
end
semilogy(delta_x1)
hold on;
semilogy(wskaz1)
legend('delta_x','cond A','delta_x1','cond A1')