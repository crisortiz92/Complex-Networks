clc; clear; close all;

% Parámetros del modelo
N = 30;         % Número de osciladores
K = 1.5;        % Constante de acoplamiento
dt = 0.01;      % Paso de tiempo
T = 10;         % Tiempo total de simulación
t = 0:dt:T;     % Vector de tiempo

% Frecuencias naturales (distribución normal)
omega = 2 * (rand(N,1) - 0.5);

% Condiciones iniciales (fases aleatorias entre 0 y 2*pi)
theta = 2 * pi * rand(N,1);

% Crear matriz de adyacencia (todos los nodos conectados con pesos K/N)
A = ones(N) - eye(N); % Matriz completa menos la diagonal
W = (K/N) * A;        % Matriz de pesos de acoplamiento

% Crear grafo
G = graph(W, 'upper');

% Posiciones de los nodos en un círculo
theta_pos = linspace(0, 2*pi, N+1)';
theta_pos = theta_pos(1:end-1); % Eliminar el último punto repetido
x = cos(theta_pos);
y = sin(theta_pos);

% Graficar la red
figure;
plot(G, 'XData', x, 'YData', y, 'LineWidth', G.Edges.Weight * 5, ...
     'EdgeColor', [0, 0, 0.5], 'NodeColor', 'r', 'MarkerSize', 8);
title('Red de Acoplamiento en el Modelo de Kuramoto');
axis equal;
