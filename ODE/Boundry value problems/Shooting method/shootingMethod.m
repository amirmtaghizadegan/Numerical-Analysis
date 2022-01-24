clear
close all
clc

Z = [1 10]; % first 2 initial guesses
% Z is a vector to store Z(0) through program
h = 0.01; %step
Y = Z; %preallocating Y (a vector to store y evaluated for each z)
bc = 200; % the Initial condition of the ODE
err = 1;ii=1; %loop initiation
while err > 1e-6 %finishing condition
    x = 0:h:10; %;the x vector for the problem
    y = 40; % The Initial Condition of the ODE
    yy = x;
    yy(1) = y;
    z = Z(ii); % getting the Z(0) from Z
    for i = 1:length(x)-1
        k1 = f1(x(i), y, z);
        k2 = f1(x(i) + 0.5 * h, y + 0.5 * k1 * h, z);
        k3 = f1(x(i) + 0.5 * h, y + 0.5 * k2 * h, z);
        k4 = f1(x(i) + h, y + k3 * h, z);
        y2 = y + (1 / 6) * (k1 + 2 * k2 + 2 * k3 + k4) * h;

        k1 = f2(x(i), y);
        k2 = f2(x(i) + 0.5 * h, y + 0.5 * k1 * h);
        k3 = f2(x(i) + 0.5 * h, y + 0.5 * k2 * h);
        k4 = f2(x(i) + h, y + k3 * h);
        z = z + 1 / 6 * (k1 + 2 * k2 + 2 * k3 + k4) * h;
        y = y2;
        yy(i+1) = y;
    end
    Y(ii) = y;
    err = abs(y - bc);
    if ii == length(Z)
        newZ = Z(ii-1) + (Z(ii)-Z(ii-1))/(Y(ii)-Y(ii-1))*(bc-Y(ii-1));
        Z(ii+1) = newZ;
    end
    ii = ii + 1;
end
Z(end) = [];
fprintf("the calculated y for z = %.2f = %.6f\n",[Z; Y])


function y = f1(x,y,z)
y = z;
end

function dzdx = f2(x,y)
h = 5e-8;
Ta = 20;
dzdx = h * (y - Ta)^4;
end


