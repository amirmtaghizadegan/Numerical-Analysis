clear
close all
clc

dx = 0.1;
dt = 0.0025;

x = 0:dx:1;
t = 0:dt:.2;

u = zeros(length(t), length(x));
alpha = 0.5;

%EQ: ∂u/∂t = ⍺ * ∂2u/∂x2
%IC: u(x, 0) = 0;
%BC1: u(0, t) = 1;
%BC2: u(1, t) = 1;

% Discreted EQ:
% u(i, n+1) = λ * u(i+1, n) + λ * u(i-1, n) + 
% (1 - 2 * λ) * u(i, n)
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
    U = u(n, :); % initial guess
    U2 = U; % temporary U for comparison
    err = 1;k = 0; %iterator counter
    while err > 0.01
    for i = 2:length(x)-1
            %EQ:
            dudt = 1/dx^2 * (U(i+1) - 2 * U(i) + U(i-1));
            U2(i) = U(i) + dudt * dt;
    end
    k = k + 1;
    err = max(abs((U2-U)./U2));
    U = U2;
    end
    u(n+1, :) = U;
    plot(x, u(n+1, :))
end
disp("at t = "+ t(end) + " with time step of " + dt + " ,[x u] will be")
disp([x' u(end, :)'])
