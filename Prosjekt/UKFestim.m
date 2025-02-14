function [Xh,Xb,Yb,Kk,Phat,Pbar,t,cal] = UKFestim(g,x0,Y,dt,tfin)

% UKFestim.m: Unscented Kalmanfilter estimation: 
% funksjon som beregner estimater av ikke m�lbare tilstander for en gitt
% tidsserie med m�ledata sortert rekkehvis i en matrise Y, slik at
% Y=[rho(k);rho(k-1);...;rho(k-N+1)]
% 
% Fuksjonsrutine
%
%   [Xh,Xb,Yb,Kk,Phat,Pbar,t] = UKFestim(g,x0,Y,dt,tfin)
%
% Andre funksjoner som kreves internt
%
%   physcheck.m - Sjekke at ikke fysiske grenser blir brutt
%   UKF.m - Beregne estimater for hvert tidsskritt
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
nw = nx;
nv = ny;
h = 1:size(Y,2);
h = h';

% St�y
wm = zeros(nx,1);
vm = zeros(ny,1);
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
xh = xb;                            % Aposteriori estimat
Pb = 1*eye(nx);
Ph = Pb;
Sw = chol(Rw)';                     % Cholesky faktor (Sw*Sw' = Rw)
Sv = chol(Rv)';                     % Cholesky faktor (Sv*Sv' = Rv)

% Unscented transformasjon parametere
L = nx + nw + nv;                   % Antall sigma punkter
kappa = 0;                          % UKF sekund�r skalerings parameter
alpha = 1e-3;                       % UKF skalerings faktor
beta = 2;                           % UKF kovarians korreksjons faktor,                                    % beta = 2 ): Antar normalforelt st�y

% Beregning av vekter
lambda = alpha^2*(L+kappa)-L;
gamma = sqrt(L+lambda);
W = [lambda 0.5 0]/(L+lambda);      % Sigma punkt vekter
W(3) = W(1)+1-alpha^2+beta;

% Beskrankninger
xL = [0,600,950,5,6,40,41];
xH = [100,900,1200,40,41,100,101];

for k = 1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av UKF : ',num2str(p)]);
    
    % Henter m�linger
    rho = Y(k,:)';
    
    % Lagring
    Xb(:,k) = xb';                  % xb(k|k-1)
    Pbar(:,nx*k-nx+1:nx*k) = Pb;    % Pb(k|k-1)
    
    xh = physcheck(xh,xL,xH);
    rho = meascheck(rho);
    
    % Kalmanfilter
    tic;
    [xh,xb,rhob,K,Pb,Ph] = UKF(g,xh,rho,wm,vm,Ph,Sw,Sv,W,gamma,h);
    cal(k) = toc;
       
    % Lagring
    Xh(:,k) = xh';                  % xh(k|k)
    Yb(:,k) = rhob';                  % yb(k|k)
    Kk(:,ny*k-ny+1:ny*k) = K;
    Phat(:,nx*k-nx+1:nx*k) = Ph;    % Ph(k|k)
    
    % Plotting
    rhoh = feval(g,xh,h);
    % Plotter estimert mot virkelige m�linger live
    figure(1)
    r = min(min(rho)):max(max(rho))+10;
    rn = length(r);
    rhot = vectorrep(xh(1:3),ny);
    hxt = vectorrep(xh(4:7),rn);
    plot(h,rho,'*',h,rhoh,h,rhot,':',hxt,r,':');
end
