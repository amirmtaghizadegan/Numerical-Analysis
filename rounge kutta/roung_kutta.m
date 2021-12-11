function x2=roung_kuttax(n,h)
f=@(t,x,v)[v;-4*x];
v2=zeros(1,n);x2=zeros(1,n);u=zeros(2,n);
x2(1)=2; v2(1)=0;
t=0:h:n*h;
for i=1:n
    k12=f(t(i),x2(i),v2(i));
    k22=f(t(i)+h,x2(i)+k12(1).*h,v2(i)+k12(2)*h);
    u(:,i)=[x2(i);v2(i)];
    u(:,i+1)=u(:,i)+0.5*h.*(k12+k22);
    x2(i+1)=u(1,i+1);
    v2(i+1)=u(2,i+1);
end



