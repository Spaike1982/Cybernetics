% Simulation script for model from Exercise 6
clear; clc;
% Time paramters
tfin = 20;
dt = 0.01;
t = 1:dt:tfin;
nSim = length(t);

% Deterministic inputs
dotVc = 100; % l/min
us = dotVc;
u = us + 1*prbs1(nSim,50,500)';

% Initial values
cA0 = 8.235e-2; % mol/l
T0 = 441.81; % K
x = [cA0; T0];
xl = x;
nx = length(x);
nu = size(u,1);

% Linearization 
% Stationary point
xs = stationary('f',x,dt,us,[0;0]);
% Linearization by nummerical jacobi calculations
%Ac = jacobi('f',1,xs,us,[0;0]);
%Bc = jacobi('f',2,xs,us,[0;0]);
%[Ac,Bc] = linearize_peturb(xs, [0;0], [0;0], us, 'A','B')
[Ac,Bc,Cc,Dc,Ec,Fc] = linearize_ss(xs, [0;0], [0;0], us, dt, 'A','B','C','D','E','F');
I = eye(nx);
A=expm(Ac*dt); B=inv(Ac)*(expm(Ac*dt)-I)*Bc;


% Simulation
X = zeros(nx,nSim);
Xl = X;
U = zeros(nu,nSim);
for k = 1:nSim
    X(:,k) = x';
    Xl(:,k) = xl';
    U(:,k) = u(:,k)';
    dxl = xl - xs;
    du = u(:,k) - us;
    dxl = A*dxl + B*du;
    xl = dxl + xs;
    % Euler integration
    x = x + dt*f(x,u(:,k),[0;0]);
end
figure(1)
plot(t,X(1,:),t,Xl(1,:));
legend('Ulineær','Lineærisert');
figure(2)
plot(t,X(2,:),t,Xl(2,:));
legend('Ulineær','Lineærisert');
figure(3)
plot(t,U)
