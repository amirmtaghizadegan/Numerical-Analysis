clear
close all
clc

h = 0.2; 
x = 0:h:1;
y = x;
y(1) = 1;
y(2) = RK4(x(1), y(1), h);
for i = 2:length(x)-1
    y(i+1) = y(i) + h / 2 * (3 * f1(x(i), y(i)) - f1(x(i-1), y(i-1)));
end
disp(y)

