clc
clear

addpath('../Tools');

xlim = [-100, 100];
ylim = [-100, 100];
xstart = 0;
ystart = -50;
obstacle_coords{1} = [0, 0, 15];

[fig, ax] = initializeFigure2D('Dubin', 'GridOn', xlim, ylim);
plotObstaclesCircle(obstacle_coords, ax);

h = plotCar(xstart, ystart, 0, 5, ax);