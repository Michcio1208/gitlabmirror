% Zadanie 1 - Wykres sygnalu x(t)
t = linspace(-0.5, 1.5, 2000);
u = @(t) double(t >= 0);
x = (u(t) - u(t - 1)) .* abs(cos(4*pi*t));

figure;
plot(t, x, 'b', 'LineWidth', 2);
grid on;
title('Zadanie 1: Wykres sygnalu x(t) = [1(t) - 1(t-1)] \cdot |cos(4\pi t)|');
xlabel('Czas t [s]');
ylabel('Amplituda x(t)');
legend('x(t)', 'Location', 'northeast');
ylim([-0.2 1.2]);

%%
% Zadanie 2 - Wykresy sygnalow x(t) oraz y(t)
t = linspace(-12, 12, 3000);
tri = @(t) max(0, 1 - abs(t));
x = tri(t / 2);

y = zeros(size(t));
for n = -2:2
    y = y + 0.5 * tri((t - 8*n) / 2);
end

figure;
subplot(2,1,1);
plot(t, x, 'b', 'LineWidth', 2);
grid on;
title('Zadanie 2a: Sygnal o skonczonej energii x(t) = \Lambda(t/2)');
xlabel('Czas t [s]');
ylabel('x(t)');
legend('x(t)', 'Location', 'northeast');
ylim([-0.1 1.2]);

subplot(2,1,2);
plot(t, y, 'r', 'LineWidth', 2);
grid on;
title('Zadanie 2b: Sygnal okresowy o skonczonej mocy y(t)');
xlabel('Czas t [s]');
ylabel('y(t)');
legend('y(t)', 'Location', 'northeast');
ylim([-0.1 0.7]);
%%
% Zadanie 4 - Wykresy autosplotow (przyjeto A = 1, T = 1)
A = 1; T = 1;
t = linspace(-3*T, 5*T, 2000);
tri = @(t) max(0, 1 - abs(t));

y1 = 3 * A^2 * T * tri((t - T) / (3*T));
y2 = A^2 * T * tri((t - 3*T) / T);

figure;
plot(t, y1, 'b', 'LineWidth', 2); hold on;
plot(t, y2, 'r--', 'LineWidth', 2);
grid on;
title('Zadanie 4: Wykresy autosplotow impulsow prostokatnych (dla A=1, T=1)');
xlabel('Czas t [s]');
ylabel('Amplituda autosplotu');
legend('Lewy impuls: 3A^2T \Lambda((t-T)/3T)', 'Prawy impuls: A^2T \Lambda((t-3T)/T)', 'Location', 'northwest');
ylim([-0.2 3.5]);
%%
% Zadanie 5 - Wykres pochodnej dystrybucyjnej dx(t)/dt (dla T = 1)
T = 1;
t_imp = [0, T, 2*T, 3*T];
wagi = [3, -1, -1, -1];

figure;
stem(t_imp, wagi, 'r', 'LineWidth', 2, 'MarkerFaceColor', 'r');
yline(0, 'k-');
grid on;
title('Zadanie 5: Wykres pochodnej dystrybucyjnej dx(t)/dt (delty Diraca)');
xlabel('Czas t [s] (przyjeto T = 1)');
ylabel('Waga delty Diraca');
legend('dx(t)/dt', 'Location', 'northeast');
xlim([-0.5 3.5]);
ylim([-1.5 3.5]);
%%
% Zadanie 7 - Wykresy widm amplitudowych i fazowych (podpunkty a oraz d)
n_ad = -2:2;
A_a = [0.25, sqrt(2)/2, 1.5, sqrt(2)/2, 0.25];
phi_a = [-pi, 3*pi/4, 0, -3*pi/4, pi];

A_d = [1, 2, 3, 2, 1];
phi_d = [0, -pi, 0, pi, 0];

figure;
subplot(2,2,1);
stem(n_ad, A_a, 'b', 'LineWidth', 2, 'MarkerFaceColor', 'b'); grid on;
title('Zadanie 7a: Widmo amplitudowe |X_n|'); xlabel('n'); ylabel('A_n');
legend('|X_n| (7a)');

subplot(2,2,2);
stem(n_ad, phi_a, 'r', 'LineWidth', 2, 'MarkerFaceColor', 'r'); grid on;
title('Zadanie 7a: Widmo fazowe \phi_n'); xlabel('n'); ylabel('\phi_n [rad]');
legend('\phi_n (7a)');

subplot(2,2,3);
stem(n_ad, A_d, 'b', 'LineWidth', 2, 'MarkerFaceColor', 'b'); grid on;
title('Zadanie 7d: Widmo amplitudowe |X_n|'); xlabel('n'); ylabel('A_n');
legend('|X_n| (7d)');
subplot(2,2,4);
%%
% Zadanie 8 - Wykresy dwustronnego widma amplitudowego, fazowego i mocy
n = -3:3;
c_abs = [0.25, 1.5, 0, 2, 0, 1.5, 0.25];
c_arg = [-pi/2, 0, 0, 0, 0, 0, pi/2];
c_pow = c_abs.^2;

figure;
subplot(3,1,1);
stem(n, c_abs, 'b', 'LineWidth', 2, 'MarkerFaceColor', 'b'); grid on;
title('Zadanie 8: Dwustronne widmo amplitudowe |c_n|'); xlabel('n'); ylabel('|c_n|');
legend('|c_n|');

subplot(3,1,2);
stem(n, c_arg, 'r', 'LineWidth', 2, 'MarkerFaceColor', 'r'); grid on;
title('Zadanie 8: Dwustronne widmo fazowe arg(c_n)'); xlabel('n'); ylabel('arg(c_n) [rad]');
legend('arg(c_n)');

subplot(3,1,3);
stem(n, c_pow, 'k', 'LineWidth', 2, 'MarkerFaceColor', 'k'); grid on;
title('Zadanie 8: Dwustronne widmo mocy |c_n|^2'); xlabel('n'); ylabel('|c_n|^2');
legend('|c_n|^2');s
%%
% Zadanie 11 - Widmo amplitudowe |X(omega)|
w = linspace(-10, 10, 4000);
rect = @(w) double(abs(w) <= 0.5);
X_w = 0.5*rect((w-5)/4) - 0.25*rect((w-5)/3) + 0.5*rect((w+5)/4) - 0.25*rect((w+5)/3);

figure;
plot(w, abs(X_w), 'b', 'LineWidth', 2); grid on;
title('Zadanie 11: Widmo amplitudowe |X(\omega)|');
xlabel('Pulsacja \omega [rad/s]'); ylabel('|X(\omega)|');
legend('|X(\omega)|', 'Location', 'northeast');
ylim([-0.05 0.6]);
%%
% Zadanie 13: Sygnaly x(t), x1(t) oraz widmo amplitudowe i fazowe X1(omega)
tau = 2; % przykladowa wartosc parametru tau > 0

% 1. Dziedzina czasu
t = linspace(-2*tau, 2*tau, 4000);
u = @(t) double(t > 0) + 0.5*double(t == 0);

x  = u(t + tau/2) - u(t - tau/2);
x1 = (u(t + tau) - u(t)) - (u(t) - u(t - tau));

% 2. Dziedzina czestotliwosci (pulsacji omega)
w = linspace(-6*pi/tau, 6*pi/tau, 4000); % bez dokladnego zera w siatce
Sa = @(a) sinc(a / pi); % MATLAB sinc(x) = sin(pi*x)/(pi*x)

X1_w = 1j * 2 * tau * Sa(w*tau/2) .* sin(w*tau/2);
A_w  = abs(X1_w);
obwiednia = 4 ./ abs(w);
phi_w = (pi/2) * sign(w); % analityczne widmo fazowe poza zerami w = 2*pi*k/tau
w_zera = (-6:6) * (2*pi/tau);

% 3. Rysowanie wykresow
figure('Name', 'Zadanie 13 - SYSE', 'Color', 'w');

subplot(2, 2, 1);
plot(t, x, 'b', 'LineWidth', 2);
grid on;
title('Sygnal x(t) = \Pi(t/\tau) dla \tau = 2');
xlabel('Czas t [s]');
ylabel('Amplituda x(t)');
legend('x(t)', 'Location', 'northeast');
ylim([-0.3 1.3]);

subplot(2, 2, 2);
plot(t, x1, 'r', 'LineWidth', 2);
grid on;
title('Sygnal x_1(t) = x(t+\tau/2) - x(t-\tau/2) dla \tau = 2');
xlabel('Czas t [s]');
ylabel('Amplituda x_1(t)');
legend('x_1(t)', 'Location', 'northeast');
ylim([-1.3 1.3]);

subplot(2, 2, 3);
plot(w, A_w, 'b', 'LineWidth', 2); hold on;
plot(w, obwiednia, 'k--', 'LineWidth', 1);
grid on;
title('Widmo amplitudowe |X_1(\omega)| dla \tau = 2');
xlabel('Pulsacja \omega [rad/s]');
ylabel('|X_1(\omega)|');
legend('|X_1(\omega)|', 'Obwiednia 4/|\omega|', 'Location', 'northeast');
ylim([0 1.6*tau]);

subplot(2, 2, 4);
plot(w(w < 0), phi_w(w < 0), 'm', 'LineWidth', 2); hold on;
plot(w(w > 0), phi_w(w > 0), 'm', 'LineWidth', 2, 'HandleVisibility', 'off');
plot(w_zera(w_zera < 0), -pi/2 * ones(size(w_zera(w_zera < 0))), 'mo', 'MarkerFaceColor', 'w');
plot(w_zera(w_zera > 0),  pi/2 * ones(size(w_zera(w_zera > 0))), 'mo', 'MarkerFaceColor', 'w', 'HandleVisibility', 'off');
grid on;
title('Widmo fazowe arg\{X_1(\omega)\} dla \tau = 2');
xlabel('Pulsacja \omega [rad/s]');
ylabel('Faza [rad]');
yticks([-pi/2, 0, pi/2]);
yticklabels({'-\pi/2', '0', '+\pi/2'});
legend('arg\{X_1(\omega)\}', 'Punkty zerowe |X_1(\omega)| = 0', 'Location', 'southeast');
ylim([-pi, pi]);
%%
% Zadanie 16 - Wykresy sygnalow x1(t), x2(t) oraz ich splotu y(t)
t = linspace(-3, 6, 2000);
rect = @(t) double(abs(t) <= 0.5);
tri = @(t) max(0, 1 - abs(t));

x1 = rect(t / 2);
x2 = 2 * rect((t - 2) / 2);
y = 4 * tri((t - 2) / 2);

figure;
plot(t, x1, 'b--', 'LineWidth', 1.5); hold on;
plot(t, x2, 'g-.', 'LineWidth', 1.5);
plot(t, y, 'r', 'LineWidth', 2.5);
grid on;
title('Zadanie 16: Splot sygnalow y(t) = x_1(t) * x_2(t)');
xlabel('Czas t [s]');
ylabel('Amplituda');
legend('x_1(t) = \Pi(t/2)', 'x_2(t) = 2\Pi((t-2)/2)', 'y(t) = 4\Lambda((t-2)/2)', 'Location', 'northwest');
ylim([-0.2 4.5]);
%%
%% Zadanie 1: Splot, parametry oraz pochodna dx/dt
t1 = linspace(-3, 5, 4000);
% Tworzenie x(t) jako sumy przesunietych impulsow prostokatnych o wysokosci 2 i szerokosci 0.5
x1 = zeros(size(t1));
for n = -2:3
    x1 = x1 + 2 * double(abs(t1 - 2*n) < 0.25) + 1 * double(abs(t1 - 2*n) == 0.25);
end

% Pochodna dx/dt przyblizona numerycznie do wizualizacji (w teorii impulsy Diraca +/-2)
dt1 = t1(2) - t1(1);
dx1_dt = gradient(x1, dt1);

figure('Name', 'Zadanie 1 - Splot i pochodna');
subplot(2,1,1);
plot(t1, x1, 'b', 'LineWidth', 1.8); hold on;
yline(0.5, '--r', 'LineWidth', 1.2);
yline(1.0, ':k', 'LineWidth', 1.2);
grid on;
ylim([-0.5, 2.6]);
xlabel('Czas t [s]');
ylabel('x(t)');
title('Zadanie 1: Sygnal x(t), wartosc srednia i moc srednia');
legend('x(t)', 'Wartosc srednia x_{sr} = 0.5', 'Moc srednia P_x = 1', 'Location', 'best');

subplot(2,1,2);
stem_t = [];
stem_v = [];
for n = -2:3
    stem_t = [stem_t, 2*n - 0.25, 2*n + 0.25];
    stem_v = [stem_v, 2, -2];
end
stem(stem_t, stem_v, 'm', 'LineWidth', 1.8, 'MarkerFaceColor', 'm');
grid on;
ylim([-2.8, 2.8]);
xlabel('Czas t [s]');
ylabel('dx(t)/dt');
title('Zadanie 1: Pochodna dx/dt (impulsy Diraca o wagach +/-2)');
legend('2\delta(t - 2n + 0.25) - 2\delta(t - 2n - 0.25)', 'Location', 'best');

%% Zadanie 2: Widmo amplitudowe i fazowe szeregu Fouriera
k = [-5, -2, 0, 2, 5];
w0 = pi/3;
wk = k * w0;
ck = [ -1/4, (1 + 1j)/2, 1, (1 - 1j)/2, -1/4 ];
mag_ck = abs(ck);
phase_ck = angle(ck);

figure('Name', 'Zadanie 2 - Widmo szeregu Fouriera');
subplot(2,1,1);
stem(wk, mag_ck, 'b', 'LineWidth', 1.8, 'MarkerFaceColor', 'b');
grid on;
xlim([-6, 6]);
ylim([0, 1.2]);
xlabel('Pulsacja k\omega_0 [rad/s]');
ylabel('|c_k|');
title('Zadanie 2c: Widmo amplitudowe |c_k|');
legend('|c_k|', 'Location', 'best');

subplot(2,1,2);
stem(wk, phase_ck, 'r', 'LineWidth', 1.8, 'MarkerFaceColor', 'r');
grid on;
xlim([-6, 6]);
ylim([-3.6, 3.6]);
yticks([-pi, -pi/2, 0, pi/2, pi]);
yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
xlabel('Pulsacja k\omega_0 [rad/s]');
ylabel('arg(c_k) [rad]');
title('Zadanie 2c: Widmo fazowe arg(c_k)');
legend('arg(c_k)', 'Location', 'best');

%% Zadanie 3: Widmo amplitudowe i fazowe X(omega) oraz sygnal x(t)
w3 = linspace(-5, 5, 4000);
X3 = 1j * 4 * double(abs(0.5*w3 + 1) < 0.5) - 1j * 4 * double(abs(0.5*w3 - 1) < 0.5);

figure('Name', 'Zadanie 3 - Widmo X(omega)');
subplot(2,1,1);
plot(w3, abs(X3), 'b', 'LineWidth', 1.8);
grid on;
ylim([-0.5, 5]);
xlabel('Pulsacja \omega [rad/s]');
ylabel('|X(\omega)|');
title('Zadanie 3: Widmo amplitudowe |X(\omega)|');
legend('|X(\omega)|', 'Location', 'best');

subplot(2,1,2);
phase_X3 = zeros(size(w3));
phase_X3(w3 > -3 & w3 < -1) = pi/2;
phase_X3(w3 > 1 & w3 < 3) = -pi/2;
plot(w3, phase_X3, 'r', 'LineWidth', 1.8);
grid on;
ylim([-2.2, 2.2]);
yticks([-pi/2, 0, pi/2]);
yticklabels({'-\pi/2', '0', '\pi/2'});
xlabel('Pulsacja \omega [rad/s]');
ylabel('arg X(\omega) [rad]');
title('Zadanie 3: Widmo fazowe arg X(\omega)');
legend('arg X(\omega)', 'Location', 'best');
%%
% Zadanie 1c - Pochodna sygnalu x(t)
t = linspace(-4, 3, 2000);
dx_cont = -heaviside(t) + heaviside(t - 1);

figure;
plot(t, dx_cont, 'b', 'LineWidth', 1.8); hold on;
stem(-2, 1, 'r', 'LineWidth', 2, 'Marker', '^', 'MarkerSize', 8);
grid on;
ylim([-1.5, 1.5]);
xlabel('Czas t [s]');
ylabel('dx(t)/dt');
title('Zadanie 1c: Pochodna sygnalu x(t)');
legend('Czesc regularna (-1 na (0,1))', 'Impuls Diraca \delta(t+2) (waga 1)', 'Location', 'best');
%%
% Zadanie 2c - Widmo amplitudowe i fazowe
f0 = 0.05;
k = [-5, -2, 0, 2, 5];
f = k * f0;
ck = [-0.25, -0.5j, 2, 0.5j, -0.25];
amp = abs(ck);
phase = angle(ck);

figure;
subplot(2,1,1);
stem(f, amp, 'filled', 'LineWidth', 1.5);
grid on;
xlim([-0.35, 0.35]);
ylim([0, 2.4]);
xlabel('Czestotliwosc f [Hz]');
ylabel('|c_k|');
title('Zadanie 2c: Widmo amplitudowe sygnalu x(t)');
legend('|c_k|', 'Location', 'northeast');

subplot(2,1,2);
stem(f, phase, 'filled', 'LineWidth', 1.5);
grid on;
xlim([-0.35, 0.35]);
ylim([-3.6, 3.6]);
yticks([-pi, -pi/2, 0, pi/2, pi]);
yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
xlabel('Czestotliwosc f [Hz]');
ylabel('\angle c_k [rad]');
title('Zadanie 2c: Widmo fazowe sygnalu x(t)');
legend('\angle c_k', 'Location', 'northeast');
%%
% Zadanie 3 - Widmo amplitudowe i fazowe X(f)
f = linspace(-5, 5, 4000);
rect_pos = (f > 2.75) & (f < 3.25);
rect_neg = (f > -3.25) & (f < -2.75);
Xf = -1j * rect_pos + 1j * rect_neg;

amp_X = abs(Xf);
phase_X = angle(Xf) .* (rect_pos | rect_neg);

figure;
subplot(2,1,1);
plot(f, amp_X, 'b', 'LineWidth', 1.8);
grid on;
ylim([-0.1, 1.3]);
xlabel('Czestotliwosc f [Hz]');
ylabel('|X(f)|');
title('Zadanie 3: Widmo amplitudowe sygnalu x(t)');
legend('|X(f)|', 'Location', 'northeast');

subplot(2,1,2);
plot(f(rect_neg), phase_X(rect_neg), 'r', 'LineWidth', 1.8); hold on;
plot(f(rect_pos), phase_X(rect_pos), 'm', 'LineWidth', 1.8);
grid on;
xlim([-5, 5]);
ylim([-2.2, 2.2]);
yticks([-pi/2, 0, pi/2]);
yticklabels({'-\pi/2', '0', '\pi/2'});
xlabel('Czestotliwosc f [Hz]');
ylabel('\angle X(f) [rad]');
title('Zadanie 3: Widmo fazowe sygnalu x(t)');
legend('Pasmo ujemne (+\pi/2)', 'Pasmo dodatnie (-\pi/2)', 'Location', 'northeast');  

