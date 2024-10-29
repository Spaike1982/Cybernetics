function [xh,Ph,xpart] = SPPF(xpart,wm,vm,Sw,Sv,u,y,N,dt)

% PF.m: Particle Filter, funksjon som beregner estimater 
% av ikke målbare tilstander. 
% 
% Fuksjonsrutine:
%
%   [xh,Ph,xpart] = PF(xpart,wm,vm,Sw,Sv,u,y,N,dt)
% 
% Andre funksjoner som kreves internt
%
%   f.m - Tilstandsfunksjon
%   g.m - Målelining
%
% Innganger:
% 
%   xpart - Initiell partikler
%   wm - Middelverdi av prosessforstyrrelse
%   vm - Midderlverdi av målestøy
%   Rw - Prosessforstyrrelse kovariansmatrise
%   Rv - Målestøy kovariansmatrise
%   u - Pådrag
%   y - Målinger
%   N - Antall partikler
%   dt - sampletid slik at dt = k+1 - k
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
ny = length(y);

% Lager opp plass
v = zeros(ny,N);
S_part = cell(N,1);
S_part_pf = S_part;

% Predikterer partikler
for i = 1:N
    [xpart(:,i),xb,yb,K,S_part] = SRUKF(xpart(i,:),u,y,wm,vm,S_part,Sw,Sv,W,gamma,dt);
    S_part_pf{i}(:,:) = S_part;
    xpart(:,i) = xpart(:,i) + S_part*randn(nx,1);
    v(:,i) = y - g(xpart(:,i),u,vm);
end

% observe particle
D = size(v,1);
M = Sv\v;  % Sv*inv(v)
C = (2*pi)^(D/2) * abs(prod(diag(Sv)));
E = -0.5 * sum(M.*M, 1);
w = exp(E) / C; % Sannsynlighet
% w = E - log(C); % log-sannsynlighet

w = w / sum(w); % Normaliser
% Neff = 1 / sum(w .^ 2);

% Utvelgelse av relevante partikler
len = length(w);
keep = zeros(1,len);
k = 1/len;
di = 0:k:(1-k); % deterministiske intervaller
select = di + rand(1,len) * k; % peturbering innenfor intervallet
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
for i=1:N
S_part{i} = S_part_pf{keep(i)};
end

%% Finner tilstand fra middelverid
xh = sum(xpart,2)/N;

% Kovarians
Ph = (xpart*xpart'/N) - xh*xh';
