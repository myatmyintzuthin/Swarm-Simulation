% Multi-variate vector-valued function G(x)
G = @(x) [
    3*x(1) - cos(x(2)*x(3)) - 3/2           ;
    4*x(1)^2 - 625*x(2)^2 + 2*x(2) - 1      ;
    exp(-x(1)*x(2)) + 20*x(3) + (10*pi-3)/3];

% Jacobian of G
JG = @(x) [
    3,                     sin(x(2)*x(3))*x(3),   sin(x(2)*x(3))*x(2) ;
    8*x(1),                -1250*x(2)+2,          0                   ;
    -x(2)*exp(-x(1)*x(2)), -x(1)*exp(-x(1)*x(2)), 20                 ];

% Objective function F(x) to minimize in order to solve G(x)=0
F = @(x) 0.5 * sum(G(x).^2);

% Gradient of F (partial derivatives)
dF = @(x) JG(x).' * G(x);

% Parameters
GAMMA = 0.001;    % step size (learning rate)
MAX_ITER = 1000;  % maximum number of iterations
FUNC_TOL = 0.1;   % termination tolerance for F(x)

fvals = [];       % store F(x) values across iterations
progress = @(iter,x) fprintf('iter = %3d: x = %-32s, F(x) = %f\n', ...
    iter, mat2str(x,6), F(x));

% Iterate
iter = 1;         % iterations counter
x = [0; 0; 0];    % initial guess
fvals(iter) = F(x);
progress(iter, x);
while iter < MAX_ITER && fvals(end) > FUNC_TOL
    iter = iter + 1;
    x = x - GAMMA * dF(x);  % gradient descent
    fvals(iter) = F(x);     % evaluate objective function
    progress(iter, x);      % show progress
end

% Plot
plot(1:iter, fvals, 'LineWidth',2); grid on;
title('Objective Function'); xlabel('Iteration'); ylabel('F(x)');

% Evaluate final solution of system of equations G(x)=0
disp('G(x) = '); disp(G(x))

% Output:
%
% iter =   1: x = [0;0;0]                         , F(x) = 58.456136
% iter =   2: x = [0.0075;0.002;-0.20944]         , F(x) = 23.306394
% iter =   3: x = [0.015005;0.0015482;-0.335103]  , F(x) = 10.617030
% ...
% iter = 187: x = [0.683335;0.0388258;-0.52231]   , F(x) = 0.101161
% iter = 188: x = [0.684666;0.0389831;-0.522302]  , F(x) = 0.099372
%
% (converged in 188 iterations after exceeding termination tolerance for F(x))