function dxdt = f(x,u,w)
%
% f.m: Funksjon som beskriver de deriverte i en mulig ulineær 
% tilstansrommodell, det vil si en modell kun bestående av 1. ordens 
% deriverte. For å få ut de virkelige tilstandene må denne fuksjonen 
% integreres, f.eks med euler: 
% x(k+1) = x(k) + dt*f(x(k),u(k),w(k)), der dt = k+1 - k.
% 
% Basistruktur for tilstansrommodellen:
%
%   dxdt = f(x(k),u(k),w(k))
%
% Se eksempel med totankmodell i denne fila.
%
% Fuksjonsrutine
% 
%   dxdt = f(x,u,w)
%
% Innganger:
% 
%   x - Tilstander
%   u - Pådrag 
%   w - Prosessforstyrrelse
%
% Utganger:
% 
%   dxdt - Tistandsderiverte
% 

%% Eksempelmodell med to tilstander: Totanken ved HIT
% Parametre
K1 = 1097;
K2 = 1022; % For rigg 1
K3 = 423.22;
K4 = 2039.3;
Ar  = 111.1; % [cm^2]

% Differensialligninger
dh1dt = (K3*u+K4-K1*sqrt(x(1,:)))/Ar+w(1,:);
dh2dt = (K1*sqrt(x(1,:))-K2*sqrt(x(2,:)))/Ar+w(2,:);

% Samler deriverte i vektor
dxdt = [dh1dt;dh2dt];