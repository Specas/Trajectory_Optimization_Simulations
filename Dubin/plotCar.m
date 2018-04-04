%Function to plot the car given parameters
function [h] = plotCar(x, y, theta, c, ax)

%Holding on as we plot multiple objects
hold on;

%Modelled as an equilateral triangle with distance from vertex to centroid
%equal to c

%Theta is in radians

x1 = x + c*sin(theta);
y1 = y + c*cos(theta);

x2 = x - c*sin(theta + pi/3);
y2 = y - c*cos(theta + pi/3);

x3 = 3*x - x1 - x2;
y3 = 3*y - y1 - y2;

%Plotting
h = patch(ax, [x1, x2, x3], [y1, y2, y3], 'r');

%Indicator for the front of the car
in = plot(ax, x1, y1, 'b.', 'MarkerSize', 10);




