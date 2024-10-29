clear; clc;
%%% Test av fuzzy clustering algoritmer

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

% Samler data i matrise
Z = [x;y];

%% Initierer data
% Finn dimensjoner
[n,N] = size(Z);    % n sampler og N variable
% Initier
c = 2;              % Antall clustere
m = 2;              % Fuzzy eksponent
maxit = 100;        % Maksimalt antall iterajsoner
eps = 0.01;         % Konvergensgrense
W = (Z-vectorrep(mean(Z,2),N))*(Z-vectorrep(mean(Z,2),N))'/N; % Covarians matrise
A = eye(n);         % Norm matrise, A=I antar kulefor på clustere
%A = eye(n).*W;     % Horisontal ellipse
%A = inv(W);        % Skrå ellipse (invers kovariansmatrise)
U = rand(c,N)/2;    % Medlemsskapsmatrise, alle punkter har lik tilhørighet
Um = U;             % Fuzzy medlemsskapsmatrise
U = zeros(c,N);
V = rand(n,c);      % Sentermatrise
D = zeros(c,N);     % Avstandsmatrise

%% Initierer medlemsskapsmatrise U basert på gjetting av cluster sentere
% (Lik kode som i FMC interasjonsløkke)
% Beregner avstander (ikke optimalisert kode)
for i = 1 : c
    for k = 1 : N
        Dik = Z(:,k) - V(:,i);
        D(i,k) = Dik' * A * Dik;
    end
end
D = sqrt(D);
% Oppdaterer medlemsskapsmatrise
tmp = D.^(-2/(m-1));
U = tmp./(vectorrep(sum(tmp),c));
% Korrigerer for sigunlæritet
si = find (tmp == Inf);
U(si) = 1;
if (size (si, 1) ~= 0)
    display ('FCM, Warning: Singularity occured and corrected.');
end

%% FCM iterasjon
for l = 1:maxit
% % Beregner cluster middelverdier (ikke optimaliser)
%     for i = 1:c
%         V(:,i) = sum(vectorrep(U(i,:).^m,n).*Z,2)/sum(U(i,:).^m);
%     end
    
% Beregner cluster middelverdier (sentere)
    Um = U.^m;
    V = (Um*Z'./vectorrep(sum(Um'),n)')';
    
% Beregner avstander (ikke optimalisert kode)
    for i = 1 : c
        for k = 1 : N
            Dik = Z(:,k) - V(:,i);
            D(i,k) = Dik' * A * Dik;
        end
    end
    D = sqrt(D);
 % Oppdaterer medlemsskapsmatrise
    Uold = U;
    tmp = D.^(-2/(m-1));
    U = tmp./(vectorrep(sum(tmp),c));
    % Korrigerer for sigunlæritet
    si = find (tmp == Inf);
    U(si) = 1;
    if (size (si, 1) ~= 0)
        display ('FCM, Warning: Singularity occured and corrected.');
    end
% % Oppdaterer medlemskapsmatrise (ikke optimalisert kode)
%     Um1 = U;
%     for k = 1:N
%         for i = 1:c
%             U(i,k) = 1/sum((D(i,k)./D(:,k)).^(2/(m-1)));
%         end
%     end
l   
% Sjekker for konvergens
    if norm(U-Uold) < eps
        break;
    end
%     figure(1)
%     plot(x,y,'.',-0.5,0.5,'ro',0.5,-0.5,'ro',V(:,1),V(:,2),'*');
%     figure(2)
%     subplot(211)
%     plot(U(1,:))
%     subplot(212)
%     plot(U(2,:))
end

%% Presenterer resultater
figure(1)
plot(x,y,'.',-0.5,0.5,'ro',0.5,-0.5,'ro',V(:,1),V(:,2),'*');
figure(2)
subplot(211)
plot(U(1,:))
subplot(212)
plot(U(2,:))