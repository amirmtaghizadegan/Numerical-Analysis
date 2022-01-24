clear
close all
clc

dx = 0.1;
dy = 0.1;
dt = 0.02;

x = 0:dx:1;
y = 0:dy:1;
t = 0:dt:0.2;

u = zeros(length(x), length(y), length(t));

%EQ: ∂u/∂t = ∂2u/∂x2 + ∂2u/∂y2
%IC: u(x, y, 0) = 0;
%BC1: u(0, y, t) = 0;
%BC2: u(1, y, t) = 1;
%BC3: u(x, 0, t) = 0;
%BC4: u(x, 1, t) = 1;

% Discreted EQ:
% u(i, j, n) = -(λx * u(i+1, j, n+1) + λx * u(i-1, j, n+1) +
% λy * u(i, j+1, n+1) + λy * u(i, j-1, n+1) +
% (1 - 2 * λx - 2 * λy) * u(i,j,n+1))
lamdaX = dt/dx^2;   % λx = dt/dx2
lamdaY = dt/dy^2;   % λy = dt/dy2

%% IC:
% u(any, any, 1) = 0
u(:, :, 1) = 0;

%% id making
% since AU = B, U is a column vector we need to reshape U and it's
% index to a vector but we need this id vector to bring them back
id = reshape(1:numel(u(:,:, 1)), length(x), length(y));
%%
for n = 1:length(t)-1
    A = zeros(length(x) * length(y));
    B = zeros(length(x) * length(y), 1);
    for i = 1:length(x)
        for j = 1:length(y)
            if i == 1 %BC1
                A(id(i, j), id(i, j)) = 1;
                B(id(i, j)) = 0;
            elseif i == length(x)   %BC2
                A(id(i, j), id(i, j)) = 1;
                B(id(i, j)) = 1;
            elseif j == 1 %BC3
                if i > 1 && i < length(x)
                    A(id(i, j), id(i, j)) = 1;
                    B(id(i, j)) = 0;
                end
            elseif j == length(y) %BC4
                if i > 1 && i < length(x)
                    A(id(i, j), id(i, j)) = 1;
                    B(id(i, j)) = 1;
                end
            else
                %% Discreted EQ.
                % u(i, j, n) = λx * u(i+1, j, n+1) + λx * u(i-1, j, n+1) +
                % λy * u(i, j+1, n+1) + λy * u(i, j-1, n+1) +
                % (1 - 2 * λx - 2 * λy) * u(i,j,n+1)
                A(id(i, j), [id(i+1, j) id(i-1, j)]) = -0.5*lamdaX;
                A(id(i, j), [id(i, j+1) id(i, j-1)]) = -0.5*lamdaY;
                A(id(i, j), id(i, j)) = 1 + lamdaX + lamdaY;
                B(id(i, j)) = u(i, j, n) + ...
                    0.5 * lamdaX * (u(i+1, j, n) + u(i-1, j, n)) + ...
                    0.5 * lamdaY * (u(i, j+1, n) + u(i, j-1, n)) + ...
                    (-lamdaX - lamdaY) * u(i, j, n);
            end
        end
    end
    U = A\B;
    U = reshape(U, length(x), length(y));
    u(:, :, n+1) = U;
    contourf(x, y, u(:, :, n+1))
    colorbar
    pause(0.1)
end


figure
[X, Y] = meshgrid(x, y);
surf(X, Y, u(:, :, end))
colorbar

