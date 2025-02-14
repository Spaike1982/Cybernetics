%%% Testcalc 2.
clear; clc;
%% Generere testdata
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

%% Initialisering
% Samler data i matrise
maxit = 100;        % Maks iterasjoner
eps = 0.01;         % Konvergens grense
X = [x;y]';
[n,m] = size(X);    % n - sampler og m variable (obsersvasjoner)
C = 2;              % Antall clustere
p = 1;              % Prinsippale komponenter
al = 0;             % avveiningsfaktor mellom FCM og PCA. al = 0 -> FCM
la = 2;             % Fuzzy faktor.
B = rand(m,1*C);    % Sentermatrise for alle clustere
U = rand(1*C,n);    % Medlemskapsmatrise for alle clustere (beregnes fra sentere)
F = rand(n*C,p);    % Score matrise for alle clustere C. F=[F1,...,Fc]'
A = rand(m*C,p);    % Prinsippal komponent matrise for alle cluster C. A = [A1,...,Ac]'
Dj = eye(n);        % for j = 1..m. dij = 1: xij er observert, dij = 0: xij ikke observert
Di = eye(m);        % for i = 1..n. samme som Dj
In = ones(n,1);     % Kolonnevektor med 1'ere

%% FCEM - Ikke optimalisert kode i det hele tatt.

% oppdaterer prinsippale komponenter Ac
for c = 1:C
    Uc = diag(U(c,:));      % Meldemskap for cluster c
    Fc = F(n*c-n+1:n*c,:);  % Scores for cluster c
    for j = 1:m
        xj = X(:,j);
        bcj = B(c,j);
        acj = inv(Fc'*Uc*Dj*Fc)*Fc'*Uc*Dj*(xj - In*bcj);
        Ac(j,:) = acj';
    end
    A(m*c-m+1:m*c,:) = Ac;  % Prinsippale komponenter for alle clustere
end

% L�kke
for k = 1:maxit
    % Oppdaterer scores Fc
    for c = 1:C
        bc = B(:,c);            % Senter punkter for cluster c
        for i = 1:n
            xi = X(i,:)';
            fci = inv(Ac'*Di*Ac)*Ac'*Di*(xi - bc);
            Fc(i,:) = fci';
        end
        F(n*c-n+1:n*c,:) = Fc;
    end

    % Oppdaterer medlemskap Uc
    Uold = U;
    for c = 1:C
        for i = 1:n
            xi = X(i,:)';
            uci = exp(-(al*(xi - Ac*fci - bc)'*Di*(xi - Ac*fci - bc) + (1 - al)*(xi - bc)'*Di*(xi - bc))/la - 1);
            uc(i) = uci;
        end
        Uc = diag(uc);
        U(c,:) = diag(Uc);
    end

%     % Sjekker for konvergens
%     if norm(U-Uold) < eps
%         break;
%     end
end

figure(1)
plot(x,y,'.',-0.5,0.5,'ro',0.5,-0.5,'ro',B(1,:),B(2,:),'*');
figure(2)
subplot(211)
plot(U(1,:))
subplot(212)
plot(U(2,:))