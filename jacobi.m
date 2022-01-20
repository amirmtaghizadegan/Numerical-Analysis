clear
close all
clc
% example
## b=[7.85 -19.3 71.4];
## a=[3 -.1 -.2;.1 7 -.3;.3 -.2 10];
b=input('please enter b as a matrix: ');
a=input('please enter a as a matrix: ');
x=zeros(1,length(a));
error=1;
for i=1:size(x,2)
    xx=x(1,:);
    xx(1,i)=0;
    x(2,i)=(b(i)-sum(a(i,:).*xx))/a(i,i);
end
j=3;
while error>eps
    for i=1:size(x,2)
        xx=x(j-1,:);
        xx(1,i)=0;
        x(j,i)=(b(i)-sum(a(i,:).*xx))/a(i,i);
    end
    error=abs(sum(abs(x(j,:)))-sum(abs(x(j-1,:))));
    j=j+1;
end
fprintf('x%d= %4.4f \n',[1:size(x,2);x(end,:)])