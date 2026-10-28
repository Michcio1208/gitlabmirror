clear
A=[2 1 -2;
    1 5 -3;
    3 -9 1];
b=[1 25 15]';

for i=1:numel(b)
    zab(i,1)=b(i,1)*((1e-5)*(2*rand-1));
end
b_z=b+zab;
x=A\b;
z=A\b_z;
blad_rz=norm(z-x)/norm(x)
blad_t=cond(A)*(norm(zab)/norm(b))
if blad_rz<blad_t
fprintf("jd\n\n")
else
    fprintf("nie jd\n\n")
end
%%
clear
A=(-4)*eye(6);
for i=1:6
    for j=1:6
    if abs(i-j)==2 | abs(i-j)==1
    A(i,j)=1;
    end
    end
end 
i=1;
imax=100;
omega=1.1;
x_old=[3 3 3 3 3 3]';
x=[];
b=sum(A,2);
D=diag(diag(A));
L=tril(A)-D;
U=triu(A)-D;
M=(inv(D+omega*L))*((1-omega)*D-omega*U);
w=omega*(inv(D+omega*L))*b;
err=1;
while(err>=1e-12 & i<imax)
x_new=M*x_old+w;
x=[x x_new];
err(i)=norm(x_new-x_old);
x_old=x_new;
i=i+1;
end
semilogy(err)
%%clear
A=(-4)*eye(6);
for i=1:6
    for j=1:6
    if abs(i-j)==2 | abs(i-j)==1
    A(i,j)=1;
    end
    end
end 
i=1;
imax=100;
omega=1.1;
x_old=[3 3 3 3 3 3]';
x=[];
b=sum(A,2);
D=diag(diag(A));
L=tril(A)-D;
U=triu(A)-D;
M=(inv(D+omega*L))*((1-omega)*D-omega*U);
w=omega*(inv(D+omega*L))*b;
err=1;
while(err>=1e-12 & i<imax)
x_new=M*x_old+w;
x=[x x_new];
err(i)=norm(x_new-x_old);
x_old=x_new;
i=i+1;
end
semilogy(err)
%%

clear
A=(-4)*eye(6);
for i=1:6
    for j=1:6
        if abs(i-j)==2 | abs(i-j)==1
            A(i,j)=1;
        end
    end
end 
imax=100;
omega_v=[1.1,1.2,1.3,1.5,1.8,1.9,2];
b=sum(A,2);
D=diag(diag(A));
L=tril(A)-D;
U=triu(A)-D;
 x=[];
for omega=omega_v
   x_old=[3 3 3 3 3 3]';
  i=1;
M=(inv(D+omega*L))*((1-omega)*D-omega*U);
w=omega*(inv(D+omega*L))*b;
err=1;
while(err>=1e-12 & i<imax)
    x_new=M*x_old+w;
    x=[x x_new];
    err(i)=norm(x_new-x_old);
    x_old=x_new;
    i=i+1;
end
semilogy(err)
hold on;
end
legend('1.1.','1.2','1.3','1.5','1.8','1.9','2')