%% ========================================================================
%  ĆWICZENIE UT2: Wielkosygnałowe właściwości tranzystorów bipolarnych
%  i unipolarnych. Inwertery - podstawowe jednostki logiczne.
%  Kompletny skrypt generujący rysunki do pytań sprawdzających (1-11).
%  Każde zadanie otwierane jest w osobnym oknie (figure) z pełnym opisem.
% =========================================================================
clear; clc; close all;

%% ========================================================================
%  FIGURE 1 - ZADANIE 1: Rozkłady koncentracji nośników mniejszościowych
%  w bazie dla stanów: braku polaryzacji, aktywnego, nasycenia, zatkania
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 1 i str. 2, Rys. 6)
% =========================================================================
figure('Name', 'Zadanie 1 - Rozkłady koncentracji w bazie', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [60, 60, 780, 520]);
hold on; grid on; box on;

WB = 1; % Znormalizowana szerokość bazy
x = linspace(0, WB, 300);

npB0        = 1.2;                          % Koncentracja równowagowa
n_brak_pol  = npB0 * ones(size(x));         % Stan braku polaryzacji (U_BE=0, U_BC=0)
n_zatkanie  = 0.75 * npB0 * sin(pi*x/WB);   % Stan zatkania (U_BE<0, U_BC<0)
n_aktywny   = 6.0 * (1 - x/WB);             % Stan aktywny normalny (U_BE>0, U_BC<0)
n_nasycenie = 8.8 - 6.0 * (x/WB);           % Stan nasycenia (U_BE>0, U_BC>0)

plot(x, n_nasycenie, 'b-',  'LineWidth', 2.2, 'DisplayName', 'Stan nasycenia (U_{BE} > 0, U_{BC} > 0)');
plot(x, n_aktywny,   'g-',  'LineWidth', 2.2, 'DisplayName', 'Stan aktywny normalny (U_{BE} > 0, U_{BC} < 0)');
plot(x, n_brak_pol,  'k--', 'LineWidth', 1.8, 'DisplayName', 'Brak polaryzacji - równowagowa n_{pB0} (U_{BE} = 0, U_{BC} = 0)');
plot(x, n_zatkanie,  'm-',  'LineWidth', 2.2, 'DisplayName', 'Stan zatkania / odcięcia (U_{BE} < 0, U_{BC} < 0)');

xticks([0 WB]);
xticklabels({'0 (Złącze Emiter-Baza)', 'W_B (Złącze Kolektor-Baza)'});
xlabel('Położenie w obszarze bazy x');
ylabel('Koncentracja nośników mniejszościowych n_{pB}(x) [j.w.]');
title('Zadanie 1: Rozkłady koncentracji nośników mniejszościowych w bazie tranzystora BJT');
ylim([0 10]);
legend('Location', 'northeast', 'FontSize', 10);

%% ========================================================================
%  FIGURE 2 - ZADANIE 2: Obszary pracy (zatkania, aktywny, nasycenia)
%  w polu charakterystyk wyjściowych: a) układ WB, b) układ WE
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 1-2, Rys. 1b, Rys. 4)
% =========================================================================
figure('Name', 'Zadanie 2 - Obszary pracy tranzystora (WB i WE)', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [80, 80, 1150, 500]);

% --- 2a) Układ ze wspólną bazą (WB): Ic = f(Ucb) ---
subplot(1, 2, 1); hold on; grid on; box on;
Ucb = linspace(-0.7, 10, 400);

fill([-0.7 0 0 -0.7], [0 0 10 10], [0.85 0.92 1.0], 'EdgeColor', 'none', ...
     'DisplayName', 'Obszar nasycenia (U_{CB} < 0)');
fill([0 10 10 0], [0 0 0.5 0.5], [1.0 0.88 0.88], 'EdgeColor', 'none', ...
     'DisplayName', 'Obszar zatkania (poniżej I_E = 0)');

IE_vals = [0, 2, 4, 6, 8]; % mA
for i = 1:length(IE_vals)
    Ic_wb = 0.99 * IE_vals(i) - 0.05 * (exp(-Ucb / 0.12) - 1);
    Ic_wb(Ic_wb < 0) = 0;
    if i == 1
        plot(Ucb, Ic_wb + 0.5, 'r-', 'LineWidth', 2, 'DisplayName', 'Granica zatkania (I_E = 0)');
    else
        plot(Ucb, Ic_wb + 0.5, 'k-', 'LineWidth', 1.4, 'HandleVisibility', 'off');
        text(7.2, IE_vals(i)+0.75, sprintf('I_E = %d mA', IE_vals(i)), 'FontSize', 9);
    end
end
xline(0, 'b--', 'LineWidth', 2, 'DisplayName', 'Granica nasycenia (U_{CB} = 0)');
text(3.2, 5.5, 'OBSZAR AKTYWNY', 'FontWeight', 'bold', 'FontSize', 11);
xlabel('Napięcie kolektor-baza U_{CB} [V]');
ylabel('Prąd kolektora I_C [mA]');
title('Zadanie 2a: Układ wspólnej bazy (WB) I_C = f(U_{CB})');
xlim([-0.7 10]); ylim([0 10]);
legend('Location', 'northwest');

% --- 2b) Układ ze wspólnym emiterem (WE): Ic = f(Uce) ---
subplot(1, 2, 2); hold on; grid on; box on;
Uce = linspace(0, 10, 400);
Uce_sat_line = linspace(0, 1.2, 100);
Ic_sat_line  = 8.5 * Uce_sat_line;

fill([0 Uce_sat_line 0], [0 Ic_sat_line 10], [0.85 0.92 1.0], 'EdgeColor', 'none', ...
     'DisplayName', 'Obszar nasycenia (U_{CB} < 0, U_{CE} < U_{CES})');
fill([0 10 10 0], [0 0 0.4 0.2], [1.0 0.88 0.88], 'EdgeColor', 'none', ...
     'DisplayName', 'Obszar zatkania (poniżej I_B = 0)');

IB_vals = [0, 20, 40, 60, 80]; % uA
beta = 100;
for i = 1:length(IB_vals)
    if i == 1
        Ic_we = 0.2 + 0.02 * Uce;
        plot(Uce, Ic_we, 'r-', 'LineWidth', 2, 'DisplayName', 'Granica zatkania (I_B = 0)');
    else
        Ic_max_i = (IB_vals(i)/1000) * beta;
        Ic_we = Ic_max_i * (1 - exp(-Uce / (0.15 + 0.03*i))) .* (1 + 0.02*Uce);
        plot(Uce, Ic_we, 'k-', 'LineWidth', 1.4, 'HandleVisibility', 'off');
        text(7.0, Ic_we(end)+0.35, sprintf('I_B = %d \\muA', IB_vals(i)), 'FontSize', 9);
    end
end
plot(Uce_sat_line, Ic_sat_line, 'b--', 'LineWidth', 2, 'DisplayName', 'Granica nasycenia (U_{CB} = 0, U_{CES})');
text(3.5, 5.5, 'OBSZAR AKTYWNY', 'FontWeight', 'bold', 'FontSize', 11);
xlabel('Napięcie kolektor-emiter U_{CE} [V]');
ylabel('Prąd kolektora I_C [mA]');
title('Zadanie 2b: Układ wspólnego emitera (WE) I_C = f(U_{CE})');
xlim([0 10]); ylim([0 10]);
legend('Location', 'northwest');

%% ========================================================================
%  FIGURE 3 - ZADANIE 3: Impulsy eg, ib, ic podczas przełączania w WE:
%  a) zatkanie <-> nasycenie, b) zatkanie <-> aktywny, c) tylko w aktywnym
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 1-2, Rys. 2, 3, 7)
% =========================================================================
figure('Name', 'Zadanie 3 - Przebiegi impulsowe eg, ib, ic', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [100, 50, 1220, 760]);

t = linspace(0, 12, 1200);

% --- 3a) Zatkanie <-> Nasycenie (występują: td, tr, ts, tf) ---
eg_a = -2 * ones(size(t)); eg_a(t >= 1 & t <= 6) = 5;
ib_a = zeros(size(t));
ib_a(t >= 1 & t < 1.6)   = 1.5 - 0.5*(t(t >= 1 & t < 1.6)-1)/0.6;
ib_a(t >= 1.6 & t <= 6)  = 1.0;
ib_a(t > 6 & t <= 8.2)   = -0.8;
ib_a(t > 8.2 & t <= 9.2) = -0.8 * (1 - (t(t > 8.2 & t <= 9.2)-8.2)/1.0);

ic_a = zeros(size(t));
ic_a(t >= 1.6 & t < 2.6) = 10 * (t(t >= 1.6 & t < 2.6) - 1.6);
ic_a(t >= 2.6 & t <= 8.2)= 10;
ic_a(t > 8.2 & t <= 9.2) = 10 * (1 - (t(t > 8.2 & t <= 9.2) - 8.2));

% --- 3b) Zatkanie <-> Aktywny (występują: td, tr, tf; brak ts -> ts = 0) ---
eg_b = -2 * ones(size(t)); eg_b(t >= 1 & t <= 6) = 2.5;
ib_b = zeros(size(t));
ib_b(t >= 1 & t < 1.6)   = 0.8 - 0.4*(t(t >= 1 & t < 1.6)-1)/0.6;
ib_b(t >= 1.6 & t <= 6)  = 0.4;
ib_b(t > 6 & t <= 7.5)   = -0.5 * exp(-(t(t > 6 & t <= 7.5)-6)/0.5);

ic_b = zeros(size(t));
ic_b(t >= 1.6 & t <= 6)  = 6 * (1 - exp(-(t(t >= 1.6 & t <= 6) - 1.6)/0.6));
ic_b(t > 6)              = 6 * exp(-(t(t > 6) - 6)/0.6);

% --- 3c) Tylko w aktywnym (brak td i brak ts -> td = 0, ts = 0) ---
eg_c = 1.5 * ones(size(t)); eg_c(t >= 1 & t <= 6) = 3.0;
ib_c = 0.2 * ones(size(t));
ib_c(t >= 1 & t <= 6)    = 0.5 + 0.2 * exp(-(t(t >= 1 & t <= 6)-1)/0.2);
ib_c(t > 6)              = 0.2 - 0.2 * exp(-(t(t > 6)-6)/0.2);

ic_c = 3 * ones(size(t));
ic_c(t >= 1 & t <= 6)    = 3 + 4.5 * (1 - exp(-(t(t >= 1 & t <= 6) - 1)/0.6));
ic_c(t > 6)              = 3 + 4.5 * exp(-(t(t > 6) - 6)/0.6);

% Rysowanie siatki 3x3
subplot(3,3,1); plot(t, eg_a, 'b', 'LineWidth', 1.8); grid on; ylim([-3 6]); ylabel('e_g [V]');
title('3a) Zatkanie \leftrightarrow Nasycenie (t_d, t_r, t_s, t_f)');
subplot(3,3,4); plot(t, ib_a, 'r', 'LineWidth', 1.8); grid on; ylim([-1.2 1.8]); ylabel('i_b [mA]');
subplot(3,3,7); plot(t, ic_a, 'k', 'LineWidth', 1.8); grid on; ylim([-1 12]); ylabel('i_c [mA]'); xlabel('Czas t [\mus]');

subplot(3,3,2); plot(t, eg_b, 'b', 'LineWidth', 1.8); grid on; ylim([-3 6]);
title('3b) Zatkanie \leftrightarrow Aktywny (t_s = 0)');
subplot(3,3,5); plot(t, ib_b, 'r', 'LineWidth', 1.8); grid on; ylim([-1.2 1.8]);
subplot(3,3,8); plot(t, ic_b, 'k', 'LineWidth', 1.8); grid on; ylim([-1 12]); xlabel('Czas t [\mus]');

subplot(3,3,3); plot(t, eg_c, 'b', 'LineWidth', 1.8); grid on; ylim([-3 6]);
title('3c) Tylko w aktywnym (t_d = 0, t_s = 0)');
subplot(3,3,6); plot(t, ib_c, 'r', 'LineWidth', 1.8); grid on; ylim([-1.2 1.8]);
subplot(3,3,9); plot(t, ic_c, 'k', 'LineWidth', 1.8); grid on; ylim([-1 12]); xlabel('Czas t [\mus]');

%% ========================================================================
%  FIGURE 4 - ZADANIE 4a: Chwilowe rozkłady koncentracji nośników podczas
%  włączania ze stanu zatkania do nasycenia (oddzielny figure)
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 2, Rys. 6)
% =========================================================================
figure('Name', 'Zadanie 4a - Włączanie: zatkanie -> nasycenie', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [120, 120, 720, 480]);
hold on; grid on; box on;

n_eq  = npB0 * ones(size(x));
n_cut = 0.75 * npB0 * sin(pi * x / WB);

plot(x, n_eq,            'k--', 'LineWidth', 1.6, 'DisplayName', 'Koncentracja równowagowa n_{pB0} (brak polaryzacji)');
plot(x, n_cut,           'm-',  'LineWidth', 1.8, 'DisplayName', 't_0: Stan początkowy (zatkanie)');
plot(x, 2.5*(1 - x/WB),  'g:',  'LineWidth', 1.6, 'DisplayName', 't_1: Narastanie w stanie aktywnym');
plot(x, 4.5*(1 - x/WB),  'g--', 'LineWidth', 1.6, 'DisplayName', 't_2: Dalszy wzrost gradientu w stanie aktywnym');
plot(x, 6.5*(1 - x/WB),  'r-',  'LineWidth', 2.0, 'DisplayName', 't_3: Granica nasycenia (U_{CB} = 0)');
plot(x, 9.0 - 6.5*x/WB,  'b-',  'LineWidth', 2.2, 'DisplayName', 't_4: Stan nasycenia (gromadzenie Q_{przes})');

annotation('textarrow', [0.35 0.55], [0.25 0.70], 'String', 'Wzrost czasu t \uparrow', 'FontWeight', 'bold');
xticks([0 WB]); xticklabels({'0 (Emiter)', 'W_B (Kolektor)'});
xlabel('Położenie w bazie x'); ylabel('Koncentracja n_{pB}(x) [j.w.]');
title('Zadanie 4a: Włączanie tranzystora ze stanu zatkania do nasycenia');
ylim([0 10]); legend('Location', 'northeast');

%% ========================================================================
%  FIGURE 5 - ZADANIE 4b: Chwilowe rozkłady koncentracji nośników podczas
%  wyłączania ze stanu nasycenia do zatkania (oddzielny figure)
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 2, Rys. 6)
% =========================================================================
figure('Name', 'Zadanie 4b - Wyłączanie: nasycenie -> zatkanie', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [150, 150, 720, 480]);
hold on; grid on; box on;

plot(x, n_eq,            'k--', 'LineWidth', 1.6, 'DisplayName', 'Koncentracja równowagowa n_{pB0} (brak polaryzacji)');
plot(x, 9.0 - 6.5*x/WB,  'b-',  'LineWidth', 2.2, 'DisplayName', 't_0: Początkowy stan nasycenia');
plot(x, 7.6 - 6.5*x/WB,  'b--', 'LineWidth', 1.6, 'DisplayName', 't_1: Usuwanie ładunku Q_{przes} (czas magazynowania t_s)');
plot(x, 6.5*(1 - x/WB),  'r-',  'LineWidth', 2.0, 'DisplayName', 't_2: Koniec t_s - granica nasycenia (Q_{przes} = 0)');
plot(x, 3.2*(1 - x/WB),  'g-',  'LineWidth', 1.6, 'DisplayName', 't_3: Zmniejszanie gradientu w stanie aktywnym (czas t_f)');
plot(x, n_cut,           'm-',  'LineWidth', 1.8, 'DisplayName', 't_4: Stan końcowy (zatkanie)');

annotation('textarrow', [0.55 0.35], [0.70 0.25], 'String', 'Wzrost czasu t \uparrow', 'FontWeight', 'bold');
xticks([0 WB]); xticklabels({'0 (Emiter)', 'W_B (Kolektor)'});
xlabel('Położenie w bazie x'); ylabel('Koncentracja n_{pB}(x) [j.w.]');
title('Zadanie 4b: Wyłączanie tranzystora ze stanu nasycenia do zatkania');
ylim([0 10]); legend('Location', 'northeast');

%% ========================================================================
%  FIGURE 6 - ZADANIE 4c: Chwilowe rozkłady koncentracji nośników podczas
%  włączania ze stanu zatkania do aktywnego (oddzielny figure)
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 2, Rys. 6)
% =========================================================================
figure('Name', 'Zadanie 4c - Włączanie: zatkanie -> aktywny', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [180, 180, 720, 480]);
hold on; grid on; box on;

plot(x, n_eq,            'k--', 'LineWidth', 1.6, 'DisplayName', 'Koncentracja równowagowa n_{pB0} (brak polaryzacji)');
plot(x, n_cut,           'm-',  'LineWidth', 1.8, 'DisplayName', 't_0: Stan początkowy (zatkanie)');
plot(x, 2.0*(1 - x/WB),  'g:',  'LineWidth', 1.6, 'DisplayName', 't_1: Narastanie koncentracji (stan przejściowy)');
plot(x, 3.8*(1 - x/WB),  'g--', 'LineWidth', 1.6, 'DisplayName', 't_2: Dalszy wzrost nachylenia (stan przejściowy)');
plot(x, 5.5*(1 - x/WB),  'g-',  'LineWidth', 2.2, 'DisplayName', 't_3: Docelowy stan aktywny (n_{pB}(W_B) = 0)');

annotation('textarrow', [0.35 0.50], [0.22 0.52], 'String', 'Wzrost czasu t \uparrow', 'FontWeight', 'bold');
xticks([0 WB]); xticklabels({'0 (Emiter)', 'W_B (Kolektor)'});
xlabel('Położenie w bazie x'); ylabel('Koncentracja n_{pB}(x) [j.w.]');
title('Zadanie 4c: Włączanie tranzystora ze stanu zatkania do aktywnego');
ylim([0 10]); legend('Location', 'northeast');

%% ========================================================================
%  FIGURE 7 - ZADANIE 4d: Chwilowe rozkłady koncentracji nośników podczas
%  wyłączania ze stanu aktywnego do aktywnego (oddzielny figure)
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 1-2 + wiedza zewnętrzna)
% =========================================================================
figure('Name', 'Zadanie 4d - Wyłączanie: aktywny -> aktywny', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [210, 210, 720, 480]);
hold on; grid on; box on;

plot(x, n_eq,            'k--', 'LineWidth', 1.6, 'DisplayName', 'Koncentracja równowagowa n_{pB0} (brak polaryzacji)');
plot(x, 6.2*(1 - x/WB),  'g-',  'LineWidth', 2.2, 'DisplayName', 't_0: Początkowy stan aktywny (wyższa polaryzacja I_{B2})');
plot(x, 4.9*(1 - x/WB),  'g--', 'LineWidth', 1.6, 'DisplayName', 't_1: Stan przejściowy (zmniejszanie gradientu)');
plot(x, 3.6*(1 - x/WB),  'g:',  'LineWidth', 1.6, 'DisplayName', 't_2: Stan przejściowy');
plot(x, 2.4*(1 - x/WB),  'c-',  'LineWidth', 2.2, 'DisplayName', 't_3: Końcowy stan aktywny (mniejsza polaryzacja I_{B1})');

annotation('textarrow', [0.45 0.32], [0.55 0.30], 'String', 'Wzrost czasu t \uparrow', 'FontWeight', 'bold');
xticks([0 WB]); xticklabels({'0 (Emiter)', 'W_B (Kolektor)'});
xlabel('Położenie w bazie x'); ylabel('Koncentracja n_{pB}(x) [j.w.]');
title('Zadanie 4d: Wyłączanie ze stanu aktywnego do aktywnego (zmniejszenie polaryzacji)');
ylim([0 10]); legend('Location', 'northeast');

%% ========================================================================
%  FIGURE 8 - ZADANIE 5: Wchodzenie tranzystora w stan nasycenia - ruch
%  punktu pracy na charakterystykach wyjściowych: a) układ WB, b) układ WE
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 1-2, Rys. 1b, Rys. 4)
% =========================================================================
figure('Name', 'Zadanie 5 - Ruch punktu pracy po prostej obciążenia (WB i WE)', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [100, 100, 1150, 500]);

Ucc = 10;  % [V]
Rc = 1.25; % [kOhm] -> I_CS = Ucc/Rc = 8 mA

% --- 5a) Układ wspólnej bazy (WB) ---
subplot(1, 2, 1); hold on; grid on; box on;
Ucb = linspace(-0.8, 10, 400);
for IE = [0, 2, 4, 6, 8, 9.5]
    Ic = 0.99 * IE - 0.08 * (exp(-Ucb / 0.12) - 1);
    Ic(Ic < 0) = 0;
    plot(Ucb, Ic, 'Color', [0.65 0.65 0.65], 'LineWidth', 1.2, 'HandleVisibility', 'off');
end
Ic_load_wb = (Ucc - Ucb) / Rc;
plot(Ucb, Ic_load_wb, 'k-', 'LineWidth', 2.0, 'DisplayName', 'Prosta obciążenia: U_{CB} = U_{CC} - I_C\cdotR_C');
xline(0, 'b--', 'LineWidth', 1.6, 'DisplayName', 'Granica nasycenia (U_{CB} = 0)');

plot(Ucc, 0, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Punkt odcięcia (U_{CB} = U_{CC})');
plot(0, Ucc/Rc, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'DisplayName', 'Granica nasycenia (I_{CS} = U_{CC}/R_C)');
plot(-0.45, (Ucc+0.45)/Rc, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8, 'DisplayName', 'Punkt pracy w nasyceniu (U_{CB} < 0)');
annotation('textarrow', [0.36 0.22], [0.35 0.65], 'String', 'Włączanie', 'Color', 'r', 'FontWeight', 'bold');

xlabel('U_{CB} [V]'); ylabel('I_C [mA]');
title('Zadanie 5a: Ruch punktu pracy w układzie WB');
xlim([-0.8 10.5]); ylim([0 10]); legend('Location', 'northeast');

% --- 5b) Układ wspólnego emitera (WE) - wg Rys. 1b i Rys. 4 ---
subplot(1, 2, 2); hold on; grid on; box on;
Uce = linspace(0, 10, 400);
for IB = [0, 20, 40, 60, 78, 100]
    Ic = (IB/10) * (1 - exp(-Uce / 0.25)) .* (1 + 0.015*Uce);
    plot(Uce, Ic, 'Color', [0.65 0.65 0.65], 'LineWidth', 1.2, 'HandleVisibility', 'off');
end
Ic_load_we = (Ucc - Uce) / Rc;
plot(Uce, Ic_load_we, 'k-', 'LineWidth', 2.0, 'DisplayName', 'Prosta obciążenia: U_{CE} = U_{CC} - I_C\cdotR_C');
plot(linspace(0, 1.0, 50), 8.5*linspace(0, 1.0, 50), 'r--', 'LineWidth', 1.6, 'DisplayName', 'Granica nasycenia (U_{CB} = 0)');

plot(Ucc, 0, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Punkt odcięcia (U_{CE} = U_{CC})');
plot(0.88, (Ucc-0.88)/Rc, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'DisplayName', 'Granica nasycenia (I_{CS}, U_{CES})');
plot(0.25, (Ucc-0.25)/Rc, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8, 'DisplayName', 'Stan nasycenia (I_{cmax}, U_{CEsat})');
annotation('textarrow', [0.82 0.65], [0.32 0.62], 'String', 'Włączanie', 'Color', 'r', 'FontWeight', 'bold');
annotation('textarrow', [0.62 0.79], [0.52 0.22], 'String', 'Wyłączanie', 'Color', 'b', 'FontWeight', 'bold');

xlabel('U_{CE} [V]'); ylabel('I_C [mA]');
title('Zadanie 5b: Ruch punktu pracy w układzie WE (Rys. 1b i Rys. 4)');
xlim([0 10.5]); ylim([0 10]); legend('Location', 'northeast');

%% ========================================================================
%  FIGURE 9 - ZADANIE 6: Charakterystyczne czasy impulsowe (td, tr, ts, tf)
%  na impulsie prądu kolektora przy przełączaniu zatkanie <-> nasycenie
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 2-3, Rys. 7)
% =========================================================================
figure('Name', 'Zadanie 6 - Charakterystyczne czasy przełączania BJT', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [140, 100, 850, 580]);

t = linspace(0, 12, 1200);
t0 = 1.5; % Skok napięcia eg z -Er na +Ef
t1 = 2.5; % Koniec czasu opóźnienia td
t2 = 4.2; % Koniec czasu narastania tr
t3 = 7.0; % Skok napięcia eg z +Ef na -Er
t4 = 8.8; % Koniec czasu magazynowania ts
t5 = 10.3;% Koniec czasu opadania tf

eg = -2 * ones(size(t)); eg(t >= t0 & t <= t3) = 5;
ic = zeros(size(t));
ic(t >= t1 & t < t2)  = 10 * (t(t >= t1 & t < t2) - t1) / (t2 - t1);
ic(t >= t2 & t <= t4) = 10;
ic(t > t4 & t <= t5)  = 10 * (1 - (t(t > t4 & t <= t5) - t4) / (t5 - t4));

subplot(2, 1, 1);
plot(t, eg, 'b-', 'LineWidth', 2.0); grid on; box on;
xline(t0, 'k--'); xline(t3, 'k--');
yticks([-2 0 5]); yticklabels({'-E_r', '0', 'E_f'});
ylabel('Napięcie e_g(t)');
title('Zadanie 6: Przebieg napięcia sterującego e_g(t) oraz prądu kolektora i_c(t) (Rys. 7)');
ylim([-3.5 6.5]);

subplot(2, 1, 2); hold on; grid on; box on;
plot(t, ic, 'r-', 'LineWidth', 2.2);
xline(t0, 'k--'); xline(t1, 'k--'); xline(t2, 'k--');
xline(t3, 'k--'); xline(t4, 'k--'); xline(t5, 'k--');
yline(10, 'k:', 'I_{cmax} \approx U_{CC}/R_C');

plot([t0 t1], [-1.2 -1.2], 'k|-', 'LineWidth', 1.5);
text((t0+t1)/2 - 0.35, -2.1, 't_d (opóźnienia)', 'FontWeight', 'bold', 'FontSize', 9);
plot([t1 t2], [-1.2 -1.2], 'k|-', 'LineWidth', 1.5);
text((t1+t2)/2 - 0.45, -2.1, 't_r (narastania)', 'FontWeight', 'bold', 'FontSize', 9);
plot([t3 t4], [-1.2 -1.2], 'k|-', 'LineWidth', 1.5);
text((t3+t4)/2 - 0.65, -2.1, 't_s (magazynowania)', 'FontWeight', 'bold', 'FontSize', 9);
plot([t4 t5], [-1.2 -1.2], 'k|-', 'LineWidth', 1.5);
text((t4+t5)/2 - 0.45, -2.1, 't_f (opadania)', 'FontWeight', 'bold', 'FontSize', 9);

ylabel('Prąd kolektora i_c [mA]'); xlabel('Czas t [\mus]');
ylim([-3.2 12]);

%% ========================================================================
%  FIGURE 10 - ZADANIE 7: Charakterystyka przejściowa inwertera
%  z tranzystorem bipolarnym, stany H i L oraz stany pracy tranzystora
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 4, Rys. 11)
% =========================================================================
figure('Name', 'Zadanie 7 - Charakterystyka przejściowa inwertera BJT', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [160, 120, 760, 520]);
hold on; grid on; box on;

UI  = linspace(0, 5, 500);
UIL = 0.7;
UIH = 2.2;
UOH = 5.0; % U_CC (Stan wysoki H)
UOL = 0.2; % U_CEsat (Stan niski L)

UO = zeros(size(UI));
IT = zeros(size(UI));

UO(UI <= UIL)            = UOH;
UO(UI > UIL & UI < UIH)  = UOH - (UOH - UOL) * (UI(UI > UIL & UI < UIH) - UIL) / (UIH - UIL);
UO(UI >= UIH)            = UOL;

IT(UI <= UIL)            = 0;
IT(UI > UIL & UI < UIH)  = 2.5 * (UI(UI > UIL & UI < UIH) - UIL) / (UIH - UIL);
IT(UI >= UIH)            = 2.5;

plot(UI, UO, 'k-', 'LineWidth', 2.5, 'DisplayName', 'Napięcie wyjściowe U_O = f(U_I)');
plot(UI, IT, 'b-', 'LineWidth', 1.8, 'DisplayName', 'Prąd przejściowy I_T = I_c');

xline(UIL, 'k--', 'U_{IL}', 'LabelVerticalAlignment', 'bottom', 'FontWeight', 'bold');
xline(UIH, 'k--', 'U_{IH}', 'LabelVerticalAlignment', 'bottom', 'FontWeight', 'bold');

text(0.08, 5.25, 'Wyjście: Stan H (U_{OH} = U_{CC})', 'FontWeight', 'bold');
text(0.08, 4.60, 'Tranzystor zatkany', 'Color', [0.1 0.45 0.1], 'FontWeight', 'bold');
text(1.00, 3.20, {'Tranzystor', 'aktywny'}, 'Color', [0.85 0.35 0], 'FontWeight', 'bold');
text(2.60, 0.55, 'Tranzystor nasycony', 'Color', 'b', 'FontWeight', 'bold');
text(2.60, -0.25, 'Wyjście: Stan L (U_{OL} = U_{CEsat})', 'FontWeight', 'bold');

xlabel('Napięcie wejściowe U_I [V]');
ylabel('Napięcie wyjściowe U_O [V]  /  Prąd I_T [j.w.]');
title('Zadanie 7: Charakterystyka przejściowa inwertera z tranzystorem bipolarnym (Rys. 11)');
xlim([0 5]); ylim([-0.5 5.8]);
legend('Location', 'northeast');

%% ========================================================================
%  FIGURE 11 - ZADANIE 8: Układ inwertera BJT z diodą Schottky'ego (Rys. 8)
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 3, Rys. 8)
% =========================================================================
figure('Name', 'Zadanie 8 - Układ z diodą Schottky''ego (Rys. 8)', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [180, 140, 680, 500]);
hold on; axis equal; axis off;
title('Zadanie 8: Inwerter BJT z diodą Schottky''ego ograniczającą nasycenie (Rys. 8)');

% Wejście i baza
plot([-3.0 -0.8], [0 0], 'k-', 'LineWidth', 2);
text(-2.7, 0.25, 'i \rightarrow', 'FontWeight', 'bold', 'FontSize', 11);
text(-1.4, 0.25, 'i_B \rightarrow', 'FontWeight', 'bold', 'FontSize', 11);
plot(-2.0, 0, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);

% Tranzystor BJT n-p-n
plot([-0.8 -0.8], [-0.8 0.8], 'k-', 'LineWidth', 3); % Baza
plot([-0.8 0], [0.3 1.0], 'k-', 'LineWidth', 2);     % Kolektor
plot([-0.8 0], [-0.3 -1.0], 'k-', 'LineWidth', 2);   % Emiter
plot(-0.2, -0.82, 'k>', 'MarkerFaceColor', 'k', 'MarkerSize', 7); % Strzałka emitera
plot([0 0], [-1.0 -1.8], 'k-', 'LineWidth', 2);
plot([-0.4 0.4], [-1.8 -1.8], 'k-', 'LineWidth', 3); % Masa

% Obwód kolektora i rezystor Rc
plot([0 0], [1.0 2.2], 'k-', 'LineWidth', 2);
plot(0, 1.5, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
rectangle('Position', [-0.25, 2.2, 0.5, 1.2], 'LineWidth', 2);
text(0.4, 2.8, 'R_C', 'FontWeight', 'bold', 'FontSize', 11);
plot([0 0], [3.4 4.0], 'k-', 'LineWidth', 2);
text(-0.2, 4.25, 'E_C (U_{CC})', 'FontWeight', 'bold', 'FontSize', 11);

% Gałąź z diodą Schottky'ego między bazą a kolektorem
plot([-2.0 -2.0], [0 1.5], 'k-', 'LineWidth', 2);
plot([-2.0 -1.3], [1.5 1.5], 'k-', 'LineWidth', 2);
patch([-1.3 -1.3 -0.7], [1.8 1.2 1.5], 'w', 'EdgeColor', 'k', 'LineWidth', 2);
plot([-0.7 -0.7], [1.2 1.8], 'k-', 'LineWidth', 2.2);
plot([-0.7 -0.85], [1.8 1.8], 'k-', 'LineWidth', 2.0);
plot([-0.85 -0.85], [1.8 1.68], 'k-', 'LineWidth', 2.0);
plot([-0.7 -0.55], [1.2 1.2], 'k-', 'LineWidth', 2.0);
plot([-0.55 -0.55], [1.2 1.32], 'k-', 'LineWidth', 2.0);
plot([-0.7 0], [1.5 1.5], 'k-', 'LineWidth', 2);

text(-1.3, 2.05, '\leftarrow 0,3 V', 'Color', 'b', 'FontWeight', 'bold', 'FontSize', 11);
text(-0.45, 1.75, 'i_D \rightarrow', 'FontWeight', 'bold', 'FontSize', 10);
text(-1.5, -0.9, 'U_{BE} \approx 0,7 V \uparrow', 'Color', [0.1 0.5 0.1], 'FontWeight', 'bold', 'FontSize', 10);
text(0.35, 0.2, 'U_{CE sat} \geq 0,7 V - 0,3 V = 0,4 V', 'Color', 'r', 'FontWeight', 'bold', 'FontSize', 11);
xlim([-3.5 3.5]); ylim([-2.2 4.6]);

%% ========================================================================
%  FIGURE 12 - ZADANIE 9: Schemat ideowy i charakterystyka przejściowa
%  inwertera CMOS (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 5, Rys. 13)
% =========================================================================
figure('Name', 'Zadanie 9 - Schemat i charakterystyka inwertera CMOS', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [120, 100, 1100, 500]);

% --- 9a) Schemat inwertera CMOS ---
subplot(1, 2, 1); hold on; axis equal; axis off;
title('Zadanie 9a: Schemat inwertera CMOS (Rys. 13)');

plot([0 0], [3.5 4.2], 'k-', 'LineWidth', 2);
plot(0, 4.25, 'ko', 'MarkerSize', 7, 'LineWidth', 1.5);
text(0.2, 4.25, 'U_{CC}', 'FontWeight', 'bold', 'FontSize', 11);
plot([0 0], [-0.2 -0.8], 'k-', 'LineWidth', 2);
plot([-0.4 0.4], [-0.8 -0.8], 'k-', 'LineWidth', 3);

% PMOS (góra)
plot([-0.6 -0.6], [2.3 3.5], 'k-', 'LineWidth', 2);
plot([-0.4 -0.4], [2.2 3.6], 'k-', 'LineWidth', 2.5);
plot([-0.4 0], [3.5 3.5], 'k-', 'LineWidth', 2);
plot([-0.4 0], [2.3 2.3], 'k-', 'LineWidth', 2);
plot([-0.4 0], [2.9 2.9], 'k-', 'LineWidth', 1.5);
plot(-0.1, 2.9, 'k>', 'MarkerFaceColor', 'k', 'MarkerSize', 5);
plot([0 0], [2.9 3.5], 'k-', 'LineWidth', 1.5);
text(0.25, 3.0, 'PMOS', 'Color', [0.1 0.45 0.1], 'FontWeight', 'bold');

% NMOS (dół)
plot([-0.6 -0.6], [0.1 1.3], 'k-', 'LineWidth', 2);
plot([-0.4 -0.4], [0.0 1.4], 'k-', 'LineWidth', 2.5);
plot([-0.4 0], [1.3 1.3], 'k-', 'LineWidth', 2);
plot([-0.4 0], [0.1 0.1], 'k-', 'LineWidth', 2);
plot([-0.4 0], [0.7 0.7], 'k-', 'LineWidth', 1.5);
plot(-0.3, 0.7, 'k<', 'MarkerFaceColor', 'k', 'MarkerSize', 5);
plot([0 0], [0.1 0.7], 'k-', 'LineWidth', 1.5);
text(0.25, 0.6, 'NMOS', 'Color', 'b', 'FontWeight', 'bold');

% Wejście UI i wyjście UO
plot([-0.6 -0.6], [1.3 2.3], 'k-', 'LineWidth', 2);
plot([-1.5 -0.6], [1.8 1.8], 'k-', 'LineWidth', 2);
plot(-1.55, 1.8, 'ko', 'MarkerSize', 7, 'LineWidth', 1.5);
text(-2.1, 1.8, 'U_I', 'FontWeight', 'bold', 'FontSize', 11);

plot([0 0], [1.3 2.3], 'k-', 'LineWidth', 2);
plot([0 1.2], [1.8 1.8], 'k-', 'LineWidth', 2);
plot(1.25, 1.8, 'ko', 'MarkerSize', 7, 'LineWidth', 1.5);
text(1.4, 1.8, 'U_O', 'FontWeight', 'bold', 'FontSize', 11);
xlim([-2.5 2.5]); ylim([-1.2 4.8]);

% --- 9b) Charakterystyka przejściowa inwertera CMOS ---
subplot(1, 2, 2); hold on; grid on; box on;
UI = linspace(0, 5, 500);
UIL = 1.8; UIH = 3.2; UOH = 5.0; UOL = 0.0;

UO = zeros(size(UI));
UO(UI <= UIL)           = UOH;
UO(UI > UIL & UI < UIH) = UOH * (1 - (UI(UI > UIL & UI < UIH) - UIL) / (UIH - UIL));
UO(UI >= UIH)           = UOL;

IT = 2.2 * exp(-((UI - 2.5) / 0.35).^2);
IT(UI <= UIL | UI >= UIH) = 0;

plot(UI, UO, 'k-', 'LineWidth', 2.5, 'DisplayName', 'U_O = f(U_I)');
plot(UI, IT, 'b-', 'LineWidth', 1.8, 'DisplayName', 'Prąd przejściowy I_T');
xline(UIL, 'k--', 'U_{IL}', 'LabelVerticalAlignment', 'bottom', 'FontWeight', 'bold');
xline(UIH, 'k--', 'U_{IH}', 'LabelVerticalAlignment', 'bottom', 'FontWeight', 'bold');

text(0.15, 4.5, 'Przewodzi PMOS (I_T = 0)', 'Color', [0.1 0.45 0.1], 'FontWeight', 'bold');
text(1.85, 3.6, {'Przewodzą', 'oba tranzystory'}, 'Color', [0.85 0.35 0], 'FontWeight', 'bold');
text(3.30, 0.5, 'Przewodzi NMOS (I_T = 0)', 'Color', 'b', 'FontWeight', 'bold');

xlabel('Napięcie wejściowe U_I [V]'); ylabel('U_O [V]  /  I_T [j.w.]');
title('Zadanie 9b: Charakterystyka przejściowa CMOS (Rys. 13)');
xlim([0 5]); ylim([-0.3 5.6]); legend('Location', 'northeast');

%% ========================================================================
%  FIGURE 13 - ZADANIE 11: Idealna i rzeczywista charakterystyka przejściowa
%  inwertera (Rys. 9) oraz definicja czasu propagacji tp (Rys. 10)
%  (Źródło: Ćwiczenie UT2 - wstęp teoretyczny.pdf, str. 4, Rys. 9 i Rys. 10)
% =========================================================================
figure('Name', 'Zadanie 11 - Charakterystyka idealna, rzeczywista i czas propagacji tp', ...
       'NumberTitle', 'off', 'Color', 'w', 'Position', [80, 80, 1220, 480]);

UI = linspace(0, 5, 500);
UOH = 4.5; UOL = 0.4;

% --- 11a) Idealna charakterystyka przejściowa (Rys. 9a) ---
subplot(1, 3, 1); hold on; grid on; box on;
U_prog = 2.5;
UO_ideal = UOH * ones(size(UI)); UO_ideal(UI >= U_prog) = UOL;
plot(UI, UO_ideal, 'k-', 'LineWidth', 2.5);
yline(UOH, 'k:'); yline(UOL, 'k:');
text(0.15, UOH+0.25, 'U_{OH} (Stan H)', 'FontWeight', 'bold');
text(0.15, UOL+0.25, 'U_{OL} (Stan L)', 'FontWeight', 'bold');
text(U_prog - 0.6, 0.1, 'U_{IL} = U_{IH}', 'Color', 'b', 'FontWeight', 'bold');
xlabel('U_I [V]'); ylabel('U_O [V]');
title('11a) Charakterystyka idealna (Rys. 9a)');
xlim([0 5]); ylim([0 5.2]);

% --- 11b) Rzeczywista (uproszczona) charakterystyka przejściowa (Rys. 9b) ---
subplot(1, 3, 2); hold on; grid on; box on;
UIL = 1.6; UIH = 3.4;
UO_real = UOH * ones(size(UI));
UO_real(UI > UIL & UI < UIH) = UOH - (UOH - UOL) * (UI(UI > UIL & UI < UIH) - UIL) / (UIH - UIL);
UO_real(UI >= UIH) = UOL;
plot(UI, UO_real, 'k-', 'LineWidth', 2.5);
xline(UIL, 'b--', 'U_{IL}', 'LabelVerticalAlignment', 'bottom', 'FontWeight', 'bold');
xline(UIH, 'b--', 'U_{IH}', 'LabelVerticalAlignment', 'bottom', 'FontWeight', 'bold');
yline(UOH, 'k:'); yline(UOL, 'k:');
text(0.15, UOH+0.25, 'U_{OH}', 'FontWeight', 'bold');
text(0.15, UOL+0.25, 'U_{OL}', 'FontWeight', 'bold');
xlabel('U_I [V]'); ylabel('U_O [V]');
title('11b) Charakterystyka rzeczywista (Rys. 9b)');
xlim([0 5]); ylim([0 5.2]);

% --- 11c) Definicja czasu propagacji tp = (tpLH + tpHL)/2 (Rys. 10) ---
subplot(1, 3, 3); hold on; grid on; box on;
t_p = linspace(0, 10, 500);
UI_t = zeros(size(t_p));
UI_t(t_p >= 1.5 & t_p < 2.5) = 5 * (t_p(t_p >= 1.5 & t_p < 2.5) - 1.5);
UI_t(t_p >= 2.5 & t_p <= 6.0)= 5;
UI_t(t_p > 6.0 & t_p < 7.0)  = 5 * (1 - (t_p(t_p > 6.0 & t_p < 7.0) - 6.0));

UO_t = 5 * ones(size(t_p));
UO_t(t_p >= 2.2 & t_p < 3.6) = 5 * (1 - (t_p(t_p >= 2.2 & t_p < 3.6) - 2.2)/1.4);
UO_t(t_p >= 3.6 & t_p <= 6.8)= 0;
UO_t(t_p > 6.8 & t_p < 8.4)  = 5 * ((t_p(t_p > 6.8 & t_p < 8.4) - 6.8)/1.6);

plot(t_p, UI_t, 'b-', 'LineWidth', 2, 'DisplayName', 'Wejście U_I(t)');
plot(t_p, UO_t, 'r-', 'LineWidth', 2, 'DisplayName', 'Wyjście U_O(t)');
yline(2.5, 'k:', 'Poziom 50%', 'LabelHorizontalAlignment', 'left');
xline(2.0, 'b--'); xline(2.9, 'r--'); % tpHL: od 2.0 do 2.9
xline(6.5, 'b--'); xline(7.6, 'r--'); % tpLH: od 6.5 do 7.6
text(2.05, 1.2, 't_{pHL}', 'FontWeight', 'bold', 'Color', 'k');
text(6.65, 1.2, 't_{pLH}', 'FontWeight', 'bold', 'Color', 'k');
xlabel('Czas t [ns]'); ylabel('Napięcie [V]');
title('11c) Czas propagacji t_p = (t_{pLH}+t_{pHL})/2 (Rys. 10)');
ylim([-0.5 5.8]); legend('Location', 'northeast');