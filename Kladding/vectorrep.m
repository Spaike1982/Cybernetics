function m = vectorrep(v,c)

% vectorrep.m: Vector replicate, fuksjon for kopiering av vektore.
% Optimalisert med hensyn på hastighet.
%
% Funksjonsrutine:
% m = vectorrep(v,c)
%
% Innganger:
%   v - Kolonne eller rekkevektor som skal kopieres
%   r - Antall kopier
%
% Utgang:  
%   m - Resulterende matrise av dimensjon length(v) X j eller j X length(v)
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.

% Sjekker om det er rekke eller kolonnevektor
[i,j]=size(v);

if i<j
  m = v(ones(1,c),:); % Kopiering av rekkevektor
else
  m = v(:,ones(c,1)); % Kopiering av kolonnevektor
end