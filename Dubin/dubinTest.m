clc
clear

addpath('../Tools');

xlim = [-100, 100];
ylim = [-100, 100];
xstart = 0;
ystart = -50;

circular_obs1 = [0, 0, 15];
circular_obstacle_coords{1} = circular_obs1;

[fig, ax] = initializeFigure2D('Dubin', 'GridOn', xlim, ylim);
% plotObstaclesCircle(circular_obstacle_coords, ax);


N = 100;
q_start = [-75, -75, deg2rad(0)];
q_end = [75, 75, deg2rad(45)];
% u_traj = 0.01 + zeros(1, N);
u_traj = randn(1, N);
delta_t = 0.1;
V = 1;
eta = 0.001;

h = plotCar(q_start(1), q_start(2), q_start(3), 5, ax);

[q_traj, u_traj, lambda] = directShootingDubin(q_start, q_end, u_traj, V, delta_t, eta);

%Simulate

hold off;
for i=1:N+1
    q = q_traj(:, i);
    pause(0.05);
    cla(ax);
    plotCar(q(1), q(2), q(3), 5, ax);
end
    
    
    
    
    
    

