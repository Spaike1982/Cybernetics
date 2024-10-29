%% OLS modellering
clear; clc;

%% Tar inn data og deler opp i modelleringsdata og valideringsdata
importfile('C:\Documents and Settings\Administrator\My Documents\Jobb\Erbus\Troll A Precompression\Matlab\data.mat')
% Speed [rpm]
v=data(:,1);
% Inlet (suction) pressure [BarA]
p_s=data(:,2);
% Outlet (discharge) pressure [BarA]
p_d=data(:,3);
% Masflow [kg/hr]
m_dot=data(:,4);
% Volumeflow [m^3/min]
V_dot=data(:,5);
% Shaft power [kW]
W_shaft=data(:,6);
% Polytropic Head [kJ/kg]
P_h=data(:,7);

% Deler opp i inngangsdata x og utgangdata y
xcal=[p_s,p_d,m_dot,V_dot,W_shaft,P_h]; 
ycal=v;

% Testsett
xval=[p_s,p_d,m_dot,V_dot,W_shaft,P_h];
yval=v;

[Bols,b0ols,RMSEPols,RMSECols]=myOLS(xcal,ycal,xval,yval);

figure(1); plot(Bols);
title('Regressjonskoeffisienter')

%% Plotter prediksjonsevne
figure(2); plot([yval,xval*Bols+b0ols]);
legend('Virkelig utgang','Esimert utgang'); ylabel('RPM'); title('Virkelig og beregnet utgang');
figure(3); plot(yval,xval*Bols+b0ols,'.',v,v);
legend(['RMSEP = ',num2str(RMSEPols)],'target line'); xlabel('RPM'); ylabel('RPM'); title('v virkelig mot v beregna');