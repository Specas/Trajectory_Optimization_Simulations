%Computes the objective to be minimized (for fmincon)
%In this case, it is basically the norm of the control inputs

%xu contains the states x for N points (3*N points) and control input 'u'
%for each point except the last (N-1 points)
function obj = DTobjective(xu)

%There are 4N-1 values in total.
N = (length(xu)+1)/4;

obj = norm(xu(3*N+1:end))^2;

%Taking care of variance between consecutive control input solutions
% for i=1:N-2
%     u_curr = xu(3*N+i);
%     u_next = xu(3*N+i+1);
%     obj = obj + (u_next - u_curr)^2;
% end