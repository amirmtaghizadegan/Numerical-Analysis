clear
close all
clc
%this code uses orthogonal collocation method to calculate an second order ODE BVP with Neumann-Robbins BV 
%constants
k=2;
N=17;a=2;b=0.5;
pei =[1 10 100 1000];
hold on
%boundry conditions
y0=1;yend=0;
%evaluating x with jacobi method
gamma=ones(1,N+1);jac=ones(1,N+1);
for iii=1:4 
pe=pei(iii);
for i=2:N+2
    if i<=N+1
    gamma(i)=(N-(i-1)+1)/(i-1)*(N+a+b+(i-1))/((i-1)+b)*gamma(i-1);
    end
    jac(i-1)=(-1)^(N-(i-1)).*gamma(i-1);
end
x=zeros(1,N+2);x(end)=1;
x(2:N+1)=fliplr(roots(fliplr(jac))');
l=zeros(N+2,length(x));dl=l;d2l=l;
ll=zeros(N+2);
dll=zeros(N+2);
d2ll=zeros(N+2);
%legendre polynomial making
for i=1:length(x)
    lj=1;
    for j=1:N+2
        if i~=j
            lj=conv(lj,[1/(x(i)-x(j)),-x(j)/(x(i)-x(j))]);
        end
    end
    %ll, dll and d2ll is legandre,dl/dx and d2l/dx2 evaluated for all xs
    %respectively
    l(i,(length(l)-length(lj)+1):end)=lj;
    ll(i,:)=polyval(l(i,:),x);
    dl(i,(length(l)-length(polyder(l(i,:)))+1):end)=polyder(l(i,:));
    dll(i,:)=polyval(dl(i,:),x);
    d2l(i,(length(l)-length(polyder(dl(i,:)))+1):end)=polyder(dl(i,:));
    d2ll(i,:)=polyval(d2l(i,:),x);
end
%creating constant matrix
A=1/pe*d2ll'-dll'-k*ll;
%%%%eliminating non-residue equations
A([1,end],:)=[];
%%%%
A(N+1,:)=1/pe*(dll(:,1)'-ll(:,1)');
A(N+2,:)=dll(:,end)';
%creating answaer matrix;
B=zeros(N+2,1);
B(N+1)=y0;
B(N+2)=yend;
y=A\B;
fprintf('for pe= %d y= \n',pe)
disp(y)
plot(x,y,'o --')
end
axis([0 1 -350 10])