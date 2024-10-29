clear; clc;

%% Definerer simulasjonsparametre
dt = 0.1;
tfin = 20;
t = 1:dt:tfin;      % Tidsvektor
nSim = length(t);   % Antall tidskritt

%% Prosessparametre for Totankmodell
%u = 20 + prbs1(nSim,40,80)'; % P�drag
u = 10*ones(nSim,1);
us = u(end); % arbeidspunkt for line�risering
x = ones(2,1);  % Tilstandsvektor
xb = x;
yb = xb;

% Dimensjoner
nx  = 2;                                % tilstander
ny  = 2;                                % m�linger
nw  = 2;                                % prosesst�y
nv  = 2;                                % m�lest�y
nu = 1;                                 % p�drag
L = nx + nw + nv;                   % agumentert

% St�ygenerering
wm = [0;0]; % Middelverdi prosessforstyrrelse (mu)
vm = [0;0]; % Middelverdi m�lest�y (mu)
wr = 0.001;   % Standaravvik prosessforstyrrelse (rho)
vr = 0.001;   % Standaravvik m�lest�y (rho)
w = wr*randn(nx,nSim) + vectorrep(wm,nSim);    % Prosessforstyrrelse
v = vr*randn(ny,nSim) + vectorrep(vm,nSim);    % M�lest�y

%% Line�risering av uline�r prosessmodell

% Finner arbeidspunkter for line�riseringen
[xs,ys,i] = stationary(x,us,wm,vm,dt);
% NB, erstatt med anaytisk uttrykk hvis mulig (eks totank):
%[xs,ys] = stationaryTT(us,vm)
ts = i*dt;
% Finner line�r modell
[A,B,G,C,D,H] = linearize_peturb(xs, wm, vm, us, 'A','B','G','C','D','H')
% [A,B,G,C,D,H] = linearize_ss(xs, wm, vm, us, dt, 'A','B','G','C','D','H');
%[A,B,G,C,D,H] = linearizeTT(xs, wm, vm, us, dt ,'A','B','G','C','D','H');
Ad = jacobi('f',xs,us,wm)

for k = 1:nSim
    disp(k)
    % Prosess simulator
    y = g(x,u(k),v(:,k));
    x = x + dt*f(x,u(k),w(:,k)); % Euler

    % Aviksvariable da en line�r avviksmodell benyttes
    dxb = xb - xs;
    dy = yb - ys;
    du = u(k) - us;
    
    % Avviksmodell
    dyb = C*dxb+D*du;
    dxb = A*dxb+B*du;
    
    % 
    xb = dxb + xs;
    yb = dyb + ys;
    
    % Lagreing
    Xb(:,k) = xb';
    Yb(:,k) = yb';
    X(:,k) = x';
    Y(:,k) = y';
end

plot(t,X,t,Xb);
legend('Tilstand 1','Tilstand2','Line�r1','Line�r2');

