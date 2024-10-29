function [Xh,Xb,Yb,Phat,Pbar,t] = MHEQPestim(g,x0,Y,dt,tfin)

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

% Støy
Rw = 1e-8*eye(nx); % Korrelasjon mellom prosesstøy
Rv = 1*eye(ny); % Antar ingen korrelasjon mellom målinger

% Arbeidspunkter
xs = x0;
rhos = feval(g,xs,h);

% Konstante matriser i avviksmodellen
A = eye(nx);
C = A;
F = eye(ny);
D = jacobi_central(g,1,sqrt(eps),xs,h);

% Initierer tilstand og kovarians
x1 = x0;
Pb = 1*eye(nx);
Ph = Pb;
Px1 = Ph;

% Horisont lengde
N = 10;

% Initierer horisonter med N gamle data
drhoN = zeros(N*ny,1);
for i = 1:N
    drhoN(i*ny-ny+1:i*ny) = Y(i,1:ny)'-rhos;
end

% Ulikhetsbibetingelser
Dx = [1,-1,0,0,0,0,0;
      0,1,-1,0,0,0,0;
      0,0,0,-1,1,0,0;
      0,0,0,0,-1,1,0;
      0,0,0,0,0,-1,1];
dx = [0;0;1;1;1];

% Beskrankninger
xL = [0;600;950;5;6;40;41]-xs;
xH = [50;900;1200;40;41;100;101]-xs;
% 
zL = [xL;vectorrep(-1000,nv)';vectorrep(-1000,nw)'];
zH = [xH;vectorrep(1000,nv)';vectorrep(1000,nw)'];
% zL = [1;600;900;2;3;4;5;vectorrep(-10,nv)';vectorrep(-10,nw)'];
% zH = [50;800;1200;50;51;100;101;vectorrep(10,nv)';vectorrep(10,nw)'];
zLow = [matrixrep(zL(1:nx),N,1,1);
    matrixrep(zL(nx+1:nx+nv),N,1,1);
    matrixrep(zL(nx+nv+1:nx+nv+nw),N-1,1,1)];
zHigh = [matrixrep(zH(1:nx),N,1,1);
    matrixrep(zH(nx+1:nx+nv),N,1,1);
    matrixrep(zH(nx+nv+1:nx+nv+nw),N-1,1,1)];

% Lagringsplass
Xb = zeros(nx,nSim);
Xh = Xb;
Yb = zeros(ny,nSim);
Pbar = zeros(nx,nx*nSim);
Phat = Pbar;

for k = N+1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av MHE : ',num2str(p)]);
   
    % Henter målinger
    rho = Y(k,:)';

    % Lagring
    Pbar(:,nx*k-nx+1:nx*k) = Pb;    % Pb(k|k-1)

    % avviksvariable
    dx1 = x1 - xs;

    % QP formulering og løsning
    dz = QPSE(A, C, D, F, Rw, Rv, Px1, dx1, drhoN, N, Dx, dx, zLow, zHigh);

    drho = rho - rhos;
    
    % Oppdaterer glidende horisont
    drhoN = [drho;drhoN(1:end-ny)]; 
    
    % Oppdaterer intialtilstand (tror dette er feil)
    dx1 = dz(N*nx-nx+1:N*nx);
    
    % Oppdaterer kovarians
    %Px1 = Px1/2; % Dette funker dårlig
        
     % Plukker ut aktuellt estimat fra horisont
    dxh = dz(1:nx);
    
    % Avviksvariable
    xh = dxh + xs;
    x1 = dx1 + xs;

    % Estimerte målinger (Kun for plotting)
    rhoh = feval(g,xh,h);

    % Lagring
    Xh(:,k) = xh';                  % xh(k|k)
    Yb(:,k) = rhoh';                  % yb(k|k)
    Phat(:,nx*k-nx+1:nx*k) = Ph;    % Ph(k|k)

    % Plotting live
    figure(1)
    plot(h,rho,'*',h,rhoh);
end