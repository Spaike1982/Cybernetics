%%% Test av lineæriseringsrutiner for Totanken
clear; clc;

mod = 2; % Mod = 1: Totankmodellen, else reaktor
%% Definerer simulasjonsparametre
% For totank
if mod == 1
dt = 0.1;
tfin = 200;
else
% For reaktor
tfin = 50;
dt = 0.01;
end

t = 1:dt:tfin;      % Tidsvektor
nSim = length(t);   % Antall tidskritt

%% Prosessparametre for Totankmodell
% Pådrag
if mod == 1
us = 5;
u = us + 1*prbs1(nSim,40,200)';
% Initialverider for totankmodell
x = ones(2,1);  % Tilstandsvektor
else
% Pådrag for reaktormodell
dotVc = 100; % l/min
dotV = 100;  % l/min
us = [dotVc;dotV];
u = vectorrep(us,nSim) + [5*prbs1(nSim,50,500)';10*prbs1(nSim,50,500)'];
% Initialverdier for reaktormodell
cA0 = 8.235e-2; % mol/l
T0 = 441.81; % K
x = [cA0; T0];
xl = x;
end
% ----------------------- %
y = x;
xla = x;
xlp = x;
xls = x;
xlj = x;
yla = x;
ylp = x;
yls = x;
ylj = x;
% Dimensjoner
nx = length(x);
ny = length(y);
nu = size(u,1);
nw = nx;
nv = ny;
% Støygenerering
wm = [0;0]; % Middelverdi prosessforstyrrelse (mu)
vm = [0;0]; % Middelverdi målestøy (mu)
wr = 0;   % Standaravvik prosessforstyrrelse (rho)
vr = 0;   % Standaravvik målestøy (rho)
w = wr*randn(nw,nSim) + vectorrep(wm,nSim);    % Prosessforstyrrelse
v = vr*randn(nv,nSim) + vectorrep(vm,nSim);    % Målestøy

%% Lineærisering av ulineær prosessmodell

% Finner arbeidspunkter for lineæriseringen
%[i,xs] = stationary('f',[1;1],dt,us,wm);
% NB, erstatt med anaytisk uttrykk hvis mulig (eks totank):
xs = stationary('f',x,dt,us,wm);
ys = g(xs,us,vm);
ts = i*dt;
I = eye(nx);

% Finner lineær modell
% Analytisk
if mod == 1
[Aa,Ba,Da,Ea,Ca,Fa] = linearizeTT(xs, wm, vm, us ,'A','B','D','E','C','F');
Aad=expm(Aa*dt); Bad=inv(Aa)*(expm(Aa*dt)-I)*Ba; Dad=Da;
else
disp('Analytisk derivasjon for reaktormodell ikke implementert');
Aad = zeros(nx); Bad = zeros(nx,nu); Ca = zeros(nx,nw); Dad = zeros(ny,nx); 
Ea = zeros(ny,nu); Fa = zeros(ny,nv);
end

% Vanlig petiurbasjonsmetode
tic
[Ap,Bp,Dp,Ep,Cp,Fp] = linearize_peturb(xs, wm, vm, us, 'A','B','D','E','C','F');
toc
Apd=expm(Ap*dt); Bpd=inv(Ap)*(expm(Ap*dt)-I)*Bp; Dpd=Dp;

% Steady state error reduction
tic
[As,Bs,Ds,Es,Cs,Fs] = linearize_ss(xs, wm, vm, us, dt, 'A','B','D','E','C','F');
toc
Asd=expm(As*dt); Bsd=inv(As)*(expm(As*dt)-I)*Bs; Dsd=Ds;

% Nummerisk jacobi med central differences
tic
Aj = jacobi3('f',1,xs,us,wm);
Bj = jacobi3('f',2,xs,us,wm);
Cj = jacobi3('f',3,xs,us,wm);
Dj = jacobi3('g',1,xs,us,vm);
Ej = jacobi3('g',2,xs,us,vm);
Fj = jacobi3('g',3,xs,us,vm);
toc
Ajd=expm(Aj*dt); Bjd=inv(Aj)*(expm(Aj*dt)-I)*Bj; Djd=Dj;

% Simuleringsløkke
X = zeros(nx,nSim);
Xla = X;
Xlp = X;
Xls = X;
Xlj = X;
Y = zeros(ny,nSim);
Yla = Y;
Ylp = Y;
Yls = Y;
Ylj = Y;
for k = 1:nSim
    % Lagreing
    % Ulineær
    X(:,k) = x';
    Y(:,k) = y';
    % Lineær - analytisk
    Xla(:,k) = xla';
    Yla(:,k) = yla';
    % Lineær - peturbasjon
    Xlp(:,k) = xlp';
    Ylp(:,k) = ylp';
    % Lineær - Steady state reduction
    Xls(:,k) = xls';
    Yls(:,k) = yls';
    % Lineær - Central difference jacobi
    Xlj(:,k) = xlj';
    Ylj(:,k) = ylj';
    
    % Ulineær Prosess simulator
    y = g(x,u(k),v(:,k));
    % 4. order rk
    K1 = f(x,u(:,k),w(:,k))*dt;
    K2 = f(x+K1/2,u(:,k),w(:,k))*dt;
    K3 = f(x+K2/2,u(:,k),w(:,k))*dt;
    K4 = f(x+K3,u(:,k),w(:,k))*dt;
    x = x + (K1+2*K2+2*K3+K4)/6;

    % Aviksvariable da en lineær avviksmodell benyttes
    du = u(:,k) - us;
    % Analytisk
    dxla = xla - xs;
    % Peturbajson
    dxlp = xlp - xs;
    % Steady state error red.
    dxls = xls - xs;
    % Central difference jacobi
    dxlj = xlj - xs;
    
    % Avviksmodeller
    % Analytisk
    dyla = Dad*dxla + Ea*du + Fa*v(:,k);
    dxla = Aad*dxla + Bad*du + Ca*w(:,k);
    % Peturbasjon
    dylp = Dpd*dxlp + Ep*du + Fp*v(:,k);
    dxlp = Apd*dxlp + Bpd*du + Cp*w(:,k);
    % Steaty state
    dyls = Dsd*dxls + Es*du + Fs*v(:,k);
    dxls = Asd*dxls + Bsd*du + Cs*w(:,k);
    % Central difference jacobi
    dylj = Djd*dxlj + Ej*du + Fj*v(:,k);
    dxlj = Ajd*dxlj + Bjd*du + Cj*w(:,k);

    % Analytisk
    xla = dxla + xs;
    yla = dyla + ys;
    % Peturbajson
    xlp = dxlp + xs;
    ylp = dylp + ys;
    % Steady state error red.
    xls = dxls + xs;
    yls = dyls + ys;
    % Central difference jacobi
    xlj = dxlj + xs;
    ylj = dylj + ys;
end
RMSEPa = [sqrt(sum((X(1,:)-Xla(1,:)).^2)/nSim);sqrt(sum((X(2,:)-Xla(2,:)).^2)/nSim)]
RMSEPp = [sqrt(sum((X(1,:)-Xlp(1,:)).^2)/nSim);sqrt(sum((X(2,:)-Xlp(2,:)).^2)/nSim)]
RMSEPs = [sqrt(sum((X(1,:)-Xls(1,:)).^2)/nSim);sqrt(sum((X(2,:)-Xls(2,:)).^2)/nSim)]
RMSEPj = [sqrt(sum((X(1,:)-Xlj(1,:)).^2)/nSim);sqrt(sum((X(2,:)-Xlj(2,:)).^2)/nSim)]

figure(1)
plot(t,X(1,:),'--',t,Xla(1,:),t,Xlp(1,:),t,Xls(1,:),t,Xlj(1,:));
legend('Ulineær','Lineær analytisk','Lineær peturb','Lineær sserr','Lineær jac');
figure(2)
plot(t,X(2,:),'--',t,Xla(2,:),t,Xlp(2,:),t,Xls(2,:),t,Xlj(2,:));
legend('Ulineær','Lineær analytisk','Lineær peturb','Lineær sserr','Lineær jac');

