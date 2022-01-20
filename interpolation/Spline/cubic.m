function yy = cubic(x,y,xx)
h = diff(x);
for i=1:length(h)
    h(i) = x(i+1) - x(i);
end
a = y;
c = a;
b = zeros(1, length(x)-1);
d = b;
CA = zeros(length(c)); % c solving coeff: 
CB = zeros(length(CA), 1);
cdd = zeros(length(a));  % preallocating C divided difference
%% finding c
% first column of cdd is f(xi) and second one is the (f(xi+1, xi)):
% ((divided difference))

cdd(:,1) = y;
for i = 1:length(a)-1
    cdd(i, 2) = (cdd(i+1, 1) - cdd(i, 1))/(x(i+1) - x(i));
end
cdd = diff(cdd(:,2)); % we just need the f(xi+1, xi)
% now we create the following equations 
% h(i-1) * c(i-1) + 2 * (h(i-1) + h(i)) * c(i) + h(i) * c(i+1) = 3 * f(xi+1, xi)
for i = 2:length(CA)-1
    CA(i, i-1) = h(i-1);
    CA(i, i) = 2 * (h(i-1) + h(i));
    CA(i, i+1) = h(i);
    CB(i) = 3*cdd(i-1);
end
CA([1 end]) = 1;
c = CA\CB; c = transpose(c);
%% find b & d
for i = 1:length(c)-1
    b(i) = (y(i+1) - y(i)) / h(i) - h(i) / 3 * (2 * c(i) + c(i+1));
    d(i) = (c(i+1) - c(i)) / (3 * h(i));
end
%% 
c = c(1:end-1); % triming c to be as the same size of b & d
a = a(1:end-1); % triming a to be as the same size of b & d
s = a + b .* (xx - x(1:end-1)) + c .* (xx - x(1:end-1)) .^ 2 + ...
    d .* (xx - x(1:end-1)) .^ 3 ;
for i = 1:length(x)-1
    if xx >= x(i) && xx < x(i+1)
        yy = s(i);
    elseif xx == x(end)
        yy = y(end);
    end
end
end