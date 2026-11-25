% Zad 1  
f=@(x) x^12 -1;
fp=@(x) 12*x^11;

[x_newton,err_newton]=newton(f,fp,2,1);
[x_rf,err_rf]=rf(0,2,f,1);
fprintf("RF\n")
progi(err_rf);
fprintf("Newton\n")
progi(err_newton);

err_newton_plot=err_newton;
err_rf_plot=err_rf;

err_newton_plot(err_newton_plot==0)=1e-17;
err_rf_plot(err_rf_plot==0)=1e-17;
loglog(err_rf_plot)
hold on
loglog(err_newton_plot)
hold off
grid on
legend("Newton","RF",Location="southwest")
%funkcje

function progi(err)
fprintf("najmniejszy blad to %.6f\n",min(err));
for prog=[1e-6 1e-9 1e-12]
idx=find(err<prog,1);
fprintf("index gdzie przekroczono %.0e to %d\n",prog,idx)
end

end

function [x,err]=newton(f,fp,x0,xd)
x_old=x0;
for i=1:100
x(i)=x_old-f(x_old)/fp(x_old);
x_old=x(i);
err(i)=abs(x(i)-xd);
i=i+1;
end
end

function [x,err]=rf(a,b,f,xd)
for i=1:200000
   x(i)=(a*f(b)-b*f(a))/(f(b)-f(a));
   if f(a)*f(x(i))<0
       b=x(i);
   else
       a=x(i);
   end
   err(i)=abs(x(i)-xd);
    i=i+1;
end
end

%% Zad2
clear all
 f=@(v)[v(1)^3-3*v(1)*v(2)^2-1;3*v(1)^2*v(2)-v(2)^3];
 J=@(v)[3*v(1)^2-3*v(2)^2,-6*v(1)*v(2);6*v(1)*v(2),3*v(1)^2-3*v(2)^2];

 start={[1;1],[-1;0.5],[0.1;-0.1],[0;1.5]};
for k=1:length(start)
  p=start{k};
[x,err,iter,kryt]=newton2(f,J,p);
fprintf("dla punktu %f %f iter to %d a kryt jest %s\n",p(1),p(2),iter,kryt)
end


 %funkcje

 function [x,err,iter,kryt]=newton2(f,J,v)
x=v;
i=0;
while norm(f(x))>=1e-10 && i<50
x=x-J(x)\f(x);
i=i+1;
err(i)=norm(f(x));
if norm(f(x))<1e-10
kryt="spelnione";
else
    kryt="niespelnione";
end
end
iter=i;
 end

 %%  Zad3
 clear all
 f=@(x) x^3-3*x+1;
 fp=@(x) 3*x^2-3;
 options=optimset('TolX',0);
 xd1=fzero(f,[1,2],options);
 xd2=fzero(f,[0,1],options);
[x_1,err_1]=newton3(f,fp,2,xd1);
[x_2,err_2]=newton3(f,fp,0.5,xd2);
[idx_1,p_1]=indexer(err_1);
[idx_2,p_2]=indexer(err_2);
C_1= err_1(idx_1(end)+1) / err_1(idx_1(end))^2 ;
C_2= err_2(idx_2(end)+1) / err_2(idx_2(end))^2 ;

fprintf("dla x0 %f p to %.6f a C to %.6f\n",2,p_1,C_1)
fprintf("dla x0 %f p to %.6f a C to %.6f\n",0.5,p_2,C_2)
 
%funkcje
 function [idx,p]=indexer(err)
 idx=find(err(1:end-1)>1e-12 & err(2:end)>1e-12);
 px=polyfit(log(err(idx)),log(err(idx+1)),1);
 p=px(1);
 end


 function [x,err]=newton3(f,fp,x0,xd)
 x=x0;
 i=0;
 while abs(x-xd)>=1e-14
     x=x-f(x)/fp(x);
     i=i+1;
     err(i)=abs(x-xd);
  
 end
 end