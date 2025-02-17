% Definir el rango de tiempo
tspan = [0 10];

% Definir condiciones iniciales [x1, x2]
init_conditions = [-pi/2, 0;  % Oscilación desde posición baja
                   0, 1;      % Pequeña velocidad inicial
                   pi/4, -1;  % Pequeña oscilación negativa
                   pi, 0.5];  % Cerca del equilibrio inestable

% Crear figura
figure;
hold on;
grid on;

% Colores para distinguir las trayectorias
colors = ['b', 'r', 'g', 'm'];

% Resolver el sistema para diferentes condiciones iniciales
for i = 1:size(init_conditions, 1) % Bucle sobre condiciones iniciales
    % Resolver el sistema usando ODE45
    [t, Y] = ode45(@(t, y) [y(2); -10*sin(y(1))], tspan, init_conditions(i, :)');
    
    % Graficar la trayectoria en 3D (x1, x2, t)
    plot3(Y(:,1), Y(:,2), t, 'Color', colors(i), 'LineWidth', 1.5);
end

% Etiquetas y título
xlabel('x_1 (Ángulo)');
ylabel('x_2 (Velocidad Angular)');
zlabel('Tiempo');
title('Retrato de Fase 3D del Péndulo');
legend('Condición 1', 'Condición 2', 'Condición 3', 'Condición 4');

% Ajustar la vista 3D
view(45, 30);
hold off;