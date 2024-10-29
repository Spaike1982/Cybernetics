function y = g(x,u,v)

% g.m: Funksjon som beskriver overføringen fra tilstander til målinger, 
% altså en måleligning, denne kan være lineær eller ulineær. 
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
%   u - Pådrag 
%   v - Målestøy
%
% Utganger:
% 
%   y - målinger
% 

%% Eksempelmodell med direkte måling av tilstand: Totanken ved HIT
y = x + v;
