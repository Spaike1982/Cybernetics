function y = atanfunksjon(B,x)
a = 4; % Tuningsparameter
y = B(1) + (B(2)-B(1))/2 + ((B(2)-B(1))/pi)*atan((a/(B(5)-B(4)))*(x-B(4)-((B(5)-B(4))/2))) +... 
    + (B(3)-B(2))/2 + ((B(3)-B(2))/pi)*atan((a/(B(7)-B(6)))*(x-B(6)-((B(7)-B(6))/2)));