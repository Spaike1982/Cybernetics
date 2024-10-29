function [Xh,Xb,Yb,Kk,Phat,Pbar,t,cal] = SRCDKFestim(g,x0,Y,dt,tfin)

% SRCDKFestim.m: Square Root Central Difference Kalmanfilter estimation: 
% funksjon som beregner estimater av ikke målbare tilstander for en gitt
% tidsserie med måledata sortert rekkehvis i en matrise Y, slik at
% Y=[rho(k);rho(k-1);...;rho(k-N+1)]
% 
% Fuksjonsrutine
%
%   [Xh,Xb,Yb,Kk,Phat,Pbar,t] = SRCDKFestim(g,x0,Y,dt,tfin)
%
% Andre funksjoner som kreves internt
%
%   physcheck.m - Sjekke at ikke fysiske grenser blir brutt
%   SRCDKF.m - Beregne estimater for hvert tidsskritt
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
%   Phat - Matrise med apriori kovarians
%   Pbar - Matrise med aposteriori kovarians
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
nw = nx;
nv = ny;
h = 1:size(Y,2);
h = h';

% Støy
wm = zeros(nx,1);
vm = zeros(ny,1);
Rw = diag([1e-4,1e-4,1e-4,1e-7,1e-7,1e-6,1e-6]); % Prosesstøy korrelasjon
Rv = 1*eye(ny); % Antar ingen korrelasjon mellom målinge

% Lagringsplass
Xb = zeros(nx,nSim);
Xh = Xb;
Yb = zeros(ny,nSim);
Kk = zeros(nx,ny*nSim);
Pbar = zeros(nx,nx*nSim);
Phat = Pbar;
cal = zeros(1,nSim);

% Estimeringsløkke
xb = x0;
xh = xb;                            % Aposteriori estimat
Pb = 1*eye(nx);
Ph = Pb;
Sw = chol(Rw)';                     % Cholesky faktor (Sw*Sw' = Rw)
Sv = chol(Rv)';                     % Cholesky faktor (Sv*Sv' = Rv)
Sx = chol(Ph)';                     % Cholesky faktor (Sx*Sx' = Ph)

% Central difference parametere
dt=sqrt(3);                          % Step størrelse

% Beregning av vekter
hh = dt^2;
W1 = [(hh-nx-nw)/hh,1/(2*hh);1/(2*dt),sqrt(hh-1)/(2*hh)];    % Sett 1
W2 = W1;
W2(1,1) = (hh-nx-nv)/hh;

% Beskrankninger
xL = [0,600,950,5,6,40,41];
xH = [100,900,1200,40,41,100,101];

for k = 1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av SRCDKF : ',num2str(p)]);

    % Henter målinger
    rho = Y(k,:)';
    
    % Lagring
    Xb(:,k) = xb';                  % xb(k|k-1)
    Pbar(:,nx*k-nx+1:nx*k) = Pb;    % Pb(k|k-1)
    
    xh = physcheck(xh,xL,xH);
    rho = meascheck(rho);
    
    % Kalmanfilter
    tic;
    [xh,xb,rhob,K,Sx] = SRCDKF(g,xh,rho,wm,vm,Sx,Sw,Sv,W1,W2,dt,h);
    cal(k) = toc;
    
    % Tilstands kovarians
    Ph = Sx*Sx';
       
    % Lagring
    Xh(:,k) = xh';                  % xh(k|k)
    Yb(:,k) = rhob';                  % yb(k|k)
    Kk(:,ny*k-ny+1:ny*k) = K;
    Phat(:,nx*k-nx+1:nx*k) = Ph;    % Ph(k|k)
    
    rhoh = feval(g,xh,h);
   
    % Plotter estimert mot virkelige målinger live
    figure(1)
    r = min(min(rho)):max(max(rho))+10;
    rn = length(r);
    rhot = vectorrep(xh(1:3),ny);
    hxt = vectorrep(xh(4:7),rn);
    plot(h,rho,'*',h,rhoh,h,rhot,':',hxt,r,':');
end
