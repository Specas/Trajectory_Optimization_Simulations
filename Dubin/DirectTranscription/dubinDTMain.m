clc
clear

addpath('../../Tools');
addpath('../');

%Dock figures by default
set(0,'DefaultFigureWindowStyle','docked');

x_lim = [-100, 100];
y_lim = [-100, 100];

%Start and end configurations. a corresponds to the x coordinate and b
%corresponds to the y coordinate
a_start = 0;
b_start = -50;
theta_start = 0;

a_end = 90;
b_end = 85;
theta_end = 3.5;

%Start and end state vectors
%Note that in this case we do not require velocity components in the state
%vectors as the dynamics equations basically relate the velocities. They
%thus directly translate to configurations in the next/previous state in
%the discretized equation.
x_start = [a_start; b_start; theta_start];
x_end = [a_end; b_end; theta_end];

%Velocity
v = 5;

%Size of the car (Basically the distance between the centroid of the
%triangle to one of the vertices)
car_size = 5;

%Initializing number of steps in the trajectory
N = 150;

%Total time in seconds
T = 1;

%Discrete time step
dt = T/N;

%Setting up obstacles
circular_obs = [0, 0, 15];
for i=1:size(circular_obs, 1)
    circular_obstacle_coords{i} = circular_obs(i, :);
end

[fig, ax] = initializeFigure2D('Dubin', 'GridOn', x_lim, y_lim);
plotCar(a_start, b_start, theta_start, car_size, ax);
% plotObstaclesCircle(circular_obstacle_coords, ax);

%Plotting initial position

xu_sol = doDT(x_start, x_end, v, N, dt);

%For some reason the starting starting is off by a big margin. The
%subsequent configurations seem to make sense. 
%TODO: figure out why the first 3 values of xu_sol are incorrect. Makeshift
%solution for now (By overwriting the first three values by the desired
%values)
xu_sol(1:3) = x_start;

fprintf('Initial position solution:\n');
disp(xu_sol(1:3));
fprintf('Final position solution:\n');
disp(xu_sol(3*N-2:3*N));

%Starting simulation
fprintf('Press any key to start the simulation\n');
pause;
for n=1:N
    
    pause(dt);
    cla(ax);
    
    a_curr = xu_sol(3*(n-1)+1);
    b_curr = xu_sol(3*(n-1)+2);
    theta_curr = xu_sol(3*(n-1)+3);
    plotCar(a_curr, b_curr, theta_curr, car_size, ax);
%     pause;
%     plotObstaclesCircle(circular_obstacle_coords, ax);
end








