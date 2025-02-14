%% Dannelse av dynamisk modell for Troll A Precompression
% Dette skriptet danner regressjonsmodeller basert p� data fra prosess.
% De ulike modelltypene konverteres ogs� til tistandsrommodell for
% simulering.
%
% De fleste fuksjoner brukt til � danne modellene er tilgjengelig for
% redigering og kompilering

clear;clc;

%% Laster inn data
% Data er hentet fra dokument AO-0100-M-KV-005 side 2.4
data=load('C:\Documents and Settings\Administrator\My Documents\Jobb\Erbus\Henning W\Troll A Precompression\data.txt');
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
W=data(:,6);
% Polytropic Head [kJ/kg]
P_h=data(:,7);

%% Systemidentifikasjon

% Definerer innganger u og utganger y for systemet.
u=[p_s,p_d,m_dot,V_dot,W,P_h]; y=v;
N=length(y);

% Ordinary Least Squares (OLS)
Bols = pinv(u'*u)*u'*y;
y_ols = u*Bols;

% Ridge Regression (RR)
I=eye(size(y,2));
% Velger g slik at O = (y-y_rr)'*(y-y_rr) minimaliseres
O = @(g)(y-u*pinv(u'*u+g*I)*u'*y)'*(y-u*pinv(u'*u+g*I)*u'*y);
g = fminsearch(O,1);
Brr=pinv(u'*u+g*I)*u'*y;
y_rr=u*Brr;

% Principial Component Regression. NB! se myPCR for egen fuksjon
% Bpcr = V(:,1:a)*pinv(S(1:a,1:a))*U(:,1:a)'*Y
a = 4; % gir
[U S V]=svd(u);
Bpcr = V(:,1:a)*pinv(S(1:a,1:a))*U(:,1:a)'*y;
y_pcr = u*Bpcr;


% Partial Least Squares (PLS)
% Ka = Cn = [B,AB,A^2B,...,A^(n-1)B] for A=X'X og B=X'Y
% A = 4 gir
% X=u; Y=y;
% Ka=[X'*Y, X'*X*X'*Y, (X'*X)^2*X'*Y, (X'*X)^3*X'*Y];    
% Bpls=Ka*inv(Ka'*X'*X*Ka)*Ka'*X'*Y;
% y_pls=X*Bpls;

% NB! bruker myPLS.m for alternativ metode, da foreg�ende metoden ga d�rlig
% modell
[T,Ppls,Qt,W,E,Bpls,b0pls,RMSECpls,RMSEPpls,xcal_s,ycal_s,pk]=myPLS(u,y,u,y);
y_pls=u*Bpls+b0pls;

% Deterministic and Stochastic system identification and Realization (DSR)
figure(1);
[a_dsr,b_dsr,d_dsr,e_dsr,cf_dsr,f_dsr,x0_dsr]=dsr(y,u,1,0);
c_dsr = cf_dsr*inv(f_dsr);
y_dsropt = dsropt(a_dsr,b_dsr,d_dsr,e_dsr,cf_dsr,f_dsr,y,u,x0_dsr);
y_dsr = dlsim(a_dsr,b_dsr,d_dsr,e_dsr,u,x0_dsr);

% % Matlabs Prediciton error method (PEM)
% th0=canstart([y u],1,6); % estimere initial modell
% th=pem([y u],th0); % identifisere med PEM
% [a_pem,b_pem,d_pem,e_pem,k_pem,x0_pem]=th2ss(th);
% y_pem=dlsim(a_pem,b_pem,d_pem,e_pem,u,x0_pem);

% Auto Regressive with eXtra inputs (ARX) 
na=1; nb=[1,1,1,1,1,1]; nk=[0,0,0,0,0,0];
th_arx=arx([y u],[na,nb,nk]);
[a_arx,b_arx,d_arx,e_arx,c_arx]=th2ss(th_arx);
ym_arx=dlsim(a_arx,b_arx,d_arx,e_arx,u);

% Auto Regressive Moving Average with eXtra inputs (ARMAX)
na=1; nb=[1,1,1,1,1,1]; nc=1; nk=[0,0,0,0,0,0];
th_armax=armax([y u],[na,nb,nc,nk]);
[a_armax,b_armax,d_armax,e_armax,c_armax]=th2ss(th_armax);
ym_armax=dlsim(a_armax,b_armax,d_armax,e_armax,u);

% Output Error (OE)
nb=[1,1,1,1,1,1]; nf=[0,0,0,0,0,0]; nk=[0,0,0,0,0,0]; 
th_oe=oe([y u],[nb,nf,nk]);
[a_oe,b_oe,d_oe,e_oe,c_oe,x0_oe]=th2ss(th_oe);
ym_oe=dlsim(a_oe,b_oe,d_oe,e_oe,u,x0_oe);

% Analyse av prediksjonevne og stabilitet

% Egenverdier m� v�re innenfor enhetssirkelen for et stabilt diskret sys.
ev_dsr = eig(a_dsr)
ev_arx=eig(a_arx)
ev_armax=eig(a_armax)
ev_oe=eig(a_oe)

% Prediksjonfeilkriterium
Vn_ols=sum((y-y_ols)'*(y-y_ols))
Vn_rr=sum((y-y_rr)'*(y-y_rr))
Vn_pcr=sum((y-y_pcr)'*(y-y_pcr))
Vn_pls=sum((y-y_pls)'*(y-y_pls))
Vn_dsr=sum((y-y_dsr)'*(y-y_dsr))
Vn_dsropot=sum((y-y_dsropt)'*(y-y_dsropt))
Vn_arx=sum((y-ym_arx)'*(y-ym_arx))
Vn_armax=sum((y-ym_armax)'*(y-ym_armax))
Vn_oe=sum((y-ym_oe)'*(y-ym_oe))

% Gennomsnittelig prediksjonfeil
RMSEP_ols=sqrt(1/N*sum((y-y_ols).^2))
RMSEP_rr=sqrt(1/N*sum((y-y_rr).^2))
RMSEP_pcr=sqrt(1/N*sum((y-y_pcr).^2))
RMSEPpls
RMSEP_dsr=sqrt(1/N*sum((y-y_dsr).^2))
RMSEP_dsropt=sqrt(1/N*sum((y-y_dsropt).^2))
RMSEP_arx=sqrt(1/N*sum((y-ym_arx).^2))
RMSEP_armax=sqrt(1/N*sum((y-ym_armax).^2))
RMSEP_oe=sqrt(1/N*sum((y-ym_oe).^2))

%% Plotting av prediksjoner av y mot virkelig y.
figure(2)
plot([y y_ols]), title('Virkelig og estimert y')
legend('Virkelig','OLS')

figure(3)
plot([y y_rr]), title('Virkelig og estimert y')
legend('Virkelig','RR')

figure(4)
plot([y y_pcr]), title('Virkelig og estimert y')
legend('Virkelig','PCR')

figure(5)
plot([y y_pls]), title('Virkelig og estimert y')
legend('Virkelig','PLS')

figure(6)
plot([y y_dsr]), title('Virkelig og estimert y')
legend('Virkelig','DSR')

figure(7)
plot([y y_dsropt]), title('Virkelig og estimert y')
legend('Virkelig','DSRopt')

figure(8)
plot([y ym_arx]), title('Virkelig og estimert y')
legend('Virkelig','ARX')

figure(9)
plot([y ym_armax]), title('Virkelig og estimert y')
legend('Virkelig','ARMAX')

figure(10)
plot([y ym_oe]), title('Virkelig og estimert y')
legend('Virkelig','OE')

