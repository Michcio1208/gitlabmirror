% Przykładowe wywołanie dla danych z zadania:
f  = @(x) x.^12 - 1;
fp = @(x) 12 * x.^11;
x_dok=1;

[xs_rf,err_rf] = regula_falsi(f, 0, 2, 200000,x_dok);
[xs_n,err_n]  = newton(f, fp, 2, 1000,x_dok);
err_n_min=min(err_n);
err_rf_min=min(err_rf);
i_6_rf=numer_iteracji_6(err_rf,200000)
i_9_rf=numer_iteracji_9(err_rf,200000)
i_12_rf=numer_iteracji_12(err_rf,200000)

semilogy(err_rf,200000)
hold on;
semilogy(err_n,200000)
legend("rf","n")


%%err_rf = abs(xs_rf - 1);
%%err_n  = abs(xs_n  - 1); albo bez err zwracanych w funckji tylko
%%liczymy je tu 
% --- Definicje funkcji ---

function [xs,err] = regula_falsi(f, a, b, n,x_dok)
xs = zeros(n, 1); % prealokacja wektora na wszystkie przybliżenia
fa = f(a);
fb = f(b);

for i = 1:n
    x_new = (a * fb - b * fa) / (fb - fa);
    err(i)=norm(x_new-x_dok);
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
end

function [xs,err] = newton(f, fp, x0, n,x_dok)
xs = zeros(n, 1);
x = x0;

for i = 1:n
    x = x - f(x) / fp(x);
    err(i)=norm(x-x_dok);
    xs(i) = x;
end
end



function it6 = numer_iteracji_6(er,n)
for i=1:n
if er(i)<1e-6
it6=i;
break;
end
end
end

function it9 = numer_iteracji_9(er,n)
for i=1:n
    if er(i)<1e-9
        it9=i;
        break;
    end
end
end

function it12 = numer_iteracji_12(er,n)
for i=1:n
    if er(i)<1e-12
        it12=i;
        break;
    end
end
end
%% Zad 1 najprosciej 

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
