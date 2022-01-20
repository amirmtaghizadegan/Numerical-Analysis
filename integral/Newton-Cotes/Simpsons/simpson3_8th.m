function s = simpson3_8th(f, a, b)
h = (b - a) / 3;
x = a:h:b;
s = 3 * h / 8 * (f(x(1)) + 3 * f(x(2)) + 3 * f(x(3)) + f(x(4)));
end