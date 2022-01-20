function s = simpson1_3rd(f, a, b)
h = (b-a) / 2;
s = h / 3 * (f(a) + 4 * f(a+h) + f(b));
end