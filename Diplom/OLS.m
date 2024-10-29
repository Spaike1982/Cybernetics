%% Minte kvadraters metode på data

clear; clc;
format short g

lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - Vår 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
y = data(1,1:107)';
n = length(y)-1;
x = (0:n)';

%% Minste kvadraters metode
X = [x,x.^3,x.^5,x.^7,x.^9,x.^11,ones(length(x),1)];    % Designvariable
Y = y;                                 % Responsvariable
Bols = inv(X'*X)*X'*Y                   % Estimerte konstanter
yy = X*Bols;


%% Plotting
plot(x,y,'.',x,yy,'r-')