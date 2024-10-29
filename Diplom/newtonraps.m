function [B,i] = newtonraps(fun,B,x,y)

r = 1;
i = 1;
B = B';
tol = 0.001;
while abs(r) > tol
    Je = jacobi_err(fun,B,x,y);
    ef = feval(fun,B,x) - y;
    r = -Je\ef;
    B = B + r;
    i = i + 1;
end
B = B';