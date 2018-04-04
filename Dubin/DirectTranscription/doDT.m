function xu_sol = doDT(x_start, x_end, v, N, dt)

%Function that solves the optimization problem

%sol is a structure that contains the solution to the optimization problem
sol = {};

%Initial solution
xu_init = randn(4*N-1, 1);

%Objective and constraint functions
obj_fun = @(xu)DTobjective(xu);
nonlcon = @(xu)DTnonlcon(xu, v, dt);

%linear equality constraint matrices
Aeq = zeros(6, 4*N-1);
Beq = zeros(6, 1);
Aeq(1, 1) = 1;
Aeq(2, 2) = 1;
Aeq(3, 3) = 1;
Aeq(4, 3*N-2) = 1; 
Aeq(5, 3*N-1) = 1; 
Aeq(6, 3*N) = 1;
Beq = [x_start; x_end];

options = optimoptions('fmincon', 'MaxFunctionEvaluations', 10000);

xu_sol = fmincon(obj_fun, xu_init, [], [], Aeq, Beq, [], [], nonlcon, options);
