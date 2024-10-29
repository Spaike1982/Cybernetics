clear; clc;
%%% Test av fuzzy clustering algoritmer

%% Generere testdata med to variable x og y
nx=100; % Antall x data
ny=100; % Antall y data

% cluster 1: Normalfordelt med standaravik 0.2 for begge akser, sentrum
% (-0.5,0.5)
x(1:nx/2) = 0.2*randn(1,nx/2) - 0.5;
y(1:ny/2) = 0.2*randn(1,ny/2) + 0.5;
% cluster 2: Normalfordelt med standardavvik 0.2 for x akse og 0.05 for y
% akse, sentrum (0.5,-0.5)
x(nx/2+1:nx) = 0.2*randn(nx/2,1) + 0.5;
y(ny/2+1:ny) = 0.05*randn(ny/2,1) - 0.5;
% Samler data i matrise
X = [x;y]';

%% Initierer data
% Initier
[n,m] = size(X);    % Finner dimensjoner
C = 2;              % Antall clustere
la = 1.6;           % Fuzzy eksponent
rho = ones(1,C)*1;    % Volum av clustere (beskrankning på determinanten til A)
maxit = 100;        % Maksimalt antall iterajsoner
gamma = 0;          % Skalering av cluster kovarians 0<=gamma<=1
beta = 1e15;        % Grense for singulær kovariansmatrise
eps = 1e-4;         % Konvergensgrense
% W = cov(X);        % Covarians matrise
% A = eye(m);        % Norm matrise, A=I antar kulefor på clustere
% A = W;             % Horisontal ellipse
% A = inv(W);        % Skrå ellipse (invers kovariansmatrise)
V = rand(m,C);      % Sentermatrise

%[U,V,D,l] = FCM(Z,V,c,m,A,eps,maxit);
[U,V,D,EV,ED,i] = GK(X,C,la,rho,gamma,beta,eps,maxit);
EV
ED

%% Presenterer resultater
figure(1)
subplot(211)
plot(U(:,1))
subplot(212)
plot(U(:,2))
figure(2)
plot(x,y,'.',-0.5,0.5,'ro',0.5,-0.5,'ro',V(1,:),V(2,:),'g*');