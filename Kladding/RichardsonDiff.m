function [dfx,D] = RichardsonDiff(fx,x,x0,max1)

% fx - Funksjsverdi vektor
% x - x vektor
% x0 - Punkt det skal deriveres rundt
% max1 - Iterasjoner

D = zeros(max1,max1);

for k = 1 : max1
    D(max1-k+1,1) = (fx(x0+2^(k-1))-fx(x0-2^(k-1)))/(x(x0+2^(k-1))-x(x0-2^(k-1)));
end

for j = 2:max1
    for i = 1:max1-j+1
        D(max1-i+1,j) = D(max1-i+1,j-1) + (D(max1-i+1,j-1)-D(max1-i,j-1))/(4^(j-1)-1);
    end
end

dfx = D(end,end);
