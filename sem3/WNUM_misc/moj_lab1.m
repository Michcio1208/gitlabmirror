clear
% u1 u2 u3 u4
%zad1
r1=4;r3=4;r5=4;r7=4;r8=4;
r2=8;r4=8;r6=8;r9=8;
R=[r1 r2 r3 r4 r5 r6 r7 r8 r9];
e0=10;
A=[(r1*r3+r2*r3+r1*r2) -r1*r2 0 0;
    -r4*r5 (r3*r5+r3*r4+r4*r5) -r3*r4 0;
    0 -r6*r7 (r5*r7+r6*r7+r5*r6) -r5*r6;
    0 0 r8*r9 -(r8*r9+r7*r8+r7*r9)];
b=[e0*r2*r3;0;0;0];
x=A\b;

%%
%zad2
%najpierw uruchomic zad1
e_z=[1e-6 5e-6 1e-5 5e-5 1e-4 5e-4 1e-3 5e-3 1e-2];
for i=1:9
e_zab(i)=e0*(1+e_z(i)*(2*rand -1));
b2=[e_zab(i)*r2*r3;0;0;0];
x2=A\b2;
delta_x(i)=norm(x2-x)/norm(x);
blad_t(i)=cond(A)*norm(b2-b)/norm(b);
end
semilogy(e_z,delta_x)
hold on
semilogy(e_z,blad_t)
legend('delta x','blad teor')
xlabel('zaburzenie')
ylabel('blad')

%%
%zad3
clear
for n=2:12
Av=vander(1:n);
bv=sum(Av,2);
Aw=wilkinson(n);
bw=sum(Aw,2);
[Qv,Rv]=qr(Av);
[Qw,Rw]=qr(Aw);
yv=Qv.' * bv;
xv=Rv\yv;
yw=Qw.' * bw;
xw=Rw\yw;
blad_v(n)=norm(xv-ones(n,1));
blad_w(n)=norm(xw-ones(n,1));

end
semilogy(blad_v)
hold on;
semilogy(blad_w)
legend('blad_v','blad_w')
xlabel('#n')
ylabel('blad')
%%
%komentarze
%zad2:
% oba błedy dla najmnieszych wartosci rosną mocno, potem troche wolniej i
% potem powoli maleją. Co najważniejsze błąd rzeczytwisty jest zawsze
% mniejszy od błędu teoretycznego czyli tak jak przewiduje teoria ponieważ
% błąd teoretyczny zawsze zakłada najgorszy możliwy przypadek
%
%
%zad3
% w zadaniu 3 błędy dla macierzy różnią się diametralnie ponieważ 
% macierz vandermonta jest bardzo źle uwarunkowana numerycznie więc bład
% dla tej macierzy rośnie wraz z rozmiarem macierzy aż od okolo 10^-15 aż
% do ok 10^-2. natomiast macierz wilkinsona względnie trzyma podobny poziom
% błędu ponieważ jest lepiej uwarunkowana numerycznie. widać to po
% sprawdzeniu cond(Av) i cond(Aw) gdzie dla wilkinsona dla najwiekszej
% macierzy Aw jest równy ok 30 a dla vandermonta jest to wartość rzędu
% 10^15. Stąd widać skąd bierze się diametralna różnica w błędzie dla tych
% macierzy pomimo użycia tej samej metody do rozwiazania rownan.
%
%
%
%
%
%
%

