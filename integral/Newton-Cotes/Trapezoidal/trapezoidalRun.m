clear
close all
clc

f = @(x)sin(x);

a = 0;
b = pi;
s = trapezoidal(f,a,b);
fprintf("int(%s), from %.2f to %.2f = %f\n",func2str(f), a, b, s)

n = 8;
s = multiTrapz(f,a,b,n);
fprintf("int(%s), %.2f:%.2f, with %d segments = %f\n",func2str(f), a, b, n, s)

