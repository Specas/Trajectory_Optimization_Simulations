%Computes the objective to be minimized (for fmincon)
%In this case, it is basically the norm of the control inputs

%xu contains the states x for N points (3*N points) and control input 'u'
%for each point except the last (N-1 points)
function obj = BDTobjective(xalpha, beta, N)


%Computing the control inputs as a linear combination of the basis
obj = norm(beta.'*xalpha(3*N+1:end))^2;

