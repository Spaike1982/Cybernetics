clear; clc;

%% Laster inn virkelige profildata
lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - Vår 2007\Hovedoppgave\Matlab\QPestimator\sep1p.mat');
rho = data(1:end,1:107);

% Nivåvektor
h = 1:107; 
h = h'; % Skal ha kolonnevektor

% tidsskritt i sekunder
dt = 30;
% Sluttid
tfin = size(rho,1)*dt;

% Initialestimat
x0 = [10;800;1000;20;25;60;80];

%% Estimerer
[Xh,Xb,Yb,Phat,Pbar,t] = MHEQPestim('expfunksjon',x0,rho,dt,tfin);

