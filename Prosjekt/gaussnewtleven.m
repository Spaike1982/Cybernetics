function [xh,itc] = gaussnewtleven(fun,x0,h,rho,tol,maxit,xL,xH)

% gaussnewtleven.m: Funksjon som forsøker å løse et minste kvadraters problem:
%
%   min{sum(g(x,h)-rho).^2}
%    x
%   
%  Basert på følgende iterative algoritme (Gauss Newton):
% 
%   x(k+1) = x(k) - (Jg'*Jg)\Jg'*(f(x(k),h)-rho); der Jg betegner jacobimatrisen til
%   g(x(k),h).  
%   
% Fuksjonsrutine:
%
%   [x,itc] = gaussnewton(fun,x0,h,y,tol,maxit)
%
% Andre funksjoner som kreves internt
%
% Innganger:
%
%   fun - funksjon som skal beskrive data
%   x0 - Initiell gjetning på parametre
%   h - Inngangsdata for funksjonen 
%   rho - utgangstata som skal tipasses
%   tol - toleranse for endring før konvergens godtas
%   maxit - maksimalt antall iterasjoner før konvergens godtas
%
% Utganger:
%
%   x - Parametervektor som tilpasser f(x,h) til rho
%   itc - iterasjoner før konvergens.
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] Henning Winsnes, "Estimering av nivå i tre-faseseparator med
%       porfilmåler", Masters Thesis, Høgskulen i Telemark, 2007.

% Sjekker innganger
if nargin < 6
    tol = sqrt(eps);
end
if nargin < 7
    maxit = 1000;
end

% Initiering av loop
itc = 1;
xh = x0;
r = 1;
nx = length(x0);
I = eye(nx);
lambda = 0.001;

% Gauss newton Iterasjon
while norm(r) > tol
    % Hindrer at hx1 >= hx2 slik at J = NaN og estimeringe kræsjer.
    xh = physcheck(xh,xL,xH);
    % Nummerisk beregning av jacobimatrisen til g(x,h)
    J = jacobi_central(fun,1,sqrt(eps),xh,h);
    % Feil i estimat
    ef = feval(fun,xh,h) - rho;
    % Finner søkeretning
    r = -(J'*J+lambda*I)\J'*ef;
    % Oppdatering av lambda
    fp = J*rm1 + efm1;
    fk = interp1(xh,fun,xhm1,'cubic');
    if fp > fk
        lambda = lambda+(fk-fp)/alpha;
    elseif norm(ef2) < norm(ef) % Retning stemmer, reduser lambda
        lambda = lambda/(1+alpha);
    end
    % Sjekker om maks antall iterasjoner er nådd
    if itc > maxit
        disp('Ingen konvergens, øk tol eller maxit');
        break;
    end
    % Oppdater tilstandsestimat
    xh = xh + r;
    % Antall iterasjoner for før konvergens
    itc = itc+1;
end