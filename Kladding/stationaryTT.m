function [xs,ys] = stationaryTT(us,vm)

% stationary.m: Funksjon som finner stasjon�r tilstand ved et gitt p�drag
% og forstyrrelse, slik at x(k+1) = x(k). Kan f.eks brukes til � finne
% arbeidspunkt i forbindelse med line�risering.
% 
% Fuksjonsrutine
% 
%   [xs,ys] = stationaryTT(us,vm)
% 
% Innganger:
% 
%   us - Stasjon�rt p�drag
%   vm - Middelverdi for m�lest�y
%
% Utganger:
% 
%   xs - Stasjon�r tilstand
%   ys - Stasjon�r m�ling
%
%

% Definerer konstanter fra oppgaveteksten:
K1 = 1097;
K2 = 1022; % For rigg 1
K3 = 423.22;
K4 = 2039.3;

% Finner arbeidspunkter det skal line�riseres rundt analytisk
x1s=(K3*us+K4)^2/K1^2;   % dx1/dt=0;
x2s=(K3*us+K4)^2/K2^2;   % dx2/dt=0;
xs=[x1s;x2s];           % samler i en vektor

ys=g(xs,us,vm);                  % M�leligning arbeidspunkt 
