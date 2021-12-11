function x=gauss_elimination(a,b)
a=[a b'];
n=size(a,1);x=zeros(1,n);
for m=2:n
    for i=1:m-1
        a(m,:)=a(m,:)-a(m,i)/a(i,i)*a(i,:);
    end
end
b=a(:,end);a(:,end)=[];
for i=n:-1:1
aa=a(i,:);
x(i)=(b(i)-sum(aa.*x))/aa(i);
end
end