%% Simulering av profil
clear; clc;
format short g

% Laster inn data
lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - Vår 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
y = data(7700:end,1:107)';
n = size(y,1);
x = (0:n-1)';

% B = [10;700;1100;15;20;50;80];
% Simulering

% Nummerisk minste kvadraters metode
Bb = [5;800;1000;20;25;60;80];   % For simulasjon
% Initielle parametere
n=size(y,2);
t = 1:n;
for k = 1:n
    k
    Bb = lsqcurvefit('firstorderfunction',Bb,x,y(:,k))
    %Bb = gaussnewton('firstorderfunction',Bb,x,y(:,k),0.1,100)
    %Bb = newton('firstorderfunction',Bb,x,y(:,k),0.1);
    yhat = firstorderfunction(Bb,x);
    B(:,k) = Bb;
    figure(1)
    plot(x,y(:,k),'*',x,yhat)
end

