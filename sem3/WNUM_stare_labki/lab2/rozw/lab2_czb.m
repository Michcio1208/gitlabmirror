%Zad1
clear all
f=@(x) x^14-1;
fp=@(x) 14*x^13;
x_d=1;

[xs_rf,err_rf]=reg(0,2,f,200000,x_d);
[xs_n,err_n]=newt(2,f,fp,1000,x_d);
err_rf;
err_n;
fprintf("minimalny blad dla rf to %d\n",min(err_rf))
fprintf("minimalny blad dla n to %d\n",min(err_n))

dokladnosci=[1e-6,1e-9,1e-12];
for k=dokladnosci
dokladnosc_rf(err_rf,k);
dokladnosc_n(err_n,k);
end

err_n_plot=err_n;
err_rf_plot=err_rf;
err_rf_plot(err_rf_plot==0)=1e-17;
err_n_plot(err_n_plot==0)=1e-17;

loglog(err_rf_plot)
hold on;
loglog(err_n_plot)
legend('regula falsi','newton')
xlabel("liczba it")
ylabel("blad rzeczywisty")

%funckje

function dokladnosc_rf(err,dok)
i_dokl=find(err<dok,1);
fprintf("rf indeks dla dok = 1e-%d to %d\n",dok,i_dokl);
end

function [i_dokl]=dokladnosc_n(err,dok)
i_dokl=find(err<dok,1);
fprintf("n indeks dla dok = 1e-%d to %d\n",dok,i_dokl);
end

function [xs,err]=reg(a,b,f,n,x_d)
i=0;
xs=zeros(n,1);
while i<n
x=(a*f(b)-b*f(a))/(f(b)-f(a));
i=i+1;
xs(i)=x;
err(i)=abs(xs(i)-x_d);
if f(a)*f(x)<0
b=x;
else 
a=x;
end
end
end


function [xs,err]=newt(x0,f,fp,n,x_d)
i=0;
xs=zeros(n,1);
x=x0;
while i<n
    x=x-f(x)/fp(x);
    i=i+1;
    xs(i)=x;
    err(i)=abs(xs(i)-x_d);
end
end

%% Zad2
clear all

fv = @(v) [v(1)^4 - 6*v(1)^2*v(2)^2 + v(2)^4 - 1;
    4*v(1)^3*v(2) - 4*v(1)*v(2)^3];

J = @(v) [4*v(1)^3 - 12*v(1)*v(2)^2,  -12*v(1)^2*v(2) + 4*v(2)^3;
    12*v(1)^2*v(2) - 4*v(2)^3,   4*v(1)^3 - 12*v(1)*v(2)^2];

starters=[0.7,-1,0.3,0;
    0.5,0.5,-0.4,1.5]

for h=starters
[x,iter,kryt]=newton2(fv,J,h);
    fprintf("pkt startowy to %.2f %.2f rozwiazanie to %.2f %.2f liczba iteracji to %d ,a kryterium jest %s\n",h(1),h(2),x(1),x(2),iter,kryt)
end


function [x,iter,kryt]=newton2(fv,J,x0)
i=0;
x=x0;
while norm(fv(x))>1e-10 && i<=50
x=x-J(x)\fv(x);
i=i+1;
end 
if norm(fv(x))<1e-10
kryt="spelnione";
else
    kryt="niespelnione";
end
iter=i;
end
%%
clear all
f=@(x) x^3-4*x+1;
fp=@(x) 3*x^2 - 4;
options=optimset('TolX',0);
x0(1)=2.5;
x0(2)=0.5;
xd(1)=fzero(f,[1,2.5],options);
xd(2)=fzero(f,[0,1],options);

for k=1:length(x0)
[x,err]=newton(x0(k),f,fp,100,xd(k));
idx=find(err(1:end-1)>1e-12 & err(2:end)>1e-12);
p=polyfit(log(err(idx)),log(err(idx+1)),1);
C=err(idx(end)+1)/err(idx(end))^2;
fprintf("rozw = %.2f dla x0=%.2f \n | rho=%.6f C=%.3f\n",x,x0(k),p(1),C)
end

%funkcje
function [x,err]=newton(x0,f,fp,n,x_d)
i=0;
x=x0;
while i<n && abs(x-x_d)>=1e-14 
    x=x-f(x)/fp(x);
    i=i+1;
    err(i)=abs(x-x_d);
end
end