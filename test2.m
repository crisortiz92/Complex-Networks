clc; clear; close all;

% Parámetros del sistema
N = 3;               % Número de osciladores
omega = [1, 1.5, 2]; % Frecuencias naturales
K = 2;               % Parámetro de acoplamiento
theta0 = [pi/4, pi/3, pi/6]; % Condiciones iniciales de fase
tspan = [0 10];      % Intervalo de tiempo
r = 1;               % Radio constante

% Resolver el sistema con ode45
[t, theta] = ode45(@(t, y) kuramotoODE(t, y, omega, K, N), tspan, theta0);

% Convertir a coordenadas rectangulares
x = r * cos(theta);
y_rect = r * sin(theta);

% Crear figura para todas las gráficas
figure;

% --- Subplot 1: Evolución de las fases ---
subplot(4,1,1); hold on;
plot(t, theta(:,1), 'r', 'LineWidth', 2);
plot(t, theta(:,2), 'b', 'LineWidth', 2);
plot(t, theta(:,3), 'g', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('\theta (rad)');
title('Evolución de las fases de los osciladores');
legend('\theta_1', '\theta_2', '\theta_3');
grid on;

% --- Subplot 2: Evolución de x(t) ---
subplot(4,1,2); hold on;
plot(t, x(:,1), 'r', 'LineWidth', 2);
plot(t, x(:,2), 'b', 'LineWidth', 2);
plot(t, x(:,3), 'g', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('x(t)');
title('Evolución de x(t)');
legend('x_1', 'x_2', 'x_3');
grid on;

% --- Subplot 3: Evolución de y(t) ---
subplot(4,1,3); hold on;
plot(t, y_rect(:,1), 'r', 'LineWidth', 2);
plot(t, y_rect(:,2), 'b', 'LineWidth', 2);
plot(t, y_rect(:,3), 'g', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('y_{rect}(t)');
title('Evolución de y_{rect}(t)');
legend('y_{rect,1}', 'y_{rect,2}', 'y_{rect,3}');
grid on;

% --- Subplot 4: Trayectoria en coordenadas rectangulares ---
subplot(4,1,4); hold on;
plot(x(:,1), y_rect(:,1), 'r', 'LineWidth', 2);
plot(x(:,2), y_rect(:,2), 'b', 'LineWidth', 2);
plot(x(:,3), y_rect(:,3), 'g', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('Trayectoria en coordenadas rectangulares');
axis equal;
legend('Oscilador 1', 'Oscilador 2', 'Oscilador 3');
grid on;

% ======================== Función anidada ========================
function dydt = kuramotoODE(~, y, omega, K, N)
    % Modelo de Kuramoto para N osciladores acoplados
    % Entradas:
    %   y - Vector de estados [theta_1; theta_2; ...; theta_N]
    %   omega - Frecuencias naturales [w1, w2, ..., wN]
    %   K - Constante de acoplamiento
    %   N - Número de osciladores
    % Salida:
    %   dydt - Vector de derivadas [d(theta_1)/dt; ...; d(theta_N)/dt]

    dydt = zeros(N,1);
    for i = 1:N
        sum_sin = sum(sin(y - y(i)));  % Suma de acoplamientos
        dydt(i) = omega(i) + (K/N) * sum_sin;
    end
end
