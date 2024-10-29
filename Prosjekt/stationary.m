function [xs,i] = stationary(fun,x0,dt,varargin)

% stationary.m: Funksjon som finner stasjon�r tilstand ved et gitt p�drag
% og forstyrrelse, slik at x(k+1) = x(k). Kan f.eks brukes til � finne
% arbeidspunkt i forbindelse med line�risering. Basert p� simulajson
%
% Fuksjonsrutine
%
%   [xs,ys,i] = stationary(x0,us,wm,vm,tstat,dt)
%
% Andre funksjoner som kreves internt
%
%   f.m - Tilstandsfunksjon
%   g.m - M�lelining
%
% Innganger:
%
%   fun - ODE funksjon
%   x0 - Initialtilstand
%   dt - Tidskritt for simulering slik at dt = k+1 - k
%   varargin - eventuelle stasjon�r verdier i fun, som f.eks
%   p�drag u, f = fun(x,u).
%
%
% Utganger:
%
%   i - Antall tidskritt f�r steady state n�es
%   xs - Stasjon�r tilstand
% 
% Merknad:
%
% Hvis mulig benytt analytiske uttrykk for � finne stasjon�r verdier, f.eks
% df/dx = 0, og deretter l�s ut for x.
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved H�gskulen i
%   Telemark 2007.

nx = length(x0);
N = 10; % Lengde p� horisont for beregning av gjennomsnitt
xN = zeros(nx,N); % Horisont med gamle tilstander
x = x0; % initiering av l�kka
xm = x0 + 1e-8; % For � f� l�kka igang
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
    i = i + 1;              % Iterasjoner f�r sys n�r steady state
end
%%%--------------------------------------------------------

xs=x;               % samler i en vektor
