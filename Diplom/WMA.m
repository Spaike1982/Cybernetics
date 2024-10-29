%% Eksponensiellt vektet glidende horisont filtrering
% "Exponentially Weighted Moving Average Filter"
% Som er identisk til 1.ordens lavpassfilter se:
% "http://lorien.ncl.ac.uk/ming/filter/fillpass.htm"

clear; clc;
format short g

lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - V�r 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
y = data(1,1:107)';
n = length(y)-1;
x = (0:n)';

% 0<=p<=1, filtreringsgrad
N = 2; % Filtreringshorisont
p = N/(N+1);
% Lager opp plass for filtrerte data
yy = zeros(1,n);
% Initialisering av filter
yy(1) = y(1);
i = 1;
% Rekursiv algoritme
for k = 2:length(x);
yy(k) = p*yy(k-1) + (1-p)*y(k);
if yy(k) > yy(k-1);
    i = i + 1;
else
    i = i - 1;
end
if i > 8
    k
end
end

plot(x,y,'.',x,yy,'r-');