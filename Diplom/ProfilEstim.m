clear; clc; clf;

%% Profilsim.m: Simulering og estimering av tetthetsprofil
% Benyttter seg av f�lgende funksjoner:
% lesfil.m: Leser inn virkelige data
% rhoprofil.m: Genererer simulert tetthetsprofil
% rhoestim.m: Estimerer tetthetsprofil fra st�ybefengte data

pres = 0;

%% Laster inn virkelig tetthetsprofil
lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - V�r 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
Yreal=data(:,end:-1:1); % Snur data med hensyn p� m�lepunkter

%% Genererer simulert tetthetsprofil

%% Spesifiserer profilegenskaper
% Tetthet i hver fase (justert slik at de stemmer med virkelige data)
rhog = 0;                   % gass
rhoo = 750;                 % olje
rhow = 1050;                % vann
% Sampler i hver fase
ynw = 30;                   % Vann
yne = 30;                   % Emulsjon
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
Nk = 100;
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

%%% Bestemmelse av tetthet og niv� for hver fase

%% Sorterer sampler for hver fase ved � sjekke data mot beskrankninger
% Ugyldige samples erstattes
Y = Yw;
for i = 1:Nk
    ig = 1;
    io = 1;
    iw = 1;
    ie = 1;
    ierr = 1;
    kk = 1;
    while kk < yj
        if Y(i,kk) >= 0 && Y(i,kk) <= 50
            Ywg(i,ig) = Y(i,kk);
            ig = ig + 1;
            kk = kk + 1;
        elseif Y(i,kk) >= 600 && Y(i,kk) <= 800
            Ywo(i,io) = Y(i,kk);
            io = io + 1;
            kk = kk + 1;
        elseif Y(i,kk) >= 1000 && Y(i,kk) <= 1100
            Yww(i,iw) = Y(i,kk);
            iw = iw + 1;
            kk = kk + 1;
        elseif Y(i,kk) > 800 && Y(i,kk) < 1000
            Ywe(i,ie) = Y(i,kk);
            ie = ie + 1;
            kk = kk + 1;
        else
            Ywerr(i,ierr) = Y(i,kk);
            ierr = ierr + 1;
            Y(i,kk) = Y(i,kk+1);
        end
    end
    sampg(i) = ig;
    sampo(i) = io;
    sampw(i) = iw;
    sampe(i) = ie;
    samperr(i) = ierr;
end
if ierr >= 1
    disp(['Det er ',num2str(ierr),' feilm�ling(er)'])
end

%% Finner tetthet i hver fase som gjennomsitt, 
% trekker fra noen sampler p� hver side for � sikre at tetthet m�les i 
% riktig fase
for ii = 1:Nk
mrhog(ii) = mean(Ywg(ii,:));
mrhoo(ii) = mean(Ywo(ii,:));
mrhow(ii) = mean(Yww(ii,:));
mrhoe(ii) = mean(Ywe(ii,:));
end


% Niv� for hver m�ling kan finnes fra antall sampler i fasen, dvs fra
% sampo(i), sampw(i), sampe(i)
% gjennomsnittelig niv� i hver fase for Nk sampler
hw = ceil(mean(sampw));
he = ceil(mean(sampe));
ho = ceil(mean(sampo));

% Finner niv� i hver fase som en fuksjon av tetthet i hver fase, eks 
% h = k*rho
hw2 = mrhow*0.01;
he2 = mrhoe*0.01;
ho2 = mrhoo*0.01;


%% Minste kvadraters metode for � finne kurvetilpasning (OLS)
ycalg = Ywg(1,:)';
ycalo = Ywo(1,:)';
ycalw = Yww(1,:)';
ycale = Ywe(1,:)';
lw = length(ycalw);
le = lw + length(ycale);
lo = le + length(ycalo);
lg = lo + length(ycalg);
xcalw = (1:lw)';
xcale = (lw+1:le)';
xcalo = (le+1:lo)';
xcalg = (lo+1:lg)';
xcal = 1:lg;

[Bolsw]=myOLS(xcalw,ycalw,xcalw,ycalw);
yolsw = xcal*Bolsw(1) + Bolsw(2);
[Bolse]=myOLS(xcale,ycale,xcale,ycale);
yolse = xcal*Bolse(1) + Bolse(2);
[Bolso]=myOLS(xcalo,ycalo,xcalo,ycalo);
yolso = xcal*Bolso(1) + Bolso(2);

% Plotter
plot(ycalw,xcalw,'b*',yolsw,xcal,'g-',ycale,xcale,'r*',yolse,xcal,'g-',ycalo,xcalo,'k*',yolso,xcal,'g-',ycalg,xcalg,'c*',Yp(1,:),1:yj)

% %% Kalmanfilter
% % Simulasjonsparametre
% dt = 1;
% nx = 6;  % Antall tilstander
% ny = 3;  % Antall m�linger
% Ix = eye(nx);
% Iy = eye(ny);
% % Tilstandstransisjon x(k+1) = A*x(k)
% Ac = [0,0,0,0,0,0;
%       0,0,0,0,0,0;
%       0,0,0,0,0,0;
%       0.01,0,0,0,0,0;
%       0,0.01,0,0,0,0;
%       0,0,0.01,0,0,0]; % Kontinuerlig
% A = (Ix+dt*Ac); % Diskret (Euler)
% % M�leligning y(k) = C*x(k)
% Cc = [1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,0,0,0];
% C = Cc;
% % Tipper kovarians
% W = 0.01*Ix;
% V = 0.001*Iy;
% % Kalamfilterforsterkning
% [K,Xb,Xh]=dlqe(A,Ix,C,W,V)
% % % Finner kalmanfilterforsterkningen fra den stasjon�re l�sningen av DARE
% % % (SISO)
% % K = 1/c*(a+sqrt(a^2+(c*1)^2*W/V));
% % Initierer prosessmodell
% xb = [1000;900;800;10;9;8];
% for jj = 1:Nk
%     y = [mYwo(jj);mYwe(jj);mYww(jj)];
%     yb = C*xb;
%     xh = xb + K*(y - yb)
%     xb = A*xh;
% end

% %% Autoskalering (Sentrering og skalering av data)
% n=length(Yw);
% Yw=Yw-ones(n,1)*sum(Yw)/n;
% for j=1:size(Yw,2)
%     Yw(:,j)=Yw(:,j)/sqrt(sum(Yw(:,j).^2)/(n-1));
% end
%
% %% PCA (SVD)
% [U,S,V] = svd(Yw(1:100:end,:));
% T = U*S;
% P = V;
% figure(1)
% plot(diag(S))
% figure(2)
% plot(P(1,:),P(2,:),'b*',T(1,:),T(2,:),'ro')
% legend('Loadings','Scores')
