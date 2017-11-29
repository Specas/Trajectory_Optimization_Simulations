function u_traj = updateU(R, u_traj, lambda, eta)

N = size(u_traj, 2);
for i=1:N
    grad = 2*R*u_traj(i) + lambda(:, i)'*[0; 0; 1];
    u_traj(i) = u_traj(i) - eta*grad;
end