
clear variables
close all
f(1)=0;
f(2)=1;
tic;
for i = 3:100 
    f(i)=f(i-2)+f(i-1);
end
k=toc;
disp(['Czas bez deklaracji: ',num2str(k)])
plot(f);
