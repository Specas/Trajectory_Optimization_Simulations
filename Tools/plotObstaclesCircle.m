%Function to plot circular obstacles
function [] = plotObstaclesCircle(obstacles_struct, ax)

for i=1:length(obstacles_struct)
    obs = obstacles_struct{i};
    rectangle(ax, 'Position', [obs(1) - obs(3), obs(2) - obs(3), 2*obs(3), 2*obs(3)], 'Curvature', [1, 1], 'FaceColor', 'b');
end

