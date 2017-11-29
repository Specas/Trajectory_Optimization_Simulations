%Function to plot circular obstacles
function [] = plotObstaclesCircle(circular_obstacles_struct, ax)

for i=1:length(circular_obstacles_struct)
    obs = circular_obstacles_struct{i};
    rectangle(ax, 'Position', [obs(1) - obs(3), obs(2) - obs(3), 2*obs(3), 2*obs(3)], 'Curvature', [1, 1], 'FaceColor', 'b');
end

