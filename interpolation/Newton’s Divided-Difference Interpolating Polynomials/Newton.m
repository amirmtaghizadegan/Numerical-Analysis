clear
close all
clc

x = [1 4 6 5]; %x set of data
y = [0 1.386294 1.791760 1.609438];%y set of data
xx = 2; %target x
n = length(x); %the order of newton solution
y = newtonFunc(x,y,xx,n); % newton's divided-dfiffernce interpolation to find y
fprintf("f(%3.2f) = %f \n\n", xx ,y)