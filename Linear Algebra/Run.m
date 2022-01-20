clear
close all
clc

a = [3, -1,  2;
     1,  5,  3;
     2, -2, 11];
b = transpose([12 11 2]);
gaussSeidel(a,b)