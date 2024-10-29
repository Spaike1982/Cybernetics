%% PLS-R modellering og overvåkning
% Danner en PLS og en 2PLS modell basert på data fra dokument
% AO-0100-M-KV-005 side 2.4
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

%% Danner PLS-R modell
[T,Ppls,Qt,W,E,Bpls,b0pls,RMSECpls,RMSEPpls,xcal_s,ycal_s,A]=myPLS(xcal,ycal,xval,yval);

%% Plotter residuale mot virkelige data for å sjekke om valg av antall PC
%% var fornuftig
for i = 1:size(xcal,2)
    figure(i); plot([xcal_s(:,i),E(:,i)]);
    legend('Variabel','Residuale')
    title(['Residuale mot data for variabel nr: ',num2str(i)])
end
%% Plotter regresjonskoeffisienter
figure(i+1); plot(Bpls);
title('Regressjonskoeffisienter')

%% Plotter prediksjonsevne
figure(i+2); plot([v,xval*Bpls+b0pls]);
legend('Virkelig speed','Esimert speed'); ylabel('RPM'); title('Virkelig og beregnet speed');
figure(i+3); plot(v,xval*Bpls+b0pls,'.',v,v);
legend(['RMSEP = ',num2str(RMSEPpls)],'target line'); xlabel('RPM'); ylabel('RPM'); title('v virkelig mot v beregna');

%% Konverer PLS modell til en redusert 2PLS modell
[w1,w2tilde,t1,tm2tilde,p2tilde,tw1tilde,tw2tilde]=my2PLS(xcal_s,ycal_s,W,A);

% %% scalerer opp loadings for å bruke i score-loading biplot
% w1=5*w1; 
% w2tilde=w2tilde;
% Ppls(:,1)=5*Ppls(:,1);
% p2tilde=p2tilde;

% %% Konfidens ellipse
% N_s=length(tw1tilde);
% %[x,y,z] = ellipsoid(xc,yc,0,xr,yr,0)
% Tucl=2*(N_s^2-1)/(N_s*(N_s-2))*6.112    % Øvre grense (99% konfidensintervall)

%% 2PLS score-loading biplot for prosessovervåkning
figure(i+4)
subplot(1,2,1); plot(t1,tm2tilde,'or');
title('X-Scoreplot'); grid;
subplot (1,2,2); plot(Ppls(:,1),p2tilde,'*');
title('X-Loadingplot'); grid;
figure(i+5)
subplot(1,2,1); plot(tw1tilde,tw2tilde,'or');
title('Ortogonal X-Scoreplot'); grid;
subplot (1,2,2); plot(Ppls(:,1),p2tilde,'*');
title('X-Loadingplot'); grid;
figure(i+6)
subplot(1,2,1); plot(t1,tm2tilde,'or');
title('X-Scoreplot'); grid;
subplot (1,2,2); plot(w1,w2tilde,'*');
title('Weighted X-Loadings plot'); grid;
figure(i+7)
subplot(1,2,1); plot(tw1tilde,tw2tilde,'or');
title('Ortogonal X-Scoreplot'); grid;
subplot (1,2,2); plot(w1,w2tilde,'*');
title('Weighted X-Loadings plot'); grid;
figure(i+8)
plot(w1,w2tilde,'*',t1,tm2tilde,'or')
grid
figure(i+9)
plot(Ppls(:,1),p2tilde,'*',tw1tilde,tw2tilde,'or')
grid