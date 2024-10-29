%% Test av minste kvadraters metode på en ulineær fuksjon: 
% y(x) = ax+bx^2+cx^3+d

clear; clc;
format short g

%% Fuksjonen
x = 0:0.1:10;                           % Inngangdata
x = x';                                 % Skal ha rekkevektor
B = [7;-2;0.15;5]                       % Definerer konstanter
y = B(1).*x+B(2).*x.^2+B(3)*x.^3+B(4);  % responsdata y(x)
yn = y + 1*randn(length(x),1);          % Legger til støy på y(x)

%% Minste kvadraters metode
X = [x,x.^2,x.^3,ones(length(x),1)];    % Designvariable
Y = yn;                                 % Responsvariable
Bols = inv(X'*X)*X'*Y                   % Estimerte konstanter

%% Plotting
plot(x,yn,'.',x,X*Bols,'r-')