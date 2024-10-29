function x = eulerint(statefun,dt,x,varargin)

% Euler integrasjon
x = x + feval(statefun,x,varargin{:})*dt;