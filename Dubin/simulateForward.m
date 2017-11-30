%Simulate forward by one step
function [q_traj] = simulateForward(q_traj, u_traj, V, delta_t)

for i=2:size(q_traj, 2)
    f = [V*cos(q_traj(3, i-1)); V*sin(q_traj(3, i-1)); u_traj(i-1)];
    q_traj(:, i) = q_traj(:, i-1) + f*delta_t;
    
end



