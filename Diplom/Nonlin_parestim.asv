% Script: nonlinearLS
% Programmer: t. shores
% Last Rev: 7/1/02
% Description:
% A package of functions for solving the unconstrained nonlinear
% least squares problem of minimizing f(x) = 0.5*R(x)^T*R(x)
% where R(x) = (r_1(x),...,r_n(x)) and x = (x_1,...,x_m).

% not a function file:
1;

% preliminary tools

function retval = arrayf(fname,arr)
% usage: arrayf(fname,arr)
% description: this returns the matrix resulting from replacing
% each coordinate of arr by its evaluation by the function with
% name fname.

% local variables
% ii,jj: index variables
% nr,nc: number of rows, cols

[nr,nc] = size(arr);
retval = zeros(nr,nc);
for ii = 1:nr
  for jj = 1:nc
    retval(ii,jj) = feval(fname,arr(ii,jj));
  end;
end;

endfunction

%

function retval = testfn(x)

retval = zeros(3,1);
retval(1) = 3*x(1)-cos(x(2)*x(3))-0.5;
retval(2) = x(1)^2-81*(x(2)+0.1)^2+sin(x(3))+1.06;
retval(3) = exp(-x(1)*x(2))+20*x(3)+(10*pi-3)/3;

endfunction

%

function retval = testf(x)

retval = testfn(x)'*testfn(x);

endfunction

%

function retval = testR(x)
% usage: retval = testR(x)
% description: a modification of extended Rosenbrock
% function, which it is when cnst k = 0. User sets
% both k and dimension of problem within fcn dfn.
% Standard starter: (-1,2,1,-1,2,1,...)
% With k=0, root is (1,1,...).

n = 10; % size of problem is 3 x n.
k = 0;  % must be >= 0.
retval = zeros(3*n,0);
for kk = 1:n
  n1 = 3*kk - 2;
  n2 = 3*kk - 1;
  n3 = 3*kk;
  retval(n1) = 10*(x(n2) - x(n1));
  retval(n2) = 1 - x(n1);
  retval(n3) = k*sin(x(n2)^2+x(n3)^2);
end

endfunction

%

function retval = jacob(fname,x,h,m)
% usage: retval = jacob(fname,x,h,m)
% description: An unsophisticated Jacobian calculation using
% certered differences. fname(x) and x are *assumed* vector and
% fname(x) is *assumed* a column vector of length m.

% local variables
% jj: index variable
% nx: length of x

nx = length(x);
retval = zeros(m,nx);
for jj = 1:nx
  dx = zeros(size(x));
  dx(jj) = h;
  retval(:,jj) = (feval(fname,x+dx)-feval(fname,x-dx))/(2*h);
end;

endfunction

%

function retval = hess(fname,x,h)
% usage: retval = hess(fname,x,h)
% description: An unsophisticated Hessian calculation using
% forward differences. fname(x) is assumed scalar and x is
% assumed vector.

% local variables
% ii,jj: index variable
% nx: length of x

nx = length(x);
retval = zeros(nx,nx);
fx = zeros(nx,1);
h2 = h*h;
fnamex = feval(fname,x);
for jj = 1:nx
  dx = zeros(nx,1);
  dx(jj) = h;
  fx(jj) = feval(fname,x+dx);
end
for jj = 1:nx
  for ii = 1:jj
    dx = zeros(nx,1);
    dx(ii) = h;
    dx(jj) = dx(jj)+h;
    retval(ii,jj) = (feval(fname,x+dx)-fx(ii)-fx(jj)+fnamex)/h2
  end
end;
retval = retval + triu(retval,1)';

endfunction

%


% the minimizers

function [xnew,resid,kk] = levmar(Rname,x0,nu,itlim,h)
% usage: [x,resid,k] = levmar(Rname,x0,nu0,itlim,h)
% description: Levenberg-Marcquard for minimization of
% nonlinear least squares problem:    min f(x)=0.5*R(x)^T*R(x).
% Input function name, initial vector guess,  fixed L-M
% parameter, iteration limit, derivative stepsize. Output final x, optionally
% norm of residual at final x and number of iterations.

% local variables
% h: stepsize used for numerical derivatives in this algorithm
% stopr,stopa: relative and absolute stopping coefficients
% kk: iteration counter
% nx,nR: length of x0, R
% xold,xnew: current and next value of x
% strial: value of search direction vector
% Rxold: R(xold)
% fpold,Rpold: grad(f) and R'(xold)
% normfp0, normfpold: ||fp0||, ||f'(xold)||
% uu,ss,vv: the U,S,V of svd for (R'(xold))^T*R'(xold)
% ared, pred: actual and predicted reductions in f

% Initialization code
% first the constants of method
stopr = 1e-5;
stopa = 1e-9;
% next the rest of initialization
nx = length(x0);

% make sure x0 is a column
if (columns(x0)>1)
  x0 = x0';
end
xnew = x0;
xold = x0;
strial = x0;
% do calculation of grad(f)(xold)
nR = length(feval(Rname,xold));
Rxold = feval(Rname,xold);
Rpold = jacob(Rname,xold,h,nR);
% use the fact that grad(f)(x) = R'(x)^T*R(x);
fpold = Rpold'*Rxold;
normfp0 = norm(fpold);
resid = norm(Rxold); %degub
% main loop
for kk = 1:itlim
  xold = xnew;
  Rxold = feval(Rname,xold);
  Rpold = jacob(Rname,xold,h,nR);
  % use the fact that grad(f)(x) = R'(x)^T*R(x);
  fpold = Rpold'*Rxold;
  normfpold = norm(fpold);
  % test for termination
  if (normfpold <= stopr*normfp0 + stopa)
    break;
  end
  strial = -inv(Rpold'*Rpold + nu*eye(nx))*fpold;
  xnew = xold + strial;
  resid = norm(feval(Rname,xnew),inf); %degub
end % for
resid = norm(feval(Rname,xnew),inf);

endfunction

%
function [xnew,resid,kk] = levmart(Rname,x0,nu0,itlim,h)
% usage: [x,resid,k] = levmart(Rname,x0,nu0,itlim,h)
% description: Levenberg-Marcquard with pseudo-trust region via
% variable L-M parameter, for minimization of nonlinear least
% squares problem:    min f(x)=0.5*R(x)^T*R(x).  Input
% function name, initial vector guess,  initial L-M parameter,
% iteration limit, derivative stepsize. Output final x, optionally
% norm of residual at final x and number of iterations.

% local variables
% h: stepsize used for numerical derivatives in this algorithm
% stopr,stopa: relative and absolute stopping coefficients
% scaledn,scaleup: trust region contraction, expansion factors
% mu0,umlow,mumax: trust region parameters
% kk: iteration counter
% nx,nR: length of x0, R
% nuold: working L-M parameter
% xold,xtrial,xnew: current, trial and next value of x
% strial: trial value of search direction vector
% Rxold,Rxtrial: R(xold) and R(xtrial)
% fpold,Rpold: grad(f) and R'(xold)
% normfp0, normfpold: ||fp0||, ||f'(xold)||
% uu,ss,vv: the U,S,V of svd for (R'(xold))^T*R'(xold)
% ared, pred: actual and predicted reductions in f

global storage;%degub

% Initialization code
% first the constants of method
scaledn = 0.5;
scaleup = 2.0;
mu0 = 1e-4;
mulow = 0.25;
muhigh = 0.75;
stopr = 1e-5;
stopa = 1e-9;
% next the rest of initialization
nx = length(x0);
nuold = nu0;
% make sure x0 is a column
if (columns(x0)>1)
  x0 = x0';
end
xtmp = x0;
xtrial = x0;
xnew = x0;
xold = x0;
strial = x0;
ared = 0;
pred = 0;
% do calculation of grad(f)(xold)
nR = length(feval(Rname,xold));
Rxold = feval(Rname,xold);
Rpold = jacob(Rname,xold,h,nR);
% use the fact that grad(f)(x) = R'(x)^T*R(x);
fpold = Rpold'*Rxold;
normfp0 = norm(fpold);
% main loop
for kk = 1:itlim
  xold = xnew;
  Rxold = feval(Rname,xold);
  Rpold = jacob(Rname,xold,h,nR);
  % use the fact that grad(f)(x) = R'(x)^T*R(x);
  fpold = Rpold'*Rxold;
  normfpold = norm(fpold);
  normfold = norm(Rxold);
  % test for termination
  if (normfpold <= stopr*normfp0 + stopa)
    break;
  end
  storage(:,kk)=xold;%degub
  % set up to compute trial steps
  % set looping flag in trust region test to true
  trflag = 1;
  xnew = xold;
  % now loop
  while (trflag)
    % use identity (A+alpha*I)^{-1}=V*(S^2+alpha*I)*V^T
    % to solve for trial step in L-M formula
    %strial = -vv*diag(1./(diag(ss).^2 + nuold))*fp;
    strial = -inv(Rpold'*Rpold + nuold*eye(nx))*fpold;
    xtrial = xold + strial;
    Rxtrial = feval(Rname,xtrial);
    ared = 0.5*(Rxold'*Rxold - Rxtrial'*Rxtrial);
    pred = -0.5*(Rpold'*Rxold)'*strial;
    if (ared/pred < mu0)
      nuold = max(scaleup*nuold,nu0);
    elseif (ared/pred < mulow)
      trflag = 0;
      xnew = xtrial;
      nuold = max(scaleup*nuold,nu0);
    else
      trflag = 0;
      xnew = xtrial;
      if (ared/pred > muhigh)
        nuold = scaledn*nuold;
      end
      if (nuold < nu0)
        nuold = 0;
      end
    end %if
  end % while
end % for
resid = norm(feval(Rname,xnew));

endfunction

%

function [xbest,resid,kk,nn] = bfgs(Rname,x0,nu,iterlim,h)
% usage: [x,res,kk,nr] = bfgs(Rname,x0,nu,iterlim,h)
% description: a modified Newton BFGS method applied to
% least squares optimization problem: min f(x)=0.5*R(x)^T*R(x).
% Input function name, initial vector guess, regularization
% parameter, iteration limit, stepsize for numerical derivative.
% Output final x, optionally norm of residual
% at final x, iteration number and restart number.
% Uses Armijo search, restart and stopping criteria. Stores
% full Jacobian approximation.
% Just added: memory, so that the x with least norm residual
% gets returned.

global storage; %degub

% local variables:
% stopr,stopa: relative and absolute stopping coefficients
% kk,nn: iteration counter, restart counter
% xold, xnew: vectors for iteration
% fpold, fpnew: f'(xold) and f'(xnew)
% nx: length of x
% nR: length
% B: inverse of Jacobian or approximation matrix
% s: search direction
% lambda: search direction parameter
% s: difference in x steps
% y: difference of gradients of f
% u,v: temporaries in BFGS update
% restartf: restart flag, value 0 for no, 1 for L-M H, 2 for I
% normfp0: norm of initial function gradient value

% initialization
stopr = 1e-5;
stopa = 1e-4;
tau = 1e-4; %acceptable reduction factor
maxhalf = 6; % maximum number of halfing steps
xold = x0;
xbest = xold;
nx = length(xold);
% do calculation of grad(f)(x0)
Rxold = feval(Rname,xold);
nR = length(Rxold);
Rpold = jacob(Rname,xold,h,nR);
% use the fact that grad(f)(x) = R'(x)^T*R(x);
fpold = Rpold'*Rxold;
normfp0 = norm(fpold);
normfp = normfp0;
resid = norm(Rxold); %degub
bestresid = resid;
bestindex = 1;
nn = 1;
restartf = 1;
% construct L-M restart matrix
B = eye(nx);
%B = inv(Rpold'*Rpold + nu*eye(nx));
kk = 0;
while (kk < iterlim)
  % find a search direction
  s = -B*fpold;
  % do a line search
  jj = 0;
  lambda = min(1,1/(1+normfp));
  while (jj < maxhalf)
    xtmp = xold + lambda*s;
    normftmp = norm(feval(Rname,xtmp));
    if (normftmp < (1-tau*lambda)*resid)
      break;
    end;
    lambda = lambda/2;
    jj = jj + 1;
  end
  if (jj >= maxhalf)
     restartf = restartf + 1;
    if (restartf > 2)
      disp('Failure of search direction to reduce ||f(x)||');
      return;
    else % need to really do a restart
      nn = nn + 1;
      if (restartf == 2) % construct the L-M restart matrix
        Rxold = feval(Rname,xold);
        Rpold = jacob(Rname,xold,h,nR);
        fpold = Rpold'*Rxold;
        B = inv(Rpold'*Rpold + nu*eye(nx));
      else  % construct the identity restart
        B = eye(nx);
      end
      continue;
    end
  end
  % can now assume search direction succeeded
  kk = kk + 1;
  xnew = xold + lambda*s;
  % we need fpnew
  Rxnew = feval(Rname,xnew);
  Rpnew = jacob(Rname,xnew,h,nR);
  fpnew = Rpnew'*Rxnew;
  % now do a BFGS update
  s = xnew - xold;
  y = fpnew - fpold;
  p = y'*s;
  B = B - s*(y'*B)/p;
  B = B - (B*y)*s'/p + s*s'/p;
  restartf = 0;
  xold = xnew;
  Rxold = feval(Rname,xold);
  Rpold = jacob(Rname,xold,h,nR);
  fpold = Rpold'*Rxold;
  normfp = norm(fpold);
  resid = norm(Rxold);
  storage(:,kk)=xold;%degub
  % test for best residual
  if (resid <= bestresid)
    bestresid = resid;
    xbest = xold;
    bestindex = kk;
  end
  disp([resid,normfp,resid + normfp,bestindex])
  % test for termination
  if (normfp <= stopr*normfp0 + stopa)
    return;
  end
end

endfunction

%

function [xold,resid,kk,nn] = quasinewton(Rname,x0,nu,iterlim,h)
% usage: [x,res,kk,nr] = bfgs(Rname,x0,nu,iterlim,h)
% description: a quasiNewton BFGS method applied to
% least squares optimization problem: min f(x)=0.5*R(x)^T*R(x).
% Input function name, initial vector guess, regularization
% parameter, iteration limit, stepsize for numerical derivative.
% Output final x, optionally norm of residual
% at final x, iteration number and restart number.
% Uses Armijo search, restart and stopping criteria. Stores
% full Jacobian approximation.

% local variables:
% stopr,stopa: relative and absolute stopping coefficients
% kk,nn: iteration counter, restart counter
% xold, xnew: vectors for iteration
% fpold, fpnew: f'(xold) and f'(xnew)
% nx: length of x
% nR: length
% B: inverse of Jacobian or approximation matrix
% s: search direction
% lambda: search direction parameter
% s: difference in x steps
% y: difference of gradients of f
% u,v: temporaries in BFGS update
% restartf: restart flag, value 0 for no, 1 for L-M H, 2 for I
% normfp0: norm of initial function gradient value

global storage;

% initialization
stopr = 1e-5;
stopa = 1e-9;
tau = 1e-4; %acceptable reduction factor
maxhalf = 6; % maximum number of halfing steps
xold = x0;
nx = length(xold);
% do calculation of grad(f)(x0)
Rxold = feval(Rname,xold);
nR = length(Rxold);
Rpold = jacob(Rname,xold,h,nR);
% use the fact that grad(f)(x) = R'(x)^T*R(x);
fpold = Rpold'*Rxold;
normfp0 = norm(fpold);
resid = norm(Rxold); %degub
nn = 1;
restartf = 1;
% calculate approximate full Hessian for restart
B = zeros(nx,nx);
fx = zeros(nx,1);
h2 = h*h;
fnamex = Rxold'*Rxold;
for jj = 1:nx
  dx = zeros(nx,1);
  dx(jj) = h;
  Rtmp = feval(Rname,xold+dx);
  fx(jj) = Rtmp'*Rtmp;
end
for jj = 1:nx
  for ii = 1:jj
    dx = zeros(nx,1);
    dx(ii) = h;
    dx(jj) = dx(jj)+h;
    Rtmp = feval(Rname,xold+dx);
    B(ii,jj) = (Rtmp'*Rtmp-fx(ii)-fx(jj)+fnamex)/h2;
  end
end;
B = inv(B + triu(B,1)');
for kk = 1:iterlim
  s = -B*fpold;
  % do a line search
  jj = 0;
  lambda = 2;
  normfx = norm(feval(Rname,xold));
  while (jj < maxhalf)
    lambda = lambda/2;
    xtmp = xold + lambda*s;
    normftmp = norm(feval(Rname,xtmp));
    if (normftmp < (1-tau*lambda)*normfx)
      break;
    end;
    jj = jj + 1;
  end
  if (jj == maxhalf)
    lambda = 0;
  end
  if (lambda == 0)
    if (restartf > 3)
      disp('Failure of search direction to reduce ||f(x)||');
      resid = norm(feval(Rname,xold),inf);
      return;
    else % need to really do a restart
      nn = nn + 1;
      if (restartf == 1) % construct full hessian restart matrix
        % calculate approximate full Hessian for restart
        B = zeros(nx,nx);
        fx = zeros(nx,1);
        h2 = h*h;
        fnamex = Rxold'*Rxold;
        for jj = 1:nx
          dx = zeros(nx,1);
          dx(jj) = h;
          Rtmp = feval(Rname,xold+dx);
          fx(jj) = Rtmp'*Rtmp;
        end
        for jj = 1:nx
          for ii = 1:jj
            dx = zeros(nx,1);
            dx(ii) = h;
            dx(jj) = dx(jj)+h;
            Rtmp = feval(Rname,xold+dx);
            B(ii,jj) = (Rtmp'*Rtmp-fx(ii)-fx(jj)+fnamex)/h2;
          end
        end;
        B = inv(B + triu(B,1)');
        restartf = 2;
      else  % construct the identity restart
        B = eye(nx);
        restartf = 3;
      end
      continue;
    end
  end
  % can now assume search direction succeeded
  xnew = xold + lambda*s;
  % we need fpnew
  Rxnew = feval(Rname,xnew);
  Rpnew = jacob(Rname,xnew,h,nR);
  fpnew = Rpnew'*Rxnew;
  % now do a BFGS update
  s = xnew - xold;
  y = fpnew - fpold;
  p = y'*s;
  B = B - s*(y'*B)/p;
  B = B - (B*y)*s'/p + s*s'/p;
  restartf = 0;
  xold = xnew;
  Rxold = feval(Rname,xold);
  Rpold = jacob(Rname,xold,h,nR);
  fpold = Rpold'*Rxold;
  normfp = norm(fpold);
  resid = norm(Rxold); %degub
  % test for termination
  if (normfp <= stopr*normfp0 + stopa)
    break;
  end
  %storage(:,kk)=xold; %degub
  disp('kk is')
  kk
end
resid = norm(Rxold);

endfunction

%