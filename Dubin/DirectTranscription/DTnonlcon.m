%Non linear equality constraint for fmincon. This defines the dynamics of
%the system
function [c, ceq] = DTnonlcon(xu, v, dt)

%There are 4N-1 values in total.
N = (length(xu)+1)/4;

%equality constraints
ceq = zeros(3*(N-1), 1);

%Storing cumulative sums to propagate the dynamics through all N time steps
a_cum = 0;
b_cum = 0;
theta_cum = 0;

a_init = xu(1);
b_init = xu(2);
theta_init = xu(3);

for i=1:N-1
    a_curr = xu(3*(i-1)+1);
    b_curr = xu(3*(i-1)+2);
    theta_curr = xu(3*(i-1)+3);
    a_next = xu(3*i+1);
    b_next = xu(3*i+2);
    theta_next = xu(3*i+3);
    u_curr = xu(3*N+i);
    
    a_cum = a_cum + v*cos(theta_init + theta_cum)*dt;
    b_cum = b_cum + v*sin(theta_init + theta_cum)*dt;
    theta_cum = theta_cum + u_curr*dt;
    
    ceq(3*(i-1)+1) = a_next - a_init - a_cum;
    ceq(3*(i-1)+2) = b_next - b_init - b_cum;
    ceq(3*(i-1)+3) = theta_next - theta_init - theta_cum;
    
end

%There are no non-equality constraints
c = [];



