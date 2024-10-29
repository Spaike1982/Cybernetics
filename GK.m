function [U,V,D,EV,ED,i] = GK(X,c,la,rho,gamma,beta,eps,maxit)
% GK.m:
%   Funksjon som finner grupperinger i data basert på Gustafson-Kessel
%   algoritmen.
%
% Funksjonsrutine:
%   [U,V,D,EigVect,EigVal,i] = GK(X,c,la,rho,gamma,beta,eps,maxit)
% Input:
%   X - Datamatrise med n sampler og N variable Z(n,N)
%   c - Antatt antall cluster sentere
%   la - Fuzzy faktor, m > 1.
%   rho - volum av clustere. rho(c,1)
%   gamma - Skalering av cluster kovarians 0<=gamma<=1
%   beta - Grense for singulær kovariansmatrise min(ev)/max(ev)
%   eps - Konvergens toleranse
%   maxit - Maksimalt antall iterasjoner
% Output:
%   U - Matrise med tilhørliget av punkter til cluster sentere, U(c,N)
%   V - Matrise med estimerte cluster sentere, V(n,c)
%   D - Matrise med avstander mellom sentere og variable, D(c,N)
%   ED - Cluster egenvektorer
%   EV - Cluster egenverdier
%   l - Antall iterasjoner for konvergens
%
% Referanser
%   Fuzzy clustering toolbox
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med estimering av nivå og
%   tetthet i trefase separator basert på profilmålinger
%   Fredrikstad, Mai 2008.
%

%checking the parameters given
[n,m] = size(X);
X1 = ones(n,1);     % Enhetsvektor

%% Initialiserer fuzzy partisjonsmatrise

% Genererer c random cluster sentere
rand('state',0);
mm = mean(X);
aa = max(abs(X - ones(n,1)*mm));
V = 2*(ones(c,1)*aa).*(rand(c,m)-0.5) + ones(c,1)*mm;

% Finner avstander mellom data og cluster sentere
for j = 1 : c,
    XV = X - X1*V(j,:);
    D(:,j) = sum((XV.^2),2);
end

% Finner initiell tiløriget av punkter til cluster sentere (grad av deltagelse)
D = (D+1e-10).^(-1/(la-1));         % +1e-10 sørger for at avstand aldri blir 0
U = (D ./ (sum(D,2)*ones(1,c)));

% "Identitesmatrise" for skalering av cluster kovarians
A0 = eye(m)*det(cov(X)).^(1/m);

% Iterer
for i = 1:maxit
    % Beregner sentere
    Um = U.^m; sumU = sum(Um);
    V = (Um'*X)./(sumU'*ones(1,m));

    % Looper gjennom clustere
    for j = 1 : c
        % Sentrerer cluster data
        XV = X - X1*V(j,:);
        
        % Beregner kovariansmatrise per cluster
        A = ones(m,1)*Um(:,j)'.*XV'*XV/sumU(j);
        % Legger til en skalert identitetsmatrise 
        A =(1-gamma)*A + gamma*(A0.^(1/m));
        
        % Sjekker for singulæritet i A og korrigerer
        if cond(A)> beta
            [ev,ed]=eig(A); 
            edmax = max(diag(ed));
            ed(beta*ed < edmax) = edmax/beta;
            A = ev*diag(diag(ed))*inv(ev);
        end

        % Beregn avstander (D^2)
        M = (1/det(pinv(A))/rho(j))^(1/m)*pinv(A);
        D(:,j) = sum((XV*M.*XV),2);
    end
    % Avstandsmatrise
    D = sqrt(D);
    
    % Oppdater deltagelsesmatrise
    Uold = U;
    D = (D+1e-10).^(-1/(la-1));     % +1e-10 sørger for at avstand aldri blir 0
    U = (D ./ (sum(D,2)*ones(1,c)));
    
    % Sjekker for konvergens
    if max(max(Uold-U)) < eps
        break;
    end
end

%% Beregn egenskaper for alle clustere
Um = U.^m; sumU = sum(Um);
W = zeros(m,m,c);       % Kovariansmatriser
M = W;                  % Norm-inducing matriser
ED = zeros(c,m);        % Egenverdier
EV = V;                 % Egenvektorer

% itererer gjennom clustere
for j = 1 : c
    % Sentrerer
    XV = X - ones(n,1)*V(j,:);
    % Beregn kovariansmatriser
    A = ones(m,1)*Um(:,j)'.*XV'*XV/sumU(j);
    % Beregn egenverider og egenvektorer
    [ev,ed] = eig(A); ed = diag(ed)';
    ev = ev(:,ed == max(ed));
    % Lagrer info for alle clustere
	W(:,:,j) = A;
    M(:,:,j) = (det(A)/rho(j)).^(1/m)*pinv(A);
    EV(j,:) = ev';
    ED(j,:) = ed;
end