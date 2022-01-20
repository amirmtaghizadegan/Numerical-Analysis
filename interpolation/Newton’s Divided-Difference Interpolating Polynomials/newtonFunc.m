function y = newtonFunc(x,y,xx,n)
%%Newton's divided-difference interpolation using x,y set of data for xx
%%target with the order of n this function interpolates the data set of 
%%x,y to find f(xx) using n first data

%% making f table
% first column is f(xi)
% second is f(xi+1, xi)
% third column is f(xi+2, xi+1, xi) using the following instruction
% :f(xi, xj) = (f(xi) - f(xj)) / (xi - xj)
% :f(xi+2, xi+1, xi) = (f(xi+2, xi+1) - f(xi+1, xi)) / (xi+2 - xi)
f = zeros(n);  % preallocating
f(:,1) = y;
for j = 2:n+1
    for i = 1:n-j+1
        f(i,j) = (f(i+1,j-1) - f(i, j-1))/(x(i+j-1) - x(i));
    end
end
%% figuring b
b = f(1,:);
%% finally calculating f(xx)
% calculating f(xx) using the following equation:
% f(xx) = f(x1) + f(x2, x1) * (x2 - x1) + f(xn, xn-1, ..., x2, x1)*
%(x-x(n-1)) * (x-x(n-2)) * ... * (x-x2)*(x-x1)
y = b(1);
for i = 2:n
    y = y + b(i) * prod(xx-x(1:i-1));
end
end