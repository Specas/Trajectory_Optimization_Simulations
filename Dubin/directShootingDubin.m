%Function to execute direct shooting on the Dubin car model
%Inputs the initial state and random inputs which it then uses to find the
%optimal inputs and resulting states
function [q_traj, u_traj, lambda] = directShootingDubin(q_start, q_end, u_traj, V, delta_t, eta)

N = size(u_traj, 2);
q_traj = zeros(3, N + 1);
q_traj(:, 1) = q_start;

%Parameters for instantaneous cost
Q = [2, 0, 0; 0, 2, 0; 0, 0, 0];
R = 1;

lambda = zeros(3, N);

for i=1:500

    q_traj = simulateForward(q_traj, u_traj, V, delta_t);
    lambda = computeLambda(Q, q_traj, u_traj, V, lambda);
    u_traj = updateU(R, u_traj, lambda, eta);
end













