clear
close all
clc

h = 0.2; 
x = 0:h:1;
y = x;
y(1) = 1;
y(2) = RK4(x(1), y(1), h);
y(3) = RK4(x(2), y(2), h);
for i = 3:length(x)-1
    y(i+1) = y(i) + h / 12 * (23 * f1(x(i), y(i)) - 16 * f1(x(i-1), y(i-1)) + ...
        5 * f1(x(i-2), y(i-2)));
end
disp(y)

