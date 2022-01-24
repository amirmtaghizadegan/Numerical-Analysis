clear
close all
clc
% Solving equation:
% y'' + y = x^2
% IC: y(0) = 0
% BC: y(1) = 0.4
% dx = h = 0.2;
dx = 0.2;
x = 0:dx:1;



%% A * X = B
% X = [y1 y2 y3 y4 y5 y6]

% preallocating A & B
A = zeros(length(x)); 
B = A(:,1);

% Initial Condition
% y(0) = 0

A(1) = 1;
B(1) = 0;

% Boundry Condition
% y(1) = 0.4 

A(end) = 1;
B(end) = -0.4;

% rest of the equations
% y(i+1) + (-2 + dx^2) * y(i) + y(i-1) = x(i) * dx^2
% i = 2,3,4,5

for i = 2:length(x)-1
    A(i, [i+1 i i-1]) = [1 (-2 + dx^2) 1];
    B(i) = x(i) * dx^2;
end

y = A\B;

disp("[x, y] = ")
disp([x', y])
% plot(x, y)