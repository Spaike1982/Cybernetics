function y = firstorderfunction(B,x)
a = 1.5; % a = 1 gir tidskonstanten T
y = B(1) - (B(2)-B(1))*(exp((-a/(B(5)-B(4))).*(x-B(4))) - 1).*(1./(1+exp(-1000*(x-B(4)))))...
     -(B(3)-B(2))*(exp((-a/(B(7)-B(6))).*(x-B(6))) - 1).*(1./(1+exp(-1000*(x-B(6)))));