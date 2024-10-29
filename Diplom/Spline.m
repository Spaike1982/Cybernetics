%% Spline på data

clear; clc;
format short g

lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - Vår 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
y = data(1,1:107)';
n = length(y)-1;
x = (0:n)';

% Smoothing spline, smoothing parameter p
p=0.005;
[yy,p] = csaps(x,y,p,x);

plot(x,y,'.',x,yy,'r-')

%% Deriverte NB! forutsetter dx = 1
dyy(1)=yy(2)-yy(1);
for k = 2:length(x)
dyy(k) = yy(k) - yy(k-1);    % Endring
d2yy(k) = dyy(k) - dyy(k-1); % Endring av endring
end