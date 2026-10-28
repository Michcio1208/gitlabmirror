clear
% i1 i2 i3 i4 i5
r1=5;r2=5;r3=5;r4=5;r5=5;
r=[r1 r2 r3 r4 r5];
A=[r1 0 0 0 r5;
    0 r2 0 r4 0;
    0 0 r3 -r4 r5;
    0 1 -1 -1 0;
    1 0 1 0 -1];
b=[3;3;0;0;0];
x=A\b;

for i=1:numel(r)
r_z(i)=r(i)*(1+6*(1e-3)*(randn));
end
Az=[r_z(1) 0 0 0 r_z(5);
    0 r_z(2) 0 r_z(4) 0;
    0 0 r_z(3) -r_z(4) r_z(5);
    0 1 -1 -1 0;
    1 0 1 0 -1];
x_z=Az\b;
norm(x_z(3)-x(3))
%%
clear
N=15;
A=20*eye(N);
for i=1:N
    for j=1:N
        if abs(i-j)==1 | abs(i-j)==2
            A(i,j)=0.7;
        end
    end
end
b=sum(A,2);
x=A\b;
norm(x-ones(N,1))

%%
N=15;
A=20*eye(N);
for i=1:N
    for j=1:N
        if abs(i-j)==1 | abs(i-j)==2
            A(i,j)=0.7;
        end
    end
end
b=sum(A,2);

D=diag(diag(A));
L=tril(A)-D;
U=triu(A)-D;
p=1.06;
po=2/(min(eig(A))+max(eig(A)));
M1=-inv(D)*(L+U);
w1=inv(D)*b;
M=eye(N)-p*A;
w=p*b;
Mo=eye(N)-po*A;
wo=po*b;
x_old1=zeros(N,1);
x_old=zeros(N,1);
x_oldo=zeros(N,1);
n=1;
nmax=50;
while(n<=nmax)
x_new1=M1*x_old1+w1;
x_new=M*x_old+w;
x_newo=Mo*x_oldo+wo;
err1(n)=norm(x_new1-x_old1);
err(n)=norm(x_new-x_old);
erro(n)=norm(x_newo-x_oldo);
x_old1=x_new1;
x_old=x_new;
x_oldo=x_newo;
n=n+1;
end
semilogy(err1)
hold on;
semilogy(err)
hold on
semilogy(erro)
legend('jacobi','richardson','optimal Richardson')
xlabel('# iteracji')
ylabel('błąd')
