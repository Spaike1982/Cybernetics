function B = gaussnewton(fun,B0,x,y,tol,maxit)

% Sjekker innganger
if nargin < 4
    tol = sqrt(eps);
elseif nargin < 5
    maxit=100;
end

% Initiering av loop
itc = 1;
B = B0;
r = 1;

% Gauss newton Iterasjon
while norm(r) > tol
    J = jacobi_central(fun,1,B,x);
    ef = feval(fun,B,x) - y;
    r = -(J'*J)\J'*ef;
    if itc > maxit
        break;
    end
    B = B + r;
    itc=itc+1;
end