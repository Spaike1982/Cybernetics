function [Xh,Xb,Yb,Kk,Phat,Pbar,t,cal] = EKFestim(g,x0,Y,dt,tfin)

% EKFestim.m: Extendet Kalmanfiter estimation: 
% funksjon som beregner estimater av ikke m�lbare tilstander for en gitt
% tidsserie med m�ledata sortert rekkehvis i en matrise Y, slik at
% Y=[rho(k);rho(k-1);...;rho(k-N+1)]
% 
% Fuksjonsrutine
%
%   [Xh,Xb,Yb,Kk,Phat,Pbar,t] = EKFestim(g,x0,Y,dt,tfin)
%
% Andre funksjoner som kreves internt
%
%   physcheck.m - Sjekke at ikke fysiske grenser blir brutt
%   EKF.m - Beregne estimater for hvert tidsskritt
% 
% Innganger:
%   g - M�lefunksjon, rho = g(x,h)
%   x0 - initialestimat for tidsserien
%   Y - Matrise med tidsserie av m�ledata, slik at
%   Y=[rho(k);rho(k-1);...;rho(k-N+1)]
%   dt - tidsskritt mellom m�linger
%   tfin - Sluttid for m�linger
%
% Utganger:
%   Xh - Matrise med apriori estimater
%   Xb - Matrise med aposteriori estimater
%   Yb - Matrise med m�linger
%   Kk - Matrise med kalmanfilterforsterkning
%   Phat - Matrise med apriori kovarians
%   Pbar - Matrise med aposteriori kovarians
%   t - Tidsvektor
% 
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved H�gskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] Henning Winsnes, "Estimering av niv� i tre-faseseparator med
%       porfilm�ler", Masters Thesis, H�gskulen i Telemark, 2007.

% Simulasjonsparametere
t = 1:dt:tfin;
nSim = length(t);
nx = length(x0);
ny = size(Y,2);
h = 1:size(Y,2);
h = h';

% St�y
Rw = diag([1e-4,1e-4,1e-4,1e-7,1e-7,1e-6,1e-6]); % Prosesst�y korrelasjon
Rv = 1*eye(ny); % Antar ingen korrelasjon mellom m�linge

% Lagringsplass
Xb = zeros(nx,nSim);
Xh = Xb;
Yb = zeros(ny,nSim);
Kk = zeros(nx,ny*nSim);
Pbar = zeros(nx,nx*nSim);
Phat = Pbar;
cal = zeros(1,nSim);

% Estimeringsl�kke
xb = x0;
Pb = 1*eye(nx);

% Beskrankninger
xL = [0,600,950,5,6,40,41];
xH = [100,900,1200,40,41,100,101];

for k = 1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av EKF : ',num2str(p)]);
    
    % Henter m�linger
    rho = Y(k,:)';
    
    % Lagring
    Xb(:,k) = xb';                  % xb(k|k-1)
    Pbar(:,nx*k-nx+1:nx*k) = Pb;    % Pb(k|k-1)
    
    xb = physcheck(xb,xL,xH);
    rho = meascheck(rho);
    
    % Kalmanfilter
    tic;
    [xh,xb,rhob,K,Pb,Ph] = EKF(g,xb,rho,Pb,Rw,Rv,h);
    cal(k) = toc;
       
    % Lagring
    Xh(:,k) = xh';                  % xh(k|k)
    Yb(:,k) = rhob';                  % yb(k|k)
    Kk(:,ny*k-ny+1:ny*k) = K;
    Phat(:,nx*k-nx+1:nx*k) = Ph;    % Ph(k|k)
    
    rhoh = feval(g,xh,h);
    
    % Plotter estimert mot virkelige m�linger live
    figure(1)
    r = min(min(rho)):max(max(rho))+10;
    rn = length(r);
    rhot = vectorrep(xh(1:3),ny);
    hxt = vectorrep(xh(4:7),rn);
    plot(h,rho,'*',h,rhoh,h,rhot,':',hxt,r,':');
end
