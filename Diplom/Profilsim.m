clear; clc; clf;

%% Profilsim.m: Simulering og estimering av tetthetsprofil
% Benyttter seg av f�lgende funksjoner:
% lesfil.m: Leser inn virkelige data
% rhoprofil.m: Genererer simulert tetthetsprofil
% rhoestim.m: Estimerer tetthetsprofil fra st�ybefengte data

pres = 0;

%% Laster inn virkelig tetthetsprofil
lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - V�r 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
Yreal=data(:,107:-1:1); % Snur data med hensyn p� m�lepunkter

%% Genererer simulert tetthetsprofil

%% Spesifiserer profilegenskaper
% Tetthet i hver fase (justert slik at de stemmer med virkelige data)
rhog = 0;                   % gass
rhoo = 750;                 % olje
rhow = 1050;                % vann
% Sampler i hver fase
ynw = 30;                   % Vann
yne = 19;                   % Emulsjon
yno = 30;                   % Olje
yng = 28;                   % Gass
% Maksimal niv�variasjon i hver fase
lw = 0;                     % Vann
le = 0;                     % Emulsjon
lo = 0;                     % Olje
% Standaravvik p� normalfordelt m�lest�y
row = 20;                   % Vann
roe = 25;                   % Emulsjon
roo = 15;                   % Olje
% ikke standaravvik
rog = 20;                   % Gass
% Simuleringsdata
Nk = length(data);          % Antall tidssampler
yj = ynw+yne+yno+yng;       % Antall m�lepunkter
nj = 1:yj;
% Lager opp plass for lagring
Yp = zeros(Nk,yj);
Yw = Yp;

%% Generer profil
tic % Start stoppeklokke
for k = 1:Nk
    [y,yw] = rhoprofil(lw,le,lo,ynw,yne,yno,yng,row,roe,roo,rog,rhow,rhoo,rhog);
    % Lagre data i matriser
    Yp(k,:) = y;
    Yw(k,:) = yw;
end
toc % Stopp stoppeklokke

%% Pesentasjon av data

if pres == 1
    %%% ------------- Tetthet mot m�lepunkt ------------
    sample = 107;
    % Simulert
    figure(1)
    plot(Yw(sample,:),nj,'.b',Yp(sample,:),nj,'r-');
    title(['Simulert tetthetsprofil i separator ved tidssample, k = ',num2str(sample)])
    legend('St�ybefengte m�linger','Tetthet (fasit)')
    xlabel('Tetthet (rho)'), ylabel('Niv� (m�lepunkt)')

    % Virkelig
    figure(2)
    plot(Yreal(sample,:),nj,'b.')
    title(['Reell tetthetsprofil i separator ved tidssample, k = ',num2str(sample)])
    legend('St�ybefengte m�linger')
    xlabel('Tetthet (rho)'), ylabel('Niv� (m�lepunkt)')

    % Virkelig mot simulert
    figure(3)
    plot(Yreal(sample,:),nj,'b.',Yw(sample,:),nj,'r.')
    title(['Simulert mot virkelig tetthetsprofil ved tidssample, k = ',num2str(sample)])
    legend('virkelige data','Simulerte data')
    xlabel('Tetthet (rho)'), ylabel('Niv� (m�lepunkt)')

    %% ------------- Tetthet mot tidssample ---------------
    maalepunkt = 50;
    % Simulert
    Nyk = 1:Nk;
    figure(4)
    plot(Nyk,Yw(:,maalepunkt),'.b',Nyk,Yp(:,maalepunkt),'r-');
    title(['Simulert tetthetsprofil i separator ved m�lepunkt ',num2str(maalepunkt)])
    legend('St�ybefengte data','Rene data')
    ylabel('Tetthet (rho)'), xlabel('Tidssample (50s)')

    % Virkelig
    figure(5)
    plot(Nyk,Yreal(:,maalepunkt),'b.')
    title(['Reell tetthetsprofil i separator ved m�lepunkt ',num2str(maalepunkt)])
    legend('St�ybefengte data')
    ylabel('Tetthet (rho)'), xlabel('Tidssample (50s)')

    % Virkelig mot simulert
    figure(6)
    plot(Nyk,Yreal(:,maalepunkt),'b.',Nyk,Yw(:,maalepunkt),'r.')
    title(['Simulert mot virkelig tetthetsprofil ved m�lepunkt ',num2str(maalepunkt)])
    legend('virkelige data','Simulerte data')
    ylabel('Tetthet (rho)'), xlabel('Tidssample (50s)')

    %% ----------- Fancy 3d plot av all data for full oversikt ---------
    % virkelige data
    figure(7)
    Nkk = 1:100:Nk;
    surf(nj,Nkk,Yreal(1:100:end,:));
    title('Virkelig tetthesprofil')
    xlabel('M�lepunkt'), ylabel('Sampler, (30sek)'), zlabel('Tetthet');

    % Simulerte data
    figure(8)
    surf(nj,Nkk,Yw(1:100:end,:));
    title('Simulert tetthesprofil')
    xlabel('M�lepunkt'), ylabel('Sampler, (30sek)'), zlabel('Tetthet');

    figure(9)
    surf(nj,Nkk,Yw(1:100:end,:));
    hold on
    figure(9)
    mesh(nj,Nkk,Yreal(1:100:end,:));
    hold off
    title('Simulert mot virkelig tetthesprofil')
    xlabel('M�lepunkt'), ylabel('Sampler, (30sek)'), zlabel('Tetthet');

    figure(10)
    surf(nj,Nkk,Yreal(1:100:end,:));
    hold on
    figure(10)
    mesh(nj,Nkk,Yp(1:100:end,:));
    title('Simulert mot virkelig tetthetsprofil')
    xlabel('M�lepunkt'), ylabel('Sampler, (30sek)'), zlabel('Tetthet');
    
else
    disp('Ingen plotting aktivert')
end
