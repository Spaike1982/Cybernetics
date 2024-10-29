function rho = expfunksjon(x,h)
% expfunksjon.m: funksjon basert p� eksponensial funksjoner for transisjon 
% fra tilstandsvektor x med niv�vektoren h til tetthetsm�ling rho.
%
% Fuksjonsrutine
%
%   rho = expfunksjon(x,h)
%
% Innganger:
% 
%   x - Tilstandsvektor x = [rhog,rhoo,rhow,hx1,hx2,hx3,hx4]
%   h - vektor med niv� m�lepunkter h = [1,2,...,N]
%
% Utganger:
% 
%   rho - Vektor med tetthetsm�linger for alle niv� punkter h.
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved H�gskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] Henning Winsnes, "Estimering av niv� i tre-faseseparator med
%       porfilm�ler", Masters Thesis, H�gskulen i Telemark, 2007.
%
a = 4; % Tuningsparameter for overgang mellom niv�
rho = x(1) + (x(2)-x(1))./(1+exp(-(a/(x(5)-x(4)))*(h-x(4)-...
    ((x(5)-x(4))/2)))) + (x(3)-x(2))./(1+exp(-(a/(x(7)-...
     x(6)))*(h-x(6)-((x(7)-x(6))/2))));