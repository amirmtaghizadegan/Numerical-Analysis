clc
clear
close all
pe =1;
u0 = 1;
uf = 0;
N = 20;
% N = input('please enter the number of intepolation points:');
alpha = 2;
beta = 1/2;
% claculation of jacobi polynomials coefficietns;
Gamma(1) = ((N-1+1)./1).*(N+1+alpha+beta)/(1+beta);
for i=2:N
    Gamma(i) = ((N-i+1)./i).*(N+i+alpha+beta)/(i+beta).*Gamma(i-1);
end
for i=1:N
    Jacobi_coef(i) = (-1)^(N-i)*Gamma(i);
end
Gamma = [1 Gamma];
Jacobi_coef = [(-1)^(N) Jacobi_coef];
Jacobi_coef = fliplr(Jacobi_coef);
Roots = roots(Jacobi_coef);
inter_points = [u0;Roots;uf];

for i=1:length(inter_points)
    p=1;
    for j=1:length(inter_points)
        if j~=i
            c = poly(inter_points(j))/(inter_points(i)-inter_points(j));
            p = conv(p,c);
        end
    end
    Lagrange(i,:) = p;
end
% residual
for j=1:length(inter_points)
    d2(j,:) = polyder(polyder(Lagrange(j,:)));
    a = padarray(d2(j,:),[0 2],0,'pre');
    d(j,:) = polyder(Lagrange(j,:));
    b = padarray(d(j,:),[0 1],0,'pre');
    R(j,:) = a./pe-b-2.*Lagrange(j,:);
end
for k=1:length(Roots)
    j = 2;
    for i=1:length(Roots)
        lag_R(k,i) = polyval(R(j,:),Roots(k));
        j = j+1;
    end
end

A = lag_R;
for i=1:length(Roots)
    C(i,1) = -1*polyval(R(1,:),Roots(i));
end
y1 =A\C;
y_app = [1;y1;0];
inter_points = sort(inter_points);
plot(inter_points,y_app)
title('approximate solution')



