function yy = quadratic(x,y,xx)
h = diff(x);
for i=1:length(h)
    h(i) = x(i+1) - x(i);
end
a = y(1:end-1);
A = zeros((length(x)-1) * 2);
B = zeros(1, size(a,1));
ii = 0; %equation counter
%% fi + bi * hi + ci * hi^2 = fi+1
% for i = 1:n-1
for i = 1:length(x)-1
    ii = ii + 1;
    A(ii, i*2-1) = h(i);
    A(ii, i*2) = h(i) ^ 2;
    B(ii) = y(i+1) - y(i);
end
%% bi + 2 * ci * hi = bi+1
% the s' at interior nodes are equal
for i = 1:length(x)-2
    ii = ii + 1;
    A(ii, i*2-1) = 1;
    A(ii, (i+1)*2-1) = -1;
    A(ii, i*2) = 2 * h(i);
    B(ii) = 0;
end
%% c1 = 0
% s'' at first point equals to zero
ii = ii + 1;
A(ii, 2) = 1;
B(ii) = 0;
X=A\B';
X = reshape(X, [2 size(A,1)/2]);
b = X(1,:);
c = X(2,:);
s = a + b .* (xx - x(1:end-1)) + c .* (xx - x(1:end-1)) .^ 2;
for i = 1:length(x)-1
    if xx >= x(i) && xx < x(i+1)
        yy = s(i);
    elseif xx == x(end)
        yy = y(end);
    end
end
end