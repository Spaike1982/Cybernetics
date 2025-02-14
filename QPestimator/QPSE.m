function z = QPSE(A, C, D, F, Rw, Rv, Px1, x1, rhoN, N, Dx, dx, zL, zH)
% QPSE.m: Quadratic Program State Estimator, funksjon som beregner estimater 
% av ikke m�lbare tilstander. 
%
% Med et kvadratisk kriterie:
%   V = 1/2*z'*H*z + c' + kappa
% 
% Og tilh�rende bibetingelser:
%
% Likhetsbibetingelser er i form av en LTI modell
%   x(k+1) = Ax(k) + Cw(k)
%   y(k) = Dx(k) + Fv(k)
% 
% Ulikhetsbibetingelser for tilstandsvektoren
%   Dx <= dx
%
% Beskrankningene
% zL<=z<=zH
% 
% Fuksjonsrutine:
%
%   z = QPSE(A, B, C, D, E, F, Qw, Qv, Qx1, x1, yN, uN, N, zL, zH)
% 
% Innganger:
% 
%   A, C,D,F - Modellmatriser i en line�r diskret tilstandsrommodell
%   Rw - prosessforstyrrelse kovarians
%   Rv - m�lest�y kovarians 
%   Px1 - Initiell kovarians for feil i tilstandsestimat
%   x1 - Initiellt tilstandsestimat
%   rhoN - Horisont av N gamle m�linger, rhoN = [rho(k-N+1),...,rho(k)]
%   N - Horisont lengde
%   Dx - Matrise for ulikhetsbibetingelser mellom tilstander
%   dx - Vektor for ulikhetsbibetingelser mellom tilstander
%   zL - Nedre beskrankninger for z
%   zH - �vre beskrankninger for z
%
% Utganger:
% 
%   z - Optimale verdier, 
%   z = (x(k)',...,x(k-N+1)',v(k)',...,v(k-N+1)',w(k-1)',....w(k-N+1)')'
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved H�gskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] Henning Winsnes, "Estimering av niv� i tre-faseseparator med
%       porfilm�ler", Masters Thesis, H�gskulen i Telemark, 2007.

% Definerer hjelpest�rrelser
nx = size(A,1); % Antall tilstander
ny = size(D,1); % Antall utganger
nw = size(C,1); % Antall prosessforstyrrelser
nv = size(F,1); % Antall m�leforstryrrelser
nI = size(Dx,1); % Antall ulikhetsbibetingelser
IN = eye(N);    % N x N Identitetsmatrise
INm1 = eye(N-1); % (N-1) x (N-1) Identitetsmatrise
INm1N = eye(N-1,N); % (N-1) x N matrise med enere langs diagonalen og 0 ellers
Ixx = eye(nx); % (N*nx x N*nx) Identitetsmatrise
ZIz = zeros(N*nI,N*nv+(N-1)*nw); % N*ny+(N-1)*nx X N*(nx+nv)+(N-1)*nw tom matrise
Zvw = zeros(N*nv+(N-1)*nw,1); % N*ny+(N-1)*nw x 1 tom matrise
Zxm1 = zeros((N-1)*nx,1); % (N-1)*nx x 1 tom matrise
Zxxm1 = zeros((N-1)*nx); % (N-1)*nx x (N-1)*nx tom matrise
Zywm1 = zeros(N*ny,(N-1)*nw); % N*ny x (N-1)*nw tom matrise
Zxm1y = zeros((N-1)*nx, N*ny); % (N-1)*nx x N*ny tom matrise
M = diag(ones(1,N-1),1); % N x N matrise med enere over diagonalen og 0 ellers
INm1N_1 = M(1:N-1,1:N); % (N-1) x N matrise med enere over diagonalen og 0 ellers

% Vektmatriser
Qx1 = inv(Px1); Qw = inv(Rw); Qv = inv(Rv);

% Definerer matrisen H og vektoren c' for kriteriefunskonen p� QP form
% J = 1/2*z'*H*z + c'*z
H = blkdiag(Zxxm1,Qx1,kron(IN,Qv),kron(INm1,Qw));
c = [Zxm1;-Qx1*x1;Zvw];

% Definerer matrisene i likhetsbibetingelsene p� QP form
% Ae*z = be
% Ae = [Aey; Aex]
% be = [bey; bex]
Aey = [kron(IN,D), kron(IN,F), Zywm1];
Aex = [kron(INm1N,Ixx)-kron(INm1N_1,A),Zxm1y, -kron(INm1,C)];
% 
bey = rhoN(1:N*ny);
bex = Zxm1;
%
Ae = [Aey; Aex];
be = [bey; bex];

% Denfinerer matrisene i ulikhetsbibetingelsene p� QP form
% AI*z <= bI
AI = [kron(IN,Dx),ZIz];
bI = kron(ones(N,1),dx);

% Optimering med quadprog.
z = quadprog(H, c, AI, bI, Ae, be, zL, zH);