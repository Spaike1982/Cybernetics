function y = absrampefunksjon(B,x)
y = B(1)+((x-B(4))+abs(x-B(4)))*0.5*(B(2)-B(1))/(B(5)-B(4))-((x-B(5))+abs(x-B(5)))*0.5*(B(2)-B(1))/(B(5)-B(4))+...
    ((x-B(6))+abs(x-B(6)))*0.5*(B(3)-B(2))/(B(7)-B(6))-((x-B(7))+abs(x-B(7)))*0.5*(B(3)-B(2))/(B(7)-B(6));