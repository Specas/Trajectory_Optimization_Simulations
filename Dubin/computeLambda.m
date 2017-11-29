function [lambda] = computeLambda(Q, q_traj, u_traj, V, lambda)

N = size(u_traj, 2);

for i=N-1:-1:1
    theta = q_traj(3, i+1);
    lambda(:, i) = 2*Q'*q_traj(:, i+1) + [0, 0, -V*sin(theta); 0, 0, V*cos(theta); 0, 0, 0]*lambda(:, i+1);
end
