%
% extrapolation_framework - used to implement Romberg
%     integration or any other method that uses repeated
%     Richardson extrapolation to improve order of 
%     accuracy.
%
% input:
% f - function that computes initial approximations of
%     whatever needs to be computed.  f must generate an
%     approximation whose error term is of the form
%     K_1 h^p + K_2 h^2p + K_3 h^3p + ...
%     where h is the step size
% p - order of error in approximation method f
% r - desired order of accuracy
% h0 - initial parameter
% interpret - flag indicating how parameter h0 is to be 
%             interpreted.  if value is 0, then parameter
%             is a step size and should be halved to
%             increase accuracy.  otherwise, it represents
%             a number that is inversely proportional to
%             the step size (such as a number of nodes
%             in a quadrature rule) and should be doubled to
%             increase accuracy
% varargin - arguments to be passed to f
% 

function y=extrapolation_framework(f,p,r,h0,interpret,varargin)

% n is the number of approximations that must
% be computed using f to achieve the desired
% order of accuracy
n=ceil(r/p);
% R1 holds previous approximations
R1=zeros(1,n-1);
% R2 holds current approximations
R2=zeros(1,n);
% compute initial approximation
R1(1)=feval(f,varargin{:},h0);
for j=2:n,
    % adjust parameter for improved approximation
    if interpret==0,
        % cut step size in half, or
        h0=h0/2;
    else
        % double number of quadrature nodes
        h0=h0*2;
    end
    % compute new approximation at half the step size
    R2(1)=feval(f,varargin{:},h0);
    % extrapolate as many times as possible.  R2(k) is
    % accurate to order k*p
    for k=2:j,
        R2(k)=R2(k-1)+(R2(k-1)-R1(k-1))/(2^((k-1)*p)-1);
    end
    % current approximations serve as the previous
    % approximations for the next step
    if j<n,
        R1(1:j)=R2(1:j);
    end
end
% R2(n) is accurate to order r
y=R2(n);