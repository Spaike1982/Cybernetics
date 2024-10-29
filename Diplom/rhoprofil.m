function [y,yw] = rhoprofil(lw,le,lo,ynw,yne,yno,yng,row,roe,roo,rog,rhow,rhoo,rhog)
% rhoprofil.m: Funksjon for generering av tetthetsprofil i 
% tre-fase separator
%
% Innganger i funksjonen:
%   lw - Maks variasjon i vanniv�, i m�lepunkter j.
%   le - Maks variasjon i emulsjon mellom olje og vann, i m�lepunkter j.
%   lo - Maks variasjon i oljeniv�, i m�lepunkter j.
%   ynw - Antall m�lepunkter, j dekket av vann, dvs. niv� av vannfasen
%   yne - Antall m�lepunkter, j dekket av emulsjon, dvs. niv� av emulsjonsfasen
%   yno - Antall m�lepunkter, j dekket av olje, dvs. niv� av oljefasen
%   yng - Antall m�lepunkter, j dekket av gass, dvs. niv� av gassfasen
%   row - Standaravvik i gaussisk m�lest�y p� vannm�linger
%   roe - Standaravvik i gaussisk m�lest�y p� emulsjonsm�linger
%   roo - Standaravvik i gaussisk m�lest�y p� oljem�linger
%   rog - Standaravvik i uniform m�lest�y p� gassm�linger
%   rhow - Tetthet i vannfasen
%   rhoo - Tetthet i oljefasen
%   rhog - Tetthet i gassfasen
%
% Utganger i fuksjonen:
%   y - Genererte data av tetthetsprofil uten st�y for en tidssample
%   yw - Genererte data av tetthetsprofil med st�y for en tidssample
%   j - Vektor med alle m�lepunkter

% Genrering av tilfeldige heltall for simulering av niv�variasjoner
bw = ceil(lw.*rand(1,1));                       % Vann
be = ceil(le.*rand(1,1));                       % Emulsjon
bo = ceil(lo.*rand(1,1));                       % Olje

% Generer tetthetsprofiler
yw = [rhow(:,ones(ynw,1)),rhow(:,ones(bw,1))];  % Vann
ye = rhoo:(rhow-rhoo)/(yne+be-1):rhow;          % Emulsjon
ye = ye(:,end:-1:1);                            % Snur emulsjonsvektor
yo = [rhoo(:,ones(yno,1)),rhoo(:,ones(bo,1))];  % olje
yg = rhog(:,ones(yng-bo-be-bw,1));              % gass

% Legger til hvit gaussisk st�y
yww = yw + [row*randn(1,ynw),row*randn(1,bw)];  % Tetthetsprofil for vannfase
yew = ye + [roe*randn(1,yne),roe*randn(1,be)];  % Tetthetsprofil for emusjonsfase
yow = yo + [roo*randn(1,yno),roo*randn(1,bo)];  % Tetthetsprofil for oljefase
ygw = yg + rog*rand(1,yng-bo-be-bw);            % Tetthetsprofil for gassfase

% Samler i m�levektore
y = [yw,ye,yo,yg];                              % Uten st�y
yw = [yww,yew,yow,ygw];                         % Med st�y