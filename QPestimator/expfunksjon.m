function rho = expfunksjon(x,h)
% expfunksjon.m: funksjon basert på eksponensial funksjoner for transisjon 
% fra tilstandsvektor x med nivåvektoren h til tetthetsmåling rho.
%
% Fuksjonsrutine
%
%   rho = expfunksjon(x,h)
%
% Innganger:
% 
%   x - Tilstandsvektor x = [rhog,rhoo,rhow,hx1,hx2,hx3,hx4]
%   h - vektor med nivå målepunkter h = [1,2,...,N]
%
% Utganger:
% 
%   rho - Vektor med tetthetsmålinger for alle nivå punkter h.
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] Henning Winsnes, "Estimering av nivå i tre-faseseparator med
%       porfilmåler", Masters Thesis, Høgskulen i Telemark, 2007.
%
a = 4; % Tuningsparameter for overgang mellom nivå
rho = x(1) + (x(2)-x(1))./(1+exp(-(a/(x(5)-x(4)))*(h-x(4)-...
    ((x(5)-x(4))/2)))) + (x(3)-x(2))./(1+exp(-(a/(x(7)-...
     x(6)))*(h-x(6)-((x(7)-x(6))/2))));