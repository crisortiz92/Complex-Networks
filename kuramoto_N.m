clc; clear; close all;

% Parámetros del sistema
N = 100;                % Número de osciladores
omega = rand(1, N);   % Frecuencias naturales aleatorias entre 0 y 1
K = 2;                % Parámetro de acoplamiento
theta0 = 2 * pi * rand(1, N); % Fases iniciales aleatorias en [0, 2π]
tspan = [0 10];       % Intervalo de tiempo
r = 1.5;                % Radio constante

% Resolver el sistema con ode45
[t, theta] = ode45(@(t, y) kuramotoODE(t, y, omega, K, N), tspan, theta0);

% Convertir a coordenadas rectangulares
x = r * cos(theta);
y_rect = r * sin(theta);

% Crear figura para todas las gráficas
figure;

% --- Subplot 1: Evolución de las fases ---
subplot(4,1,1); hold on;
for i = 1:N
    plot(t, theta(:,i), 'LineWidth', 2);
end
xlabel('Tiempo (s)');
ylabel('\theta (rad)');
title('Evolución de las fases de los osciladores');
%legend(arrayfun(@(i) sprintf('\\theta_%d', i), 1:N, 'UniformOutput', false));
grid on;

% --- Subplot 2: Evolución de x(t) ---
subplot(4,1,2); hold on;
for i = 1:N
    plot(t, x(:,i), 'LineWidth', 2);
end
xlabel('Tiempo (s)');
ylabel('x(t)');
title('Evolución de x(t)');
%legend(arrayfun(@(i) sprintf('x_%d', i), 1:N, 'UniformOutput', false));
grid on;

% --- Subplot 3: Evolución de y(t) ---
subplot(4,1,3); hold on;
for i = 1:N
    plot(t, y_rect(:,i), 'LineWidth', 2);
end
xlabel('Tiempo (s)');
ylabel('y_{rect}(t)');
title('Evolución de y_{rect}(t)');
%legend(arrayfun(@(i) sprintf('y_{rect,%d}', i), 1:N, 'UniformOutput', false));
grid on;

% --- Subplot 4: Trayectoria en coordenadas rectangulares ---
subplot(4,1,4); hold on;
for i = 1:N
    plot(x(:,i), y_rect(:,i), 'LineWidth', 2);
end
xlabel('x');
ylabel('y');
title('Trayectoria en coordenadas rectangulares');
axis equal;
%legend(arrayfun(@(i) sprintf('Oscilador %d', i), 1:N, 'UniformOutput', false));
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
