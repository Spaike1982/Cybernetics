function B = newton(fun,B0,x,y,tol,maxit)

% Sjekker innganger
if nargin < 5
    tol = sqrt(eps);
elseif nargin < 6
    maxit=100;
end

% Initiering av loop
itc = 1;
B = B0;
r = 1;

while norm(r) > tol
    J = jacobi_central(fun,1,B,x);
    H = hessian_central(fun,1,B,x);
    ef = feval(fun,B) - y;
    r = -H\J*ef;
    if itc > maxit
        break;
    end
    B = B + r;
    itc=itc+1;
end