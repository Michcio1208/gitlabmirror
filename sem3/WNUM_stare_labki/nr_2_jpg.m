clear 
syms I1 I2 I3 I4 I5;
R1=5,R2=5,R3=5,R4=5,R5=5;
R=[R1,R2,R3,R4,R5];
E=3;
row1=I1*R1==E-I5*R5;
row2=I2*R2==E-I4*R4;
row3=I3*R3==I4*R4-I5*R5;
row4=I2==I4+I3;
row5=I5==I1+I3;
[A,b]=equationsToMatrix([row1,row2,row3,row4,row5],[I1,I2,I3,I4,I5]);
A=double(A)
b=double(b)
Inum=A\b
%%
R_z=R;
N=50;
for n=1:N
    for i=1:5
    R_z(i)=R(i)*(1+(6*1e-3)*randn);
    end
    row1=I1*R_z(1)==E-I5*R_z(5);
    row2=I2*R_z(2)==E-I4*R_z(4);
    row3=I3*R_z(3)==I4*R_z(4)-I5*R_z(5);
    row4=I2==I4+I3;
    row5=I5==I1+I3;
    [A_z,b_z]=equationsToMatrix([row1,row2,row3,row4,row5],[I1,I2,I3,I4,I5]);
    A_z=double(A_z);
    b_z=double(b_z);
    Izab=A_z\b_z;
    blad_I(n)=norm(Izab-Inum);
    blad_I3(n)=norm(Izab(3)-Inum(3));
    
end
I_avg=mean(blad_I)
I_max=max(blad_I)
I3_avg=mean(blad_I3)
I3_max=max(blad_I3)


%%
clear
A=20*eye(15,15);
for i=1:15
    for j=1:15
    if abs(i-j)==1 | abs(i-j)==2 
        A(i,j)=0.7;
    end

    end
end
b=sum(A,2);
xnum=A\b;
norm(xnum-ones(15,1));
%%
D=diag(diag(A));
U=triu(A)-D;
L=tril(A)-D;
Mj=-inv(D)*(L+U);
wj=inv(D)*b;
p=2/(min(eig(A))+max(eig(A)));

j=1;
jmax=50;

x_oldj=zeros(numel(b),1);
xj=x_oldj;

while(j<=jmax)
x_newj=Mj*xj(:,end)+wj;
xj=[xj x_newj];
x_oldj=x_newj;
blad_j(j)=norm(x_newj-ones(numel(b),1));
j=j+1;
end


p=[1.06 (2/(max(eig(A))+min(eig(A))))];


M=eye(15)-p(1)*A;
w=p(1)*b;

i=1;
imax=50;

x_old=zeros(numel(b),1);
x=x_old;

while(i<=imax)
    x_new=M*x(:,end)+w;
    x=[x x_new];
    x_old=x_new;
    blad(i)=norm(x_new-ones(numel(b),1));
    i=i+1;
end

Mo=eye(15)-p(2)*A;
wo=p(2)*b;

io=1;
imaxo=50;

x_oldo=zeros(numel(b),1);
xo=x_oldo;

while(io<=imaxo)
    x_newo=Mo*xo(:,end)+wo;
    xo=[xo x_newo];
    x_oldo=x_newo;
    blado(io)=norm(x_newo-ones(numel(b),1));
    io=io+1;
end

semilogy(blad_j)
xlabel("nr iteracji")
ylabel("norm(x-xd)")
hold on;
semilogy(blad)
hold on;
semilogy(blado)
legend('metoda jakobiego','metoda richardsona','metoda Richardson opt')