function X = cramer(A,B)

detA=det(A);
X=zeros(1,length(A));
for i=1:length(A)
b=A;
b(:,i)=B;
detB=det(b);
X(i)=detB/detA;
end