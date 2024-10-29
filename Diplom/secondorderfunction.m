function y = secondorderfunction(B)
x = 1:107;
a = 4; % a = 1 gir tidskonstanten T
y = B(1) - (B(2)-B(1))*(exp((-a/(B(5)-B(4))).*(x-B(4))) + (a/(B(5)-B(4)))*(x-B(4)).*exp((-a/(B(5)-B(4))).*(x-B(4)))-1).*(1./(1+exp(-1000*(x-B(4)))))...
     -(B(3)-B(2))*(exp((-a/(B(7)-B(6))).*(x-B(6))) + (a/(B(7)-B(6)))*(x-B(6)).*exp((-a/(B(7)-B(6))).*(x-B(6)))-1).*(1./(1+exp(-1000*(x-B(6)))));
 y = y';