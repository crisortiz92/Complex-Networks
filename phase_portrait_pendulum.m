% Define the grid range
x1_range = linspace(-pi, pi, 20);  % Angle range
x2_range = linspace(-4, 4, 20);    % Angular velocity range

[X1, X2] = meshgrid(x1_range, x2_range);  % Mesh grid for vector field

% Compute the vector field
X1_dot = X2;
X2_dot = -10 * sin(X1);

% Plot the vector field using streamlines
figure;
hold on;
quiver(X1, X2, X1_dot, X2_dot, 0.5, 'b'); % Vector field

% Simulate trajectories for different initial conditions
for x10 = [-pi, -pi/2, 0, pi/2, pi]  % Different angles
    for x20 = [-2, 0, 2]  % Different angular velocities
        [t, Y] = ode45(@(t, y) [y(2); -10*sin(y(1))], [0 10], [x10; x20]);
        plot(Y(:,1), Y(:,2), 'r', 'LineWidth', 1.5); % Trajectories
    end
end

xlabel('x_1 (Angle)');
ylabel('x_2 (Angular Velocity)');
title('Phase Portrait of the Pendulum');
grid on;
axis([-pi pi -4 4]);
hold off;


% Time span for simulation
tspan = [0 10];

% Initial conditions for different cases
init_conditions = [0, 1; % Small initial velocity
                   pi/4, 0; % Small initial displacement
                   pi, 0.5]; % Unstable equilibrium perturbation

figure;
hold on;
for i = 1:size(init_conditions, 1)
    [t, Y] = ode45(@(t, y) [y(2); -10*sin(y(1))], tspan, init_conditions(i, :)');
    
    subplot(2,1,1);
    plot(t, Y(:,1), 'LineWidth', 1.5);
    hold on;
    xlabel('Time');
    ylabel('x_1 (Angle)');
    title('Time Evolution of x_1');
    
    subplot(2,1,2);
    plot(t, Y(:,2), 'LineWidth', 1.5);
    hold on;
    xlabel('Time');
    ylabel('x_2 (Angular Velocity)');
    title('Time Evolution of x_2');
end
hold off;
grid on;

[X1, X2] = meshgrid(linspace(-pi, pi, 50), linspace(-4, 4, 50));
Energy = 0.5 * X2.^2 - 10 * cos(X1);

figure;
contour(X1, X2, Energy, 30); % Energy level curves
xlabel('x_1 (Angle)');
ylabel('x_2 (Angular Velocity)');
title('Energy Contours of the Pendulum');
grid on;