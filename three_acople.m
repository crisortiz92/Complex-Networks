clc; clear; close all;

% Parámetros del sistema
omega = [1, 1.5];  % Frecuencias naturales de los osciladores
K = 5;             % Parámetro de acoplamiento
theta0 = [pi/4, pi/3]; % Condiciones iniciales de fase
tspan = [0 10];    % Intervalo de tiempo
r = 1;  % Radio constante

% Resolver el sistema con ode45
[t, theta] = ode45(@(t, y) kuramotoODE(t, y, omega, K), tspan, theta0);

% Extraer las soluciones
theta1 = theta(:,1);
theta2 = theta(:,2);

% Convertir a coordenadas rectangulares
x1 = r * cos(theta1);
y1_rect = r * sin(theta1);
x2 = r * cos(theta2);
y2_rect = r * sin(theta2);

% Crear figura para todas las gráficas
figure;

% Gráfico 1: Evolución de las fases
subplot(4,1,1);
plot(t, theta1, 'r', 'LineWidth', 2); hold on;
plot(t, theta2, 'b', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('\theta (rad)');
title('Evolución de las fases de los osciladores');
legend('\theta_1', '\theta_2');
grid on;

% Gráfico 2: Evolución de x(t)
subplot(4,1,2);
plot(t, x1, 'r', 'LineWidth', 2); hold on;
plot(t, x2, 'b', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('x(t)');
title('Evolución de x(t)');
legend('x_1', 'x_2');
grid on;

% Gráfico 3: Evolución de y(t)
subplot(4,1,3);
plot(t, y1_rect, 'r', 'LineWidth', 2); hold on;
plot(t, y2_rect, 'b', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('y_{rect}(t)');
title('Evolución de y_{rect}(t)');
legend('y_{rect,1}', 'y_{rect,2}');
grid on;

% Gráfico 4: Trayectoria en coordenadas rectangulares
subplot(4,1,4);
plot(x1, y1_rect, 'r', 'LineWidth', 2); hold on;
plot(x2, y2_rect, 'b', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('Trayectoria en coordenadas rectangulares');
axis equal;
legend('Oscilador 1', 'Oscilador 2');
grid on;

% ======================== Función anidada ========================
function dydt = kuramotoODE(~, y, omega, K)
    % Modelo de Kuramoto para N=2 osciladores acoplados
    % Entradas:
    %   y - Vector de estados [theta_1; theta_2]
    %   omega - Frecuencias naturales [w1, w2]
    %   K - Constante de acoplamiento
    % Salida:
    %   dydt - Vector de derivadas [d(theta_1)/dt; d(theta_2)/dt]

    dydt = zeros(2,1);
    dydt(1) = omega(1) + (K/2) * sin(y(2) - y(1));
    dydt(2) = omega(2) + (K/2) * sin(y(1) - y(2));
end
