clear
close all
clc

f = @(x)sin(x);

a = 0;
b = pi;
s = simpson1_3rd(f,a,b);
fprintf("int(%s), from %.2f to %.2f = %f\n",func2str(f), a, b, s)

s = simpson3_8th(f,a,b);
fprintf("int(%s), from %.2f to %.2f = %f\n",func2str(f), a, b, s)
