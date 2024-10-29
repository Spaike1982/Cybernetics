function [Xh,Xb,Yh,t,cal] = lsqgauss(g,x0,Y,dt,tfin)

% lsqgauss.m: curve estimation: 
% funksjon som beregner estimater av ikke målbare tilstander for en gitt
% tidsserie med måledata sortert rekkehvis i en matrise Y, slik at
% Y=[rho(k);rho(k-1);...;rho(k-N+1)]
% 
% Fuksjonsrutine
%
%   [Xh,Xb,Yb,t] = curveestim(g,xb,Y,dt,tfin)
%
% Andre funksjoner som kreves internt
%
%   physcheck.m - Sjekke at ikke fysiske grenser blir brutt
%   gaussnewton.m - Beregne estimater for hvert tidsskritt
% 
% Innganger:
%   g - Målefunksjon, rho = g(x,h)
%   x0 - initialestimat for tidsserien
%   Y - Matrise med tidsserie av måledata, slik at
%   Y=[rho(k);rho(k-1);...;rho(k-N+1)]
%   dt - tidsskritt mellom målinger
%   tfin - Sluttid for målinger
%
% Utganger:
%   Xh - Matrise med apriori estimater
%   Xb - Matrise med aposteriori estimater
%   Yb - Matrise med målinger
%   t - Tidsvektor
% 
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] Henning Winsnes, "Estimering av nivå i tre-faseseparator med
%       porfilmåler", Masters Thesis, Høgskulen i Telemark, 2007.

% Simulasjonsparametere
t = 1:dt:tfin;
nSim = length(t);
nx = length(x0);
ny = size(Y,2);
h = 1:ny;
h = h';

% Initierer
xb = x0;

% Lager opp plass for lagring
Xb = zeros(nx,nSim);
Xh = Xb;
Yh = zeros(ny,nSim);
cal = zeros(1,nSim);

% Beskrankninger
xL = [0,600,950,5,6,40,41];
xH = [100,900,1200,40,41,100,101];

for k = 1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av Gauss Newton : ',num2str(p)]);
    
    % Hent ut målinger
    rho = Y(k,:)';
    
    % Lagrer tilstandsprediksjoner
    Xb(:,k) = xb';
    
    % Sjekker at ikke fysiske grenser blir brutt
    xb = physcheck(xb,xL,xH);
    rho = meascheck(rho);
    
    % Optimerer
    %xh = gaussnewtleven(g,xb,h,rho,0.1,50,xL,xH);
    tic;
    xh = gaussnewton(g,xb,h,rho,0.1,50,xL,xH);
    cal(k) = toc;
    
    % Beregner estimerte målinger
    rhoh = feval(g,xh,h);
    
    % Lagrer estimater
    Yh(:,k) = rhoh';
    Xh(:,k) = xh';
    xb = xh;
    
    % Plotter estimert mot virkelige målinger live
    figure(1)
    r = min(min(rho)):max(max(rho))+10;
    rn = length(r);
    rhot = vectorrep(xh(1:3),ny);
    hxt = vectorrep(xh(4:7),rn);
    plot(h,rho,'*',h,rhoh,h,rhot,':',hxt,r,':');
end