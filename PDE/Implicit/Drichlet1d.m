clear
close all
clc

dx = 0.1;
dt = 0.05;

x = 0:dx:1;
t = 0:dt:.2;

u = zeros(length(t), length(x));
alpha = 0.5;

%EQ: ∂u/∂t = ⍺ * ∂2u/∂x2
%IC: u(x, 0) = 0;
%BC1: u(0, t) = 1;
%BC2: u(1, t) = 1;

% Discreted EQ:
% u(i, n) = -λ * u(i+1, n+1) - λ * u(i-1, n+1) + 
% (1 + 2 * λ) * u(i, n+1)
lamda = alpha * dt/dx^2;   % λ = ⍺ * dt/dx2

%% IC:
% because the value of u is already 0 at time 0, u(any, any, 1) = 0, we
% leave this field
% u(1, :) = 0;
%% BC1:
u(:, 1) = 1;
%% BC2:
u(:, end) = 1;

hold on
for n = 1:length(t)-1
    A = zeros(length(x));
    B = A(:, 1);
    for i = 2:length(x)-1
            %EQ:
            A(i, [i-1 i i+1]) = [-lamda 1+2*lamda -lamda];
            B(i) = u(n, i);
    end
    % BC1: u(0,t) = 1 -> u(n+1, 1) = 1;
    A(1) = 1;
    B(1) = 1;
    % BC2: u(1,t) = 1 -> u(n+1, end) = 1;
    A(end) = 1;
    B(end) = 1;
    u(n+1, :) = cholesky(A, B);
    plot(x, u(n+1, :))
end
disp("at t = "+ t(end) + " with time step of " + dt + " ,[x u] will be")
disp([x' u(end, :)'])
