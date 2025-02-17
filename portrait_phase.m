% Definir la matriz A
A = [2 0; 0 -1]; % Ejemplo: eigenvalues 2 y -1

% Encontrar eigenvalues y eigenvectors
[V, D] = eig(A);
lambda1 = D(1, 1); % Primer eigenvalue
lambda2 = D(2, 2); % Segundo eigenvalue
v1 = V(:, 1);      % Primer eigenvector
v2 = V(:, 2);      % Segundo eigenvector

% Crear una malla para el espacio de estados
[x1, x2] = meshgrid(-5:0.5:5, -5:0.5:5);

% Calcular las derivadas (dx1/dt y dx2/dt)
dx1 = A(1, 1) * x1 + A(1, 2) * x2;
dx2 = A(2, 1) * x1 + A(2, 2) * x2;

% Graficar el retrato fase
figure;
quiver(x1, x2, dx1, dx2, 'b'); % Campo vectorial
hold on;
plot([-v1(1), v1(1)], [-v1(2), v1(2)], 'r', 'LineWidth', 2); % Eigenvector 1
plot([-v2(1), v2(1)], [-v2(2), v2(2)], 'g', 'LineWidth', 2); % Eigenvector 2
xlabel('x_1');
ylabel('x_2');
title('Retrato fase');
grid on;
axis tight;
legend('Campo vectorial', 'Eigenvector 1', 'Eigenvector 2');