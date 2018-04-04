function xu_sol = doDT(x_start, x_end, v, N, dt)

%Function that solves the optimization problem

%Getting a good estimate of the initial trajectory (Which is good for
%optimization)
x_init = [linspace(x_start(1), x_end(1), N); linspace(x_start(2), x_end(2), N); linspace(x_start(3), x_end(3), N)];
u_init = zeros(N-1, 1);
xu_init = [reshape(x_init, [], 1); u_init];


%Objective and constraint functions
obj_fun = @(xu)DTobjective(xu);
nonlcon = @(xu)DTnonlcon(xu, v, dt);

%linear equality constraint matrices
Aeq = zeros(6, 4*N-1);
Aeq(1, 1) = 1;
Aeq(2, 2) = 1;
Aeq(3, 3) = 1;
Aeq(4, 3*N-2) = 1; 
Aeq(5, 3*N-1) = 1; 
Aeq(6, 3*N) = 1;
beq = [x_start; x_end];


%Setting limits on control inputs
lb = -inf(4*N-1, 1);
ub = inf(4*N-1, 1);

u_lb_val = -0.01;
u_ub_val = 0.01;
for i=1:N-1
    lb(3*N+i) = u_lb_val;
    ub(3*N+i) = u_ub_val;
end

options = optimoptions('fmincon', 'MaxFunctionEvaluations', 20000);

xu_sol = fmincon(obj_fun, xu_init, [], [], Aeq, beq, lb, ub, nonlcon, options);
