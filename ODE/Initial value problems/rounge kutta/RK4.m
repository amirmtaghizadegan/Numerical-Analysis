function y2=RK4(x,y,h)
k1 = f1(x,y);
k2 = f1(x + 0.5 * h, y + 0.5 * k1 * h);
k3 = f1(x + 0.5 * h, y + 0.5 * k2 * h);
k4 = f1(x + h, y + k3 * h);
y2 = y + 1 / 6 * (k1 + 2 * k2+ 2 * k3 + k4) * h;
end

