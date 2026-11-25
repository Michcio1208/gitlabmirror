% Zad1
clear all
f=@(x) x^3-4*x+1;
fp=@(x) 3*x^2-4;
options=optimset('TolX',0);
xd=fzero(f,[1,2.5],options);

[x_n,err_n]=newton(f,fp,2.5,xd);
[x_b,err_b]=bisekcja(1,2.5,f,xd);
[x_s,err_s]=sieczne(2.5,2.3,f,xd);

figure(1)
semilogy(err_n)
hold on;
semilogy(err_b)
semilogy(err_s)
legend('N','b','s')

figure(2)
loglog(err_n(1:end-1),err_n(2:end),'o')
hold on;
loglog(err_b(1:end-1),err_b(2:end),'o')
loglog(err_s(1:end-1),err_s(2:end),'o')
legend('N','b','s')

errory={err_n,err_b,err_s};

for h=1:length(errory)
blad=errory{h};
[idx,p]=indexer(blad);
fprintf("p to %.6f dla metody nr %d\n",p,h)
end
C_s=err_s(idx(end))/err_s(idx(end-1))^((1+sqrt(5))/2);
C_n=err_n(idx(end))/err_n(idx(end-1))^2;
fprintf("dla n %.6f dla s %.6f",C_n,C_s)
%fucnkje

function [idx,p]=indexer(err)
idx=find(err(1:end-1)>1e-12 & err(2:end)>1e-12);
px=polyfit(log(err(idx)),log(err(idx+1)),1);
p=px(1);

end

function [x,err]=newton(f,fp,x0,xd)
x=x0;
i=0;
while abs(x-xd)>1e-14 && i<100
x=x-f(x)/fp(x);
i=i+1;
err(i)=abs(x-xd);
end
end

function [x,err]=bisekcja(a,b,f,xd)
x=(a+b)/2;
i=0;
while abs(x-xd)>1e-14 && i<100
   x=(a+b)/2;
   if f(a)*f(x)<0
       b=x;
   else
       a=x;
   end
    i=i+1;
    err(i)=abs(x-xd);
end
end

function [x,err]=sieczne(x0,x1,f,xd)
x_old=x1;
x_older=x0;
x_new=x_old;
i=0;
while abs(x_new-xd)>1e-14 && i<100
   x_new=x_old-f(x_old)*(x_old-x_older)/(f(x_old)-f(x_older));
    i=i+1;
    err(i)=abs(x_new-xd);
    x_older=x_old;
    x_old=x_new;
end
x=x_new;
end

%% Zad2 
clear all
f=@(x) x^3 -2*x-2;
fp=@(x) 3*x^2-2;
x0=0;
[x8,err8,iter8]=newton2_bs(f,fp,x0,8);
x8
x_axis=linspace(-3,3,1201);

for k=1:length(x_axis)
[xk,errk,iterk(k)]=newton2(f,fp,x_axis(k),100);
end
plot(x_axis,iterk);

%funckje

function [x,err,iter]=newton2_bs(f,fp,x0,n)
x_old=x0;
for i=1:n
x_new=x_old-f(x_old)/fp(x_old);
x(i)=x_new;
err(i)=abs(x_new-x_old);
x_old=x_new;
end
iter=i-1;
end

function [x,err,iter]=newton2(f,fp,x0,n)
x_old=x0;
for i=1:n
    x_new=x_old-f(x_old)/fp(x_old);
    x(i)=x_new;
    err(i)=abs(x_new-x_old);
    if err(i)<=1e-10
        break;
    end
    x_old=x_new;
end
iter=i-1;
end

%% Zad3
clear all
z0=[4,3.5,3,2,2,2,1]; %v1 v2 v3 ir1 id1 ir2 ir4
options=optimoptions('fsolve','StepTolerance',1e-12,'FunctionTolerance',1e-12);

fsolve(@obwod,z0, options)


%funkcje
function F=obwod(z)
v1=z(1);
v2=z(2);
v3=z(3);
ir1=z(4);
id1=z(5);
ir2=z(6);
ir4=z(7);

J=3;
r4=4;
r1=0.5;
r2=1.5;
ut=0.026;
Is=1e-9;

F=[
id1-Is*(exp((v2-v3)/ut)-1);
v1-r4*ir4;
J-ir4-ir1;
ir1-id1;
ir1-ir2;
v1-r1*ir1-v2;
v3-ir2*r2;
];





end