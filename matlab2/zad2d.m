clear variables
close all
f=zeros(1,100);
f(2)=1;
tic;
for i = 3:100 
    f(i)=f(i-2)+f(i-1);
end
l=toc;
disp(['Czas z deklaracją ',num2str(l)])
plot(f);
