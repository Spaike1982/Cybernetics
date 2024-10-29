function y = piecerampefunksjon(B,x,v)
n = length(x);
y = zeros(n,1);
for i = 1:n
    if x(i) <= B(4)
        y(i) = B(1) + v(i);
    elseif x(i) >= B(4) && x(i) <= B(5)
        y(i) = B(1) + (x(i)-B(4))*(B(2)-B(1))/(B(5)-B(4)) + v(i);
    elseif x(i) >= B(4) && x(i) <= B(6)
        y(i) = B(2) + v(i);
    elseif x(i) >= B(6) && x(i) <= B(7)
        y(i) = B(2) + (x(i)-B(6))*(B(3)-B(2))/(B(7)-B(6)) + v(i);
    elseif x(i) >= B(7)
        y(i) = B(3) + v(i);
    end
end