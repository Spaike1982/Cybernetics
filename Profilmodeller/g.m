function y = g(x,u,v)

% g.m: Funksjon som beskriver overf�ringen fra tilstander til m�linger, 
% alts� en m�leligning, denne kan v�re line�r eller uline�r. 
% 
% Basistruktur for tilstansrommodellen:
%
%   y = g(x(k),u(k),v(k))
% 
% Se eksempel med totankmodell i denne fila.
%
% Funksjonsrutine
% 
%   y = g(x,u,v)
%
% Innganger:
% 
%   x - Tilstander
%   u - P�drag 
%   v - M�lest�y
%
% Utganger:
% 
%   y - m�linger
% 

%% Eksempelmodell med direkte m�ling av tilstand: Totanken ved HIT
y = x + v;
