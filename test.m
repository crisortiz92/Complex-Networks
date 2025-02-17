clc; clear; close all;

% Parámetros iniciales
theta1_0 = pi/4; % Ángulo inicial en radianes
w_values = [0.5, 1, 2];  % Diferentes velocidades angulares
tspan = [0 10];  % Intervalo de tiempo
r = 1;  % Radio constante

% Colores y estilos para diferenciar cada caso
colors = {'r', 'b', 'g'};  

% Inicialización de la figura principal
figure;

% --- Subplot 1: Evolución de theta_1(t) ---
subplot(4,1,1); hold on;
title('Evolución de \theta_1 en coordenadas polares');
xlabel('Tiempo (s)');
ylabel('\theta_1 (rad)');
grid on;

% --- Subplot 2: Evolución de x(t) ---
subplot(4,1,2); hold on;
title('Evolución de x(t)');
xlabel('Tiempo (s)');
ylabel('x(t)');
grid on;

% --- Subplot 3: Evolución de y(t) ---
subplot(4,1,3); hold on;
title('Evolución de y_{rect}(t)');
xlabel('Tiempo (s)');
ylabel('y_{rect}(t)');
grid on;

% --- Subplot 4: Trayectoria en coordenadas rectangulares ---
subplot(4,1,4); hold on;
title('Trayectoria en coordenadas rectangulares');
xlabel('x');
ylabel('y');
axis equal;
grid on;

% Resolver para cada velocidad angular diferente
for i = 1:length(w_values)
    w0 = w_values(i); % Seleccionar la velocidad angular actual
    
    % Resolver la ecuación diferencial con ode45
    [t, y] = ode45(@(t, y) polarODE(t, y, w0), tspan, [theta1_0; w0]);

    % Convertir a coordenadas rectangulares
    x = r * cos(y(:,1));
    y_rect = r * sin(y(:,1));

    % Obtener el último punto
    x_final = x(end);
    y_final = y_rect(end);
    
    % Graficar resultados en los subplots correspondientes
    subplot(4,1,1);
    plot(t, y(:,1), 'Color', colors{i}, 'LineWidth', 2, 'DisplayName', sprintf('w = %.1f', w0));

    subplot(4,1,2);
    plot(t, x, 'Color', colors{i}, 'LineWidth', 2, 'DisplayName', sprintf('w = %.1f', w0));

    subplot(4,1,3);
    plot(t, y_rect, 'Color', colors{i}, 'LineWidth', 2, 'DisplayName', sprintf('w = %.1f', w0));

    subplot(4,1,4);
    plot(x(1:end-1), y_rect(1:end-1), 'Color', colors{i}, 'LineWidth', 2, 'DisplayName', sprintf('w = %.1f', w0));
    plot(x_final, y_final, '*', 'Color', colors{i}, 'MarkerSize', 10, 'MarkerFaceColor', colors{i});
end

% Agregar leyendas a cada subplot
subplot(4,1,1); legend show;
subplot(4,1,2); legend show;
subplot(4,1,3); legend show;
subplot(4,1,4); legend show;

% ======================== Función anidada ========================
function dydt = polarODE(~, y, w)
    % Esta función define el sistema de ecuaciones diferenciales en coordenadas polares.
    % Entradas:
    %   t - Tiempo (no afecta la ecuación en este caso)
    %   y - Vector de estado [theta_1; w_1]
    %   w - Velocidad angular constante
    % Salida:
    %   dydt - Vector de derivadas [d(theta_1)/dt; d(w_1)/dt]

    dydt = zeros(2,1); % Inicializa el vector de derivadas
    dydt(1) = w;       % d(theta_1)/dt = w (constante)
    dydt(2) = 0;       % d(w_1)/dt = 0 (w_1 es constante)
end
