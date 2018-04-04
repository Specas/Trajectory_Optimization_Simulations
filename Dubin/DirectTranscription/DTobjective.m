%Computes the objective to be minimized (for fmincon)
%In this case, it is basically the norm of the control inputs

%xu contains the states x for N points (3*N points) and control input 'u'
%for each point except the last (N-1 points)
function obj = DTobjective(xu)

%There are 4N-1 values in total.
N = (length(xu)+1)/4;

obj = norm(xu(3*N+1:end))^2;

% obj = 0;
% for i=1: