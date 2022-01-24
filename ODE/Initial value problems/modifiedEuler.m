clear
close all
clc

h = 0.2; 
x = 0:h:1;
y = x;
y(1) = 1;
for i = 1:length(x)-1
    y(i+1) = euler(x(i), y(i), h);
    y(i+1) = mEuler(y(i), y(i+1), h);
end
disp(y)

function f=fun(x,y)
f = y + x .^ 2;
end

function yy=euler(x, y, h)
yy = y + fun(x, y) * h;
end

function y = mEuler(y, yy, h)
y = y + h / 2 * (y + yy);
end