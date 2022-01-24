clear
close all
clc

dx = 0.1;
dy = 0.1;
dt = 0.2;

x = 0:dx:1;
y = 0:dy:1;
t = 0:dt:.2;

u = zeros(length(x), length(y), length(t));

%EQ: ∂u/∂t = ∂2u/∂x2 + ∂2u/∂y2
%IC: u(x, y, 0) = 0;
%BC1: u(0, y, t) = 1;
%BC2: u(1, y, t) = 1;
%BC3: u(x, 0, t) = 1;
%BC4: u(x, 1, t) = 1;

% Discreted EQ:
% u(i, j, n+1) = λx * u(i+1, j, n+1) + λx * u(i-1, j, n+1) +
% λy * u(i, j+1, n+1) + λy * u(i, j-1, n) +
% (- 2 * λx - 2 * λy) * u(i,j,n+1)
lamdaX = dt/dx^2;   % λx = dt/dx2
lamdaY = dt/dy^2;   % λy = dt/dy2

%% IC:
% because the value of u is already 0 at time 0, u(any, any, 1) = 0, we
% leave this field
% u(:, :, 1) = 0;
%% BC1:
u(1, :, :) = 0;
%% BC2:
u(end, :, :) = 1;
%% BC3:
u(:, 1, :) = 0;
%% BC4:
u(:, end, :) = 1;


% expansion factor
w = 1;


for n = 1:length(t)-1
    % Initial guess:
    U = u(:,:,n);
    % creating U2 for comparison
    U2 = U; %preallocating U2
    err = 1; %initiating error
    k = 0; %error counter
    while err > 0.01
        for i = 2:length(x)-1
            for j = 2:length(y)-1
                %EQ:
                U2(i, j) = lamdaX / (1 + 2 * lamdaX + 2 * lamdaY) * (U(i+1, j) + U(i-1, j)) + ...
                    lamdaY / (1 + 2 * lamdaX + 2 * lamdaY) * (U(i, j+1) + U(i, j-1)) + ...
                    (1 + 2 * lamdaX + 2 * lamdaY) * u(i, j, n);
            end
        end
        U2 = (1 - w) * U + w * U2; 
        err = max(max(abs(U2-U)./abs(U2)));
        U = U2;
        k = k + 1;
    end
    u(:, :, n+1) = U;
    contourf(x, y, u(:, :, n+1))
    colorbar
    pause(0.05)
end

hold off
figure
[X, Y] = meshgrid(x, y);
surf(X, Y, u(:, :, end))
colorbar

