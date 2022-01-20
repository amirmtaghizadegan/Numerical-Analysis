clear
close all
clc

x = [3 4.5 7 9];
y = [2.5 1 2.5 .5];
xx = 5; %target x
methods = ["linear", "quadratic", "cubic"];
for method = methods
    yy = nspline(x,y,xx, method);
    hold on
    fprintf("using %s method on x and y data set,\n" + ...
        "y for targeted x is equal to: %3.2f\n", method, yy);
end
f = get(gca, "children");
legend(f(1:3:end))
legend("FontWeight","bold")













