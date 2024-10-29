%% PCR modellering
% Danner en PCR modell av data fra dokument
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

[T,P,E,Bpcr,b0pcr,RMSEPpcr,RMSECpcr,X_pcr,Y_pcr,pk]=myPCR(xcal,ycal,xval,yval);

%% Plotter residuale mot virkelige data for å sjekke om valg av antall PC
%% var fornuftig
for i = 1:size(xcal,2)
    figure(i); plot([X_pcr(:,i),E(:,i)]);
    legend('Variabel','Residuale')
    title(['Residuale mot data for variabel nr: ',num2str(i)])
end

%% Plotter regresjonskoeffisienter
figure(i+1); plot(Bpcr);
title('Regressjonskoeffisienter')

%% Plotter prediksjonsevne
figure(i+2); plot([v,xval*Bpcr+b0pcr]);
legend('Virkelig utgang','Esimert utgang'); ylabel('RPM'); title('Virkelig og beregnet utgang');
figure(i+3); plot(v,xval*Bpcr+b0pcr,'.',v,v);
legend(['RMSEP = ',num2str(RMSEPpcr)],'target line'); xlabel('RPM'); ylabel('RPM'); title('v virkelig mot v beregna');

%% Plotting av PC mot PC i score og loadingplot for dataanalyse,
% Loadings viser sammenhenger mellom variable, scores viser sammenhenger
% mellom datasampler
r = i+4;
for ii = 1:pk
    for j = 1:pk
        if ii ~= j && j > ii
        figure(r)
        subplot(211)
        plot(T(:,ii),T(:,j),'o')
        xlabel(['PC ',num2str(ii)]); ylabel(['PC ',num2str(j)])
        title('Scoreplot')
        subplot(212)
        plot(P(:,ii),P(:,j),'o')
        xlabel(['PC ',num2str(ii)]); ylabel(['PC ',num2str(j)])
        title('Loadingplot')
        r = r + 1;
        end
    end
end