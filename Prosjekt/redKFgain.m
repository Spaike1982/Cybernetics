function [Kred,redvec,redvec2,nyred] = redKFgain(K,tol)

% Funksjon for reduksjon av kalmanfilterforsterkning kolonnehvis der like
% kolonner finnes. 

if nargin < 2
    tol = 1e-5;
end

[nx,ny] = size(K);
k = 2;
i = 1;
j = 1;
Km = zeros(nx,1);
% Looper gjennom alle elementer i K
while k <= ny
    % Sjekker for likhet i kolonner
    while and(abs(K(1:nx,k-1)./K(1:nx,k)) >= 0.90,abs(K(1:nx,k-1)./K(1:nx,k)) <= 1.10)
        % Sjekker for svak endring i kolonner
        Ktemp = K(1:nx,k);
        if and(abs(Ktemp./K(1:nx,k)) <= 0.90,abs(Ktemp./K(1:nx,k)) >= 1.10)
            break;
        end
        % Lagrer de kolonner som er like
        redvec(j) = k;
        Km = Km + (K - Km)/(k-1);
        % Tellevariable
        j = j + 1;
        k = k + 1;
    end
    % Lagrer redusert K
    Kred(1:nx,i) = K(1:nx,k-1);
    % Kolonner som er ulike
    redvec2(i) = k;
    % Tellevariable
    nyred = i;
    i = i + 1;
    k = k + 1;
end 
Kred(1:nx,i) = K(1:nx,k-1);
% NB! plot(1:ny,K) og plot(1:nyred,Kred) for å sjekke om reduksjonen er ok
