clear
close all
clc

f = @(x)(1./(1+x.^3));

a = 0;
b = 1;
m = 4;
s = romberg(f,a,b,m);
fprintf("int(%s), from %.2f to %.2f = %f\n",func2str(f), a, b, s)
