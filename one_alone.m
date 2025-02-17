clc; clear; close all;

% Parámetros iniciales
theta1_0 = pi/4; % Ángulo inicial en radianes
w1_0 = 1;        % Velocidad angular inicial
tspan = [0 10];  % Intervalo de tiempo

% Resolver la ecuación diferencial con ode45 usando la función anidada
[t, y] = ode45(@polarODE, tspan, [theta1_0; w1_0]);

% Convertir a coordenadas rectangulares
r = 1; % Suponemos un radio constante
x = r * cos(y(:,1));
y_rect = r * sin(y(:,1));

% Graficar resultados
figure;

% Gráfico 1: Evolución de θ_1 en el tiempo
subplot(4,1,1);
plot(t, y(:,1), 'r', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('\theta_1 (rad)');
title('Evolución de \theta_1 en coordenadas polares');
grid on;

% Gráfico 2: Evolución de x(t)
subplot(4,1,2);
plot(t, x, 'b', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('x(t)');
title('Evolución de x(t)');
grid on;

% Gráfico 3: Evolución de y_rect(t)
subplot(4,1,3);
plot(t, y_rect, 'g', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('y_{rect}(t)');
title('Evolución de y_{rect}(t)');
grid on;

% Gráfico 4: Trayectoria en coordenadas rectangulares
subplot(4,1,4);
plot(x, y_rect, 'm', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('Trayectoria en coordenadas rectangulares');
axis equal;
grid on;

% ======================== Función anidada ========================
function dydt = polarODE(~, y)
    % Esta función define el sistema de ecuaciones diferenciales en coordenadas polares.
    % Entradas:
    %   t - Tiempo (no afecta la ecuación en este caso)
    %   y - Vector de estado [theta_1; w_1]
    % Salida:
    %   dydt - Vector de derivadas [d(theta_1)/dt; d(w_1)/dt]

    dydt = zeros(2,1); % Inicializa el vector de derivadas
    dydt(1) = y(2);    % d(theta_1)/dt = w_1
    dydt(2) = 0;       % d(w_1)/dt = 0 (w_1 es constante)
end
