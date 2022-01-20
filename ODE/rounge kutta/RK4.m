function y2=RK4(x,y,h)
load all 'classical form.mat'
k1=f1(x,y);
k2=f1(x+a2*h,y+b21*h*k1);
k3=f1(x+a3*h,y+b31*h*k1+b32*h*k2);
k4=f1(x+a4*h,y+b41*h*k1+b42*h*k2+b43*h*k3);
y2=y+h*(k1*w1+w2*k2+w3*k3+w4*k4);
end

