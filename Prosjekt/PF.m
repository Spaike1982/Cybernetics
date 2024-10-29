function [xh,Ph,xpart] = PF(g,xpart,wm,Sw,Sv,rho,N,h)

% PF.m: Particle Filter, funksjon som beregner estimater 
% av ikke målbare tilstander. 
% 
% Fuksjonsrutine:
%
%   [xh,Ph,xpart] = PF(g,xpart,wm,vm,Sw,Sv,rho,N,h)
% 
% Innganger:
% 
%   g - Målefunksjon, rho = g(x,h)
%   xpart - Initiell partikler
%   wm - Middelverdi av prosessforstyrrelse
%   vm - Midderlverdi av målestøy
%   Sw - Cholesky faktor av prosessforstyrrelse kovariansmatrise
%   Sv - Cholesky faktor av målestøy kovariansmatrise
%   rho - Målinger
%   N - Antall partikler
%   h - Vektor med nivåpunkter, h = [1,2,...]
%
% Utganger:
% 
%   xh - aposteriori estimat av tilstandene
%   Ph - Aposteriori tilstandskovarians matrise
%   xpart - oppdaterte partikler
%
% Initiering av partikler:
%   % Antall partikler
%   N = 10;
%   % danner initiell partikler
%   S = chol(Ph)';
%   X = randn(nx,N);
%   xpart = S*X + xh*ones(1,N);
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] Wan, E. A. and van der Merwe, R. 2001. Kalman Filtering and Neural
%       Networks (Chapter 7. The Unscented Kalman Filter). John Wiley &
%       Sons.

% Dimensjoner
nw = length(wm);
ny = length(rho);

% Lager opp plass
v = zeros(ny,N);

% Sampling
s = Sw*randn(nw,N) + wm*ones(1,N);
for i = 1:N
    xpart(:,i) = xpart(:,i) + s(:,i);
    v(:,i) = rho - feval(g,xpart(:,i),h);
end

% Beregner vekter
D = size(v,1);
M = Sv\v;
C = (2*pi)^(D/2) * abs(prod(diag(Sv)));
E = -0.5 * sum(M.*M, 1);
w = exp(E) / C;           % Sannsynlighetsvektor
if w < eps % Hindrer divisjon på 0
    w = w + eps;
end
% w = E - log(C);         % log-sannsynlighet

w = w / sum(w); % Normaliser
% Neff = 1 / sum(w .^ 2);

% Resampling
len = length(w);
keep = zeros(1,len);
k = 1/len;
di = 0:k:(1-k); % deterministiske intervaller
select = di + rand(1,len) * k; % skjelving innenfor intervallet
w = cumsum(w);

ctr=1;
for i=1:len
    while ctr<=len && select(ctr)<w(i)
        keep(ctr)= i;
        ctr=ctr+1;
    end
end

%% ------------------
xpart = xpart(:,keep);

%% Finner tilstand fra middelverid
xh = sum(xpart,2)/N;

% Kovarians
Ph = (xpart*xpart'/N) - xh*xh';
