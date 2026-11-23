% Dane z zadania 1:
f     = @(x) x.^12 - 1;
fp    = @(x) 12 * x.^11;
x_dok = 1;

% a) Wywołanie obu metod
[xs_rf, err_rf] = regula_falsi(f, 0, 2, 200000, x_dok);
[xs_n,  err_n]  = newton(f, fp, 2, 1000, x_dok);

% b) Wypisanie minimalnego błędu i pierwszych iteracji poniżej progów
wypisz_wyniki('Regula falsi', err_rf);
wypisz_wyniki('Newton',       err_n);

% c) Wspólny wykres w skali log-log (zera zastąpione przez 1e-17)
err_rf_plot = err_rf;
err_rf_plot(err_rf_plot == 0) = 1e-17;

err_n_plot = err_n;
err_n_plot(err_n_plot == 0) = 1e-17;

figure;
loglog(1:length(err_rf), err_rf_plot, 'LineWidth', 1.5);
hold on;
loglog(1:length(err_n),  err_n_plot,  'LineWidth', 1.5);
grid on;
xlabel('Numer iteracji i');
ylabel('Błąd rzeczywisty |x_i - x^*|');
title('Błąd rzeczywisty w funkcji numeru iteracji (regula falsi vs Newton)');
legend('Regula falsi', 'Metoda Newtona', 'Location', 'southwest');

% --- Definicje funkcji ---

function [xs, err] = regula_falsi(f, a, b, n, x_dok)
xs = zeros(n, 1);
fa = f(a);
fb = f(b);

for i = 1:n
    x_new = (a * fb - b * fa) / (fb - fa);
    xs(i) = x_new;
    fx = f(x_new);

    if fa * fx < 0
        b = x_new;
        fb = fx;
    else
        a = x_new;
        fa = fx;
    end
end
err = abs(xs - x_dok);
end

function [xs, err] = newton(f, fp, x0, n, x_dok)
xs = zeros(n, 1);
x = x0;

for i = 1:n
    x = x - f(x) / fp(x);
    xs(i) = x;
end
err = abs(xs - x_dok);
end

function wypisz_wyniki(nazwa, err)
fprintf('=== %s ===\n', nazwa);
fprintf('Najmniejszy błąd: %.3e\n', min(err));
for prog = [1e-6, 1e-9, 1e-12]
    it = find(err < prog, 1);
    if isempty(it)
        fprintf('Błąd < %.0e: nie nastąpiło\n', prog);
    else
        fprintf('Błąd < %.0e: iteracja %d\n', prog, it);
    end
end
fprintf('\n');
end
%% ZAD.2
fv=@(v)[v(1)^3-3*v(1)*v(2)^2-1;3*v(1)^2*v(2)-v(2)^3];
J=@(v)[3*v(1)^2-3*v(2)^2,(-6)*v(1)*v(2);6*v(1)*v(2),3*v(1)^2-3*v(2)^2];


punkty = {[1; 1], [-1; 0.5], [0.1; -0.1], [0; 1.5]};

for k = 1:length(punkty)
    x0 = punkty{k};
    [xs, nr_i, spelnione] = newton2(fv, J, x0, 50, 1e-10);
    fprintf('Start (%.1f; %.1f) -> roz: (%.6f; %.6f), iteracje: %d, stop: %s\n', ...
        x0(1), x0(2), xs(1), xs(2), nr_i, spelnione);
end

function [xs,nr_i,spelnione]=newton2(fv,J,x0,n,dokl)
x=x0;
i=0;
while i<n && norm(fv(x))>dokl
x=x-J(x)\fv(x);
i=i+1;
end
if(norm(fv(x))<1e-10)
    spelnione="spelnione";
else
    spelnione="niespelnione";
end
xs=x;
nr_i=i;
end
%% Zad3 
points={2 , 0.5};
fx=@(x) x^3-3*x+1;
fpx=@(x) 3*x^2-3;
dok=1e-14;
options = optimset("TolX",0);
x_d(1)=fzero(fx,2,options);
x_d(2)=fzero(fx,0.5,options);

for h=1:length(points)
x0=points{h};
[xs,err]=newton3(fx,fpx,x0,100,x_d(h));
fprintf("rozw= %d dla x0= %d \n",xs,x0)
err_plot=err;
err_plot(err_plot == 0) = 1e-17;

idx = find(err(1:end-1) > 1e-12 & err(2:end) > 1e-12); % znajduje indeksy i, dla których jednocześnie Delta_i > 1e-12 oraz Delta_{i+1} > 1e-12 (automatycznie odrzuca też nieużyte zera z prealokacji wektora err)
p = polyfit(log(err(idx)), log(err(idx+1)),1); % dopasowuje prostą metodą najmniejszych kwadratów (wielomian 1. stopnia) do punktów (ln(Delta_i), ln(Delta_{i+1})); p(1) to jej współczynnik kierunkowy, czyli rząd zbieżności rho
C = err(idx(end)+1) / err(idx(end))^2; % oblicza współczynnik C = Delta_{i+1} / Delta_i^2 dla ostatniej iteracji spełniającej warunek > 1e-12, przyjmując rho = 2
fprintf("| rho = %.6f, C = %.6f\n", p(1), C); % wypisuje wyznaczone rho i C dla danego pierwiastka i przechodzi do nowej linii
end

function [xs, err] = newton3(f, fp, x0, n, x_dok)
err=zeros(n,1);
x = x0;
i=0;
while abs(x-x_dok)>=1e-14 && i<n
    x = x - f(x) / fp(x);
    i=i+1;
err(i) = abs(x - x_dok);
end
xs=x;
end