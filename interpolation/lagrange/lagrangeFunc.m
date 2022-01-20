function f = lagrangeFunc(x,y,n,xx)
%%lagrange polynomial interpolation using x,y set of data for xx target 
%%with the order of n this function interpolates the data set of 
%%x,y to find f(xx) using n first data
 
%% generating warning if n is bigger than length of x
if n > length(x)
    warning("n is bigger than the order of the Pn; n is subtuted by xcount")
    n = length(x);
end

%% creating the L coeffs
% L(i)(x) = π(j=1:n, j~=i)(x-x(j))/(x(i)-x(j))
l = zeros(1,n); %preallocating l
id = 1:n; % we need this index to exclude i == j collision without using another loop
for i = 1:n
    l(i) = prod((xx - x(id(id~=i))) ./ (x(i) - x(id(id ~= i))));
end

%% finally calculating f(xx)
% f(x) = ∑(i=1:n)f(i)l(i)
f = zeros(1, n);
% only using loop to show the steps of the way
for i = 2:n
    f(i) = sum(l(1:i) .* y(1:i));
end
f = f(end);
end