function X = gaussJordan(A, B)

id = 1:length(A);
for i = 1:length(A)
    B(i) = B(i)./ A(i,i);
    A(i,:) = A(i,:) ./ A(i,i);
    temp_id = id(id~=i);
    B(temp_id) = B(temp_id) - B(i) .* A(temp_id, i);
    A(temp_id, :) = A(temp_id, :) - A(i, :) .* A(temp_id, i);
end

X = B;
