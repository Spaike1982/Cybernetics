% Testskript;
clear; clc;
format short g

%% Laster inn virkelige profildata
lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - Vår 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
rho = data(4000:end,1:107);
h = 1:107;
h = h';
dt = 30; % i senkunder
x0 = [10;800;1000;20;25;60;80];
tfin = size(rho,1)*dt;

% Simuleringsfunksjon
tfin = 5*60*60; 
[rho,rhon,X,Xn,t] = simprofile('expfunksjon',x0,h,dt,tfin);

[t,Est] = profilestim('expfunksjon',x0,rho,dt,tfin,'MHEQP');

t = t/60; % Omgjøring til minutter
Xh = Est{1};
figure(1)
plot(t,X(1:3,:),'-',t,Xh(1:3,:),':');
title('Simulert mot estimert tetthet')
ylabel('[kg/m^3]')
xlabel('[min]')
figure(2)
plot(t,X(4:7,:),'-',t,Xh(4:7,:),':');
title('Simulert mot estimert nivå')
ylabel('målepunkt')
xlabel('[min]')