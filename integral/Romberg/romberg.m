function s = romberg(f, a, b, m)

I = zeros(m);
for i = 1:m
    I(i, 1) = multiTrapz(f,a,b,2^(i-1));
end

for j = 2:m
    for i = j:m
        I(i, j) = (4^(j-1) * I(i, j-1) - I(i-1, j-1)) / (4^(j-1)-1);
    end
end

s = I(end);
end