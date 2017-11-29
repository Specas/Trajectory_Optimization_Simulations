addpath('../Tools');

xlim = [-100, 100];
ylim = [-100, 100];
xstart = 0;
ystart = -50;

[fig, ax] = initializeFigure2D('Dubin', 'GridOn', xlim, ylim);

h = plotCar(xstart, ystart, 0, 5, ax);