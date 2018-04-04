function xalpha_sol = doBDT(x_start, x_end, v, N, dt)

%Function that solves the optimization problem

%For the basis version of direct transcription, we only need to estimate
%'k' scalars that serve as the basis multipliers. We now define 'k' and the
%basis

%We only need to account for the N-1 inputs and not the entire state
k = 11;
beta = zeros(k, N-1);
beta(1, 1:end) = ones(1, N-1);
beta(2, 1) = 1;
beta(3, 2) = 1;
beta(4, 3) = 1; 
beta(5, 4) = 1;
beta(6, 5) = 1; 
beta(7, N-5) = 1; 
beta(8, N-4) = 1; 
beta(9, N-3) = 1; 
beta(10, N-2) = 1; 
beta(11, N-1) = 1; 

%Variables of the problem
alpha = zeros(k, 1);

%We also need configuration at each knot point as a variable
x_init = [linspace(x_start(1), x_end(1), N); linspace(x_start(2), x_end(2), N); linspace(x_start(3), x_end(3), N)];
x_init = reshape(x_init, [], 1);
xalpha_init = [x_init; alpha];


%Objective and constraint functions
obj_fun = @(xalpha)BDTobjective(xalpha, beta, N);
nonlcon = @(xalpha)BDTnonlcon(xalpha, beta, v, dt, N);

%linear equality constraint matrices
Aeq = zeros(6, 3*N+k);
Aeq(1, 1) = 1;
Aeq(2, 2) = 1;
Aeq(3, 3) = 1;
Aeq(4, 3*N-2) = 1; 
Aeq(5, 3*N-1) = 1; 
Aeq(6, 3*N) = 1;
beq = [x_start; x_end];

%As we do not have the control inputs directly in the problem variable, we
%cannot use the direct bounds. Instead we use the linear inequalities to
%set bounds on the control inputs
A= [zeros(N-1, 3*N), beta.'; zeros(N-1, 3*N), -beta.'];

%Setting limits on control inputs
u_lb_val = -0.01;
u_ub_val = 0.01;

lb = u_lb_val*ones(N-1, 1);
ub = u_ub_val*ones(N-1, 1);

b = [ub; -lb];

options = optimoptions('fmincon', 'MaxFunctionEvaluations', 20000);

xalpha_sol = fmincon(obj_fun, xalpha_init, A, b, Aeq, beq, [], [], nonlcon, options);

disp(beta.'*xalpha_sol(3*N+1:end));

