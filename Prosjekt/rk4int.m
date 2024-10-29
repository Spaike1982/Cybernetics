function x = rk4int(statefun,dt,x,varargin)

% Runge kutta 4. ordens integrasjon
K1 = feval(statefun,x,varargin{:})*dt;
K2 = feval(statefun,x+K1/2,varargin{:})*dt;
K3 = feval(statefun,x+K2/2,varargin{:})*dt;
K4 = feval(statefun,x+K3,varargin{:})*dt;
x = x + (K1+2*K2+2*K3+K4)/6;