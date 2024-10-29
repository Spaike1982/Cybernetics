function [y,yw] = rhoprofil(lw,le,lo,ynw,yne,yno,yng,row,roe,roo,rog,rhow,rhoo,rhog)
% rhoprofil.m: Funksjon for generering av tetthetsprofil i 
% tre-fase separator
%
% Innganger i funksjonen:
%   lw - Maks variasjon i vannivå, i målepunkter j.
%   le - Maks variasjon i emulsjon mellom olje og vann, i målepunkter j.
%   lo - Maks variasjon i oljenivå, i målepunkter j.
%   ynw - Antall målepunkter, j dekket av vann, dvs. nivå av vannfasen
%   yne - Antall målepunkter, j dekket av emulsjon, dvs. nivå av emulsjonsfasen
%   yno - Antall målepunkter, j dekket av olje, dvs. nivå av oljefasen
%   yng - Antall målepunkter, j dekket av gass, dvs. nivå av gassfasen
%   row - Standaravvik i gaussisk målestøy på vannmålinger
%   roe - Standaravvik i gaussisk målestøy på emulsjonsmålinger
%   roo - Standaravvik i gaussisk målestøy på oljemålinger
%   rog - Standaravvik i uniform målestøy på gassmålinger
%   rhow - Tetthet i vannfasen
%   rhoo - Tetthet i oljefasen
%   rhog - Tetthet i gassfasen
%
% Utganger i fuksjonen:
%   y - Genererte data av tetthetsprofil uten støy for en tidssample
%   yw - Genererte data av tetthetsprofil med støy for en tidssample
%   j - Vektor med alle målepunkter

% Genrering av tilfeldige heltall for simulering av nivåvariasjoner
bw = ceil(lw.*rand(1,1));                       % Vann
be = ceil(le.*rand(1,1));                       % Emulsjon
bo = ceil(lo.*rand(1,1));                       % Olje

% Generer tetthetsprofiler
yw = [rhow(:,ones(ynw,1)),rhow(:,ones(bw,1))];  % Vann
ye = rhoo:(rhow-rhoo)/(yne+be-1):rhow;          % Emulsjon
ye = ye(:,end:-1:1);                            % Snur emulsjonsvektor
yo = [rhoo(:,ones(yno,1)),rhoo(:,ones(bo,1))];  % olje
yg = rhog(:,ones(yng-bo-be-bw,1));              % gass

% Legger til hvit gaussisk støy
yww = yw + [row*randn(1,ynw),row*randn(1,bw)];  % Tetthetsprofil for vannfase
yew = ye + [roe*randn(1,yne),roe*randn(1,be)];  % Tetthetsprofil for emusjonsfase
yow = yo + [roo*randn(1,yno),roo*randn(1,bo)];  % Tetthetsprofil for oljefase
ygw = yg + rog*rand(1,yng-bo-be-bw);            % Tetthetsprofil for gassfase

% Samler i målevektore
y = [yw,ye,yo,yg];                              % Uten støy
yw = [yww,yew,yow,ygw];                         % Med støy