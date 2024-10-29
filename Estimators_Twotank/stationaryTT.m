function [xs,ys] = stationaryTT(us,vm)

% stationary.m: Funksjon som finner stasjonær tilstand ved et gitt pådrag
% og forstyrrelse, slik at x(k+1) = x(k). Kan f.eks brukes til å finne
% arbeidspunkt i forbindelse med lineærisering.
% 
% Fuksjonsrutine
% 
%   [xs,ys] = stationaryTT(us,vm)
% 
% Innganger:
% 
%   us - Stasjonært pådrag
%   vm - Middelverdi for målestøy
%
% Utganger:
% 
%   xs - Stasjonær tilstand
%   ys - Stasjonær måling
%
%

% Definerer konstanter fra oppgaveteksten:
K1 = 1097;
K2 = 1022; % For rigg 1
K3 = 423.22;
K4 = 2039.3;

% Finner arbeidspunkter det skal lineæriseres rundt analytisk
x1s=(K3*us+K4)^2/K1^2;   % dx1/dt=0;
x2s=(K3*us+K4)^2/K2^2;   % dx2/dt=0;
xs=[x1s;x2s];           % samler i en vektor

ys=g(xs,us,vm);                  % Måleligning arbeidspunkt 
