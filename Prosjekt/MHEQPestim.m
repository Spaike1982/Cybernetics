function [Xh,Xb,Yh,Phat,Pbar,t,cal] = MHEQPestim(g,x0,Y,dt,tfin)

% MHEQPestim.m: Moving Horizon Estimator Quadratic Programming estimation:
% funksjon som beregner estimater av ikke målbare tilstander for en gitt
% tidsserie med måledata sortert rekkehvis i en matrise Y, slik at
% Y=[rho(k);rho(k-1);...;rho(k-N+1)]
%
% Fuksjonsrutine
%
%   [Xh,Xb,Yb,Kk,Phat,Pbar,t] = MHEQPestim(g,x0,Y,dt,tfin)
%
% Andre funksjoner som kreves internt
%
%   matrixrep.m - Repeisjon av vektore/matriser
%   QPSE.m - Beregne estimater for hvert tidsskritt
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

% Støy kovariansmatriser
Rw = diag([1e-4,1e-4,1e-4,1e-7,1e-7,1e-6,1e-6]); % Prosesstøy korrelasjon
Rv = 1*eye(ny); % Målestøy
Px1 = 1e-2*eye(nx); % Feil mellom xh(k-N+1|k-N) og xh(k-N+1|k)

% Konstante matriser i avviksmodellen
A = eye(nx);
C = A;
F = eye(ny);

% Initiering
xb = x0;
x1 = x0;
Pb = Px1;
Ph = Px1;

% Horisont lengde
N = 3;
Ni = 2; % Initial horisont (2 i stede for 1 siden (N-1)*nw i QPSE.m)

% Initierer horisont med gamle data
rhoN = [Y(1,:)';Y(2,:)'];

% Initierer horisont med gamle estimater
zN = [matrixrep(x0,N,1,2);zeros(N*nv+(N-1)*nw,2)];

% Matriser for ulikhetsbibetingelser i tilstander
% rog <= rhoo <= rhog
% hx1 <= hx2 + 1;
% hx2 <= hx3 + 1;
% hx3 <= hx4 + 1;
Dx = [1,-1,0,0,0,0,0;
      0,1,-1,0,0,0,0;
      0,0,0,1,-1,0,0;
      0,0,0,0,1,-1,0;
      0,0,0,0,0,1,-1];
% dx = [0;0;1;1;1];

% Beskrankninger:
% xL <= x <= xH
xL = [0;500;900;5;6;40;41];
xH = [100;1000;1200;40;41;100;101];
% vL <= v <= vH
vL = vectorrep(-inf,nv)';
vH = vectorrep(inf,nv)';
% wL <= w <= wH
wL = vectorrep(-inf,nw)';
wH = vectorrep(inf,nw)';

% Lagringsplass
Xb = zeros(nx,nSim);
Xh = Xb;
Yh = zeros(ny,nSim);
Pbar = zeros(nx,nx*nSim);
Phat = Pbar;
cal = zeros(1,nSim);

% Estimeringsløkke
for k = 2:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av MHE : ',num2str(p)]);

    % Henter målinger
    rho = Y(k,:)';
    
    % Sjekker beskrankninger på målingene
    rho = meascheck(rho);

    % Lagring
    Pbar(:,nx*k-nx+1:nx*k) = Pb;    % Pb(k|k-1)

    % Arbeidspunkt for lineærisert avviksmodell
    xs = xb;
    rhos = feval(g,xs,h);
    
    % Lineærisering av måleligning
    D = jacobi_central(g,1,sqrt(eps),xs,h);
    
    % Beskrankninger (må økes inntil k < N)
    zL = [matrixrep(xL,Ni,1,1);matrixrep(vL,Ni,1,1);matrixrep(wL,Ni-1,1,1)];
    zH = [matrixrep(xH,Ni,1,1);matrixrep(vH,Ni,1,1);matrixrep(wH,Ni-1,1,1)];
    
    % Må benytte avviksvariable siden en avvikmodell benyttes i QPSE
    % Avviksvariable
    dx1 = x1 - xs; % x1 = xh(k-N+1|k-N), dvs prediksjon
    drhoN = rhoN - matrixrep(rhos,Ni,1,1);
    dzL = zL - [matrixrep(xs,Ni,1,1);zeros(Ni*nv+(Ni-1)*nw,1)];
    dzH = zH - [matrixrep(xs,Ni,1,1);zeros(Ni*nv+(Ni-1)*nw,1)];
    
    % Ulikhetsbibetingelser avhenger også av arbeidspunkt
    ddx = [xs(2)-xs(1);xs(3)-xs(2);-1-xs(4)+xs(5);-1-xs(5)+xs(6);-1-xs(6)+xs(7)];

    % QP formulering og løsning
    tic;
    dz = QPSE(A, C, D, F, Rw, Rv, Px1, dx1, drhoN, Ni, Dx, ddx, dzL, dzH);
    cal(k) = toc;
    
    % Legger til arbeidspunkt på avviksestimater
    z = dz + [matrixrep(xs,Ni,1,1);zeros(Ni*nv+(Ni-1)*nw,1)];
    
    % Initialtilstand. 
    xh1 = zN(1:nx,Ni);  % xb1 = xh(k-N+1|k-N+1)
    xb1 = xh1; % + E(w);% Prediksjon xb1 = f(xh1), slik at xb1(k-N+2|k-N+1)
    x1 = xb1;           % setter initialestimat for neste tidskritt
    
    % Plukker ut aktuellt estimat fra horisont
    xh = z(1:nx);
    xb = xh;
        
    % Estimerte målinger (Kun for plotting)
    rhoh = feval(g,xh,h);

    % Lagring
    Xh(:,k) = xh';                  % xh(k|k)
    Yh(:,k) = rhoh';                % yb(k|k)
    Phat(:,nx*k-nx+1:nx*k) = Ph;    % Ph(k|k)

    % Plotter estimert mot virkelige målinger live
    figure(1)
    r = min(min(rho)):max(max(rho))+10;
    rn = length(r);
    rhot = vectorrep(xh(1:3),ny);
    hxt = vectorrep(xh(4:7),rn);
    plot(h,rho,'*',h,rhoh,h,rhot,':',hxt,r,':');
    
    % Oppdaterer horisont
    if k < N % Øker horisont inntil k < N (intiellt)
        rhoN = [rho;rhoN];  % Horisont med målinger
        zN = [[z;zeros(size(zN,1)-size(z,1),1)],zN];  % Horisont med estimater
        Ni = Ni + 1;        %Øker horisont
    else  % Gidende horisont for k >= N
        rhoN = [rho;rhoN(1:end-ny)]; % Horisont med målinger
        zN = [z,zN(:,1:end-1)];      % Horisont med estimater
    end
end