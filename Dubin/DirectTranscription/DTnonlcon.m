%Non linear equality constraint for fmincon. This defines the dynamics of
%the system
function [c, ceq] = DTnonlcon(xu, v, dt)

%There are 4N-1 values in total.
N = (length(xu)+1)/4;

%equality constraints
ceq = zeros(3*(N-1), 1);

for i=1:N-1
    a_curr = xu(3*(i-1)+1);
    b_curr = xu(3*(i-1)+2);
    theta_curr = xu(3*(i-1)+3);
    a_next = xu(3*i+1);
    b_next = xu(3*i+2);
    theta_next = xu(3*i+3);
    u_curr = xu(3*N+i);
    
    ceq(3*(i-1)+1) = a_next - a_curr - v*cos(theta_curr)*dt;
    ceq(3*(i-1)+2) = b_next - b_curr - v*sin(theta_curr)*dt;
    ceq(3*(i-1)+3) = theta_next - theta_curr - u_curr*dt;
    
end

%There are no non-equality constraints
c = [];



