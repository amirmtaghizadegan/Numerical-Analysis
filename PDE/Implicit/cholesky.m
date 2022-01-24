function X = cholesky(A, B)

L = zeros(size(A));
U = eye(size(A));

L(:, 1) = A(:, 1);
U(1, :) = A(1, :) / A(1);
for i = 2:length(A)
    for j = 2:length(A)
        if i>=j
            L(i, j) = A(i, j) - L(i, 1:j-1) * U(1:j-1, j);
        end

        if j > i
            U(i, j) = (A(i, j) - L(i, 1:i-1) * U(1:i-1, j)) / L(i, i);
        end
    end
end

d = zeros(length(B), 1);
X = d;
d(1) = B(1) / L(1);
for i = 2:length(d)
    d(i) = (B(i) - L(i, 1:i-1) * d(1:i-1)) / L(i, i);
end

X(end) = d(end);
for j = length(d)-1:-1:1
    X(j) = d(j) - U(j, j+1:end) * X(j+1:end);
end