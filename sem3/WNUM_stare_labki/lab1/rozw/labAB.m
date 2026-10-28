clear
A=[2 1 -2;1 5 -3;3 -9 1];
b=[1;25;15];
for i=1:numel(b)
    b_z(i,1)=((1e-5)*(2*rand-1));
end
%b_z=b_z'; jakby bylo b_z(i)
[L,U]=lu(A);
y=L\b;
x=U\y;

b2=b+b_z;
y2=L\b2;
x2=U\y2;
blad_t=cond(A)*norm(b_z)/norm(b)
blad_r=norm(x2-x)/norm(x)
if blad_r<blad_t
fprintf("jd\n");
else

fprintf("nie jd\n");
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
x0=[3 3 3 3 3 3]';
omega=1.02;
D=diag(diag(A));
L=tril(A)-D;
U=triu(A)-D;
b=sum(A,2);
M=(inv(D+omega*L))*((1-omega)*D-omega*U);
w=omega*(inv(D+omega*L))*b;
x_old=x0;
error=5*1e-12;
i=1;
imax=100;
x=x_old;
while(error>=1e-12 & i<imax) 
    x_new=M*x_old+w;
    x=[x x_new];
    error(i)=norm(x_new-x_old);
    x_old=x_new;
    i=i+1;
end
x_new;
semilogy(error)
hold on;
xlabel("nr iteracj")
ylabel("error")
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
x0=[3 3 3 3 3 3]';
D=diag(diag(A));
L=tril(A)-D;
U=triu(A)-D;
b=sum(A,2);
omega_v=[1.1 1.2 1.3 1.5 1.8 1.9 2];
for omega=omega_v
   
    M=(inv(D+omega*L))*((1-omega)*D-omega*U);
    w=omega*(inv(D+omega*L))*b;
    x_old=x0;
    error=5*1e-12;
    i=1;
    imax=100;
    x=x_old;
    while(error(end)>=1e-12 & i<imax) 
        x_new=M*x_old+w;
        x=[x x_new];
        error(i)=norm(x_new-x_old);
        x_old=x_new;
        i=i+1;
    end
    x_new;
    semilogy(error)
    hold on;
    xlabel("nr iteracji")
    ylabel("error")

end 
legend('om1','om2','om3','om4','om5','om6','om7')