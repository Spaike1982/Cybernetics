function [Xh,Xb,Yh,Phat,Pbar,t] = PFestim(g,x0,Y,dt,tfin)

% PFestim.m: Particle Filter estimation: 
% funksjon som beregner estimater av ikke m�lbare tilstander for en gitt
% tidsserie med m�ledata sortert rekkehvis i en matrise Y, slik at
% Y=[rho(k);rho(k-1);...;rho(k-N+1)]
% 
% Fuksjonsrutine
%
%   [Xh,Xb,Yb,Kk,Phat,Pbar,t] = PFestim(g,x0,Y,dt,tfin)
%
% Andre funksjoner som kreves internt
%
%   physcheck.m - Sjekke at ikke fysiske grenser blir brutt
%   PF.m - Beregne estimater for hvert tidsskritt
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
h = 1:size(Y,2);
h = h';

% St�y
wm = zeros(nx,1);
Rw = 1*eye(nx); % Prosesst�y korrelasjon
Rv = 1*eye(ny); % Antar ingen korrelasjon mellom m�linge

% Lagringsplass
Xb = zeros(nx,nSim);
Xh = Xb;
Yh = zeros(ny,nSim);
Pbar = zeros(nx,nx*nSim);
Phat = Pbar;

% Estimeringsl�kke
xb = x0;
xh = xb;                            % Aposteriori estimat
Pb = 10*eye(nx);
Ph = Pb;
Sw = chol(Rw)';                     % Cholesky faktor (Sw*Sw' = Rw)
Sv = chol(Rv)';                     % Cholesky faktor (Sv*Sv' = Rv)
Sx = chol(Ph)';

% danner initiell partikler
N = 10;                             % Antall partikler         
Xp = randn(nx,N);
xpart = Sx*Xp + xh*ones(1,N);

% Beskrankninger
xL = [0,600,950,5,6,40,41];
xH = [50,900,1200,40,41,100,101];

for k = 1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av PF : ',num2str(p)]);
   
    % Henter m�linger
    rho = Y(k,:)';
    
    % Lagring
    Xb(:,k) = xb';                  % xb(k|k-1)
    Pbar(:,nx*k-nx+1:nx*k) = Pb;    % Pb(k|k-1)
    
    for i=1:N
    xpart(:,i) = physcheck(xpart(:,i),xL,xH);
    end
    % Kalmanfilter
    [xh,Ph,xpart] = PF(g,xpart,wm,Sw,Sv,rho,N,h);   
    
    % Lagring
    Xh(:,k) = xh';                  % xh(k|k)
    Yh(:,k) = rhoh';                  % yb(k|k)
    Phat(:,nx*k-nx+1:nx*k) = Ph;    % Ph(k|k)
    
    rhoh = feval(g,xh,h);
    
    % Plotting
    figure(1)
    plot(h,rho,'*',h,rhoh);
end
