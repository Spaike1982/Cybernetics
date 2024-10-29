%% Prinsippal Component Analysis
% Utfører en prinsippalkomponent analyse av data fra dokument
% AO-0100-M-KV-005 side 2.4
%
% Dette skriptet er laget av Henning Winsnes i forindelse med sommerjobb
% 2006.
%
% Revidert 12.02.2007: Laget rutine for automatisk plotting

clear; clc;

%% Tar inn data
importfile('C:\Documents and Settings\Administrator\My Documents\Jobb\Erbus\Troll A Precompression\Matlab\data.mat')
% Speed [rpm]
v=data(:,1);
% Inlet (suction) pressure [BarA]
p_s=data(:,2);
% Outlet (discharge) pressure [BarA]
p_d=data(:,3);
% Massflow [kg/hr]
m_dot=data(:,4);
% Volumeflow [m^3/min]
V_dot=data(:,5);
% Shaft power [kW]
W_shaft=data(:,6);
% Polytropic Head [kJ/kg]
P_h=data(:,7);

% Samler data i matrise
X=[v,p_s,p_d,m_dot,V_dot,W_shaft,P_h];

% Utfører PCA analysen.
[T,P,E,X_pca,a]=myPCA(X);

% Scoreplot
sampler = 1:size(X,1);
sampler = num2str(sampler');
figure(3)
axis([min(T(:,1)), max(T(:,1)), min(T(:,2)), max(T(:,2))])
text(T(:,1),T(:,2),sampler);
% Loadingplot
variable = ['vv';'ps';'pd';'md';'Vd';'Ws';'Ph'];
figure(4)
axis([min(P(:,1)), max(P(:,1)), min(P(:,2)), max(P(:,2))])
text(P(:,1),P(:,2),variable);


