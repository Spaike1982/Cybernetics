% Testmodel.m: Skript som tester de ulike ligningene mot virkelige
% profildata for å finne den funksjonen som beksriver data best

%%% Skript for å kjøre forsøk. 
clear; clc;
format short g


%% Laster inn virkelige profildata
lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - Vår 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
rho = data(1:20:end,1:107);
h = 1:107;
h = h';
dt = 30*100; % i senkunder
x0 = [10;800;1000;20;25;60;80];
tfin = size(rho,1)*dt;

% %% Simuleringsfunksjon
% tfin = 0.1*60*60; 
% [rho,rhoI,X,XI,t] = simprofile('absrampefunksjon',x0,h,dt,tfin);

%% Estimeringsfunksjon
[t,Est] = profilestim('expfunksjon',x0,rho,dt,tfin,'curveestim2');

% Henter måleestimat
Yh = Est{3};

%% RMESP
n = length(h);
m = length(t);

for i = 1:m
    RMSEP(i) = sqrt(sum((rho(i,:)'-Yh(:,i)).^2)/n);
end

% Statistikk
max(RMSEP)
min(RMSEP) 
mean(RMSEP)
std(RMSEP)

%% Plotting
t = t/60/60; % Omgjøring til timer
figure(1)
plot(t,RMSEP);
title('Feil mellom modellerete og virkelige profildata')
xlabel('Tid [timer]');
ylabel('RMESP');


