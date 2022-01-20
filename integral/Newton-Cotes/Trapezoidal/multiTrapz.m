function s = multiTrapz(f, a, b, n)

h = (b-a)/n;
x = a:h:b;

s = h / 2 * (f(x(1)) + 2 * sum(f(x(2:end-1))) + f(x(end)));
end