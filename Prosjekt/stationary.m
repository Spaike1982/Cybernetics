function [xs,i] = stationary(fun,x0,dt,varargin)

% stationary.m: Funksjon som finner stasjonær tilstand ved et gitt pådrag
% og forstyrrelse, slik at x(k+1) = x(k). Kan f.eks brukes til å finne
% arbeidspunkt i forbindelse med lineærisering. Basert på simulajson
%
% Fuksjonsrutine
%
%   [xs,ys,i] = stationary(x0,us,wm,vm,tstat,dt)
%
% Andre funksjoner som kreves internt
%
%   f.m - Tilstandsfunksjon
%   g.m - Målelining
%
% Innganger:
%
%   fun - ODE funksjon
%   x0 - Initialtilstand
%   dt - Tidskritt for simulering slik at dt = k+1 - k
%   varargin - eventuelle stasjonær verdier i fun, som f.eks
%   pådrag u, f = fun(x,u).
%
%
% Utganger:
%
%   i - Antall tidskritt før steady state nåes
%   xs - Stasjonær tilstand
% 
% Merknad:
%
% Hvis mulig benytt analytiske uttrykk for å finne stasjonær verdier, f.eks
% df/dx = 0, og deretter løs ut for x.
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.

nx = length(x0);
N = 10; % Lengde på horisont for beregning av gjennomsnitt
xN = zeros(nx,N); % Horisont med gamle tilstander
x = x0; % initiering av løkka
xm = x0 + 1e-8; % For å få løkka igang
i = 1; % Tellevariabel

%%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
while xm ~= x
    % Integrerer fuknksjonen med 4. ordens rk
    K1 = feval(fun,x,varargin{:})*dt;
    K2 = feval(fun,x+K1/2,varargin{:})*dt;
    K3 = feval(fun,x+K2/2,varargin{:})*dt;
    K4 = feval(fun,x+K3,varargin{:})*dt;
    x = x + (K1+2*K2+2*K3+K4)/6;
    xN = [xN(:,2:N),x];     % Lagrer N gamle data
    xm = mean(xN,2);        % Middel av siste xN tilstander
    i = i + 1;              % Iterasjoner før sys når steady state
end
%%%--------------------------------------------------------

xs=x;               % samler i en vektor
