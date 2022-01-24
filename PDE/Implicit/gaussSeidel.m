function X = gaussSeidel(A, B)
% This function is used to solve system of linear equations
% Where the system of equations can be written as AX = B
% where A is a nxn matrix, B is a nx1 matrix

%% Jacobi Condition
% for each row
% |a(i,i)| >= ∑|a(i,j)| j~=i
for i=1:length(A)
    if abs(A(i,i)) < (abs(sum(A(i,:)))-abs(A(i,i)))
        error("Gauss Seidel method is not applicable")
    end
end
%%

%% jacobi calculation
err = 1; % relative error
X = zeros(length(A), 1); % initial guess
X2 = X; %preallocating X2 to compare with X (compute relative error)
a = sum(A .* eye(length(A))); %A(i,i) coeffs
B = B./a'; % B / A(i,i) for each row
A = (A-(A.*eye(length(A))))./a'; % A / A(i,i) for each row + removing diameter
while err > 0.001
    X2(1) = B(1) - A(1,:) * X2;
    for i = 1:length(A)
        X2(i) = B(i) - A(i,:) * X2; % using calculated X in our calculation
    end
    err = abs(X2(1)-X(1))/abs(X2(1));
    for i = 2:length(X)
        err2 = abs(X2(i)-X(i))/abs(X2(i)); % relative error
        if err2 > err
            err = err2;
        end
    end
    X = X2;
end
%%
end