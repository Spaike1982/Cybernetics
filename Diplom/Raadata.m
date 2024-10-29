clear; clc;
format short g

%% Plotting av rådata
lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - Vår 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
y = data(:,1:107)';
[n,m] = size(y);
nj = 0:n-1;
nk = 0:m-1;

%% ------------- Tetthet mot målepunkt ------------
sample = 1;
figure(1)
plot(nj,y(:,sample),'b.')
title(['Reell tetthetsprofil i separator ved tidssample, k = ',num2str(sample)])
legend('Støybefengte målinger')
xlabel('Nivå (målepunkt)'), ylabel('Tetthet (rho)')

%% ------------- Tetthet mot tidssample ---------------
maalepunkt = 49;
figure(2)
plot(nk,y(maalepunkt,:),'b.')
title(['Reell tetthetsprofil i separator ved målepunkt ',num2str(maalepunkt)])
legend('Støybefengte data')
ylabel('Tetthet (rho)'), xlabel('Tidssample (50s)')

%% ----------- Fancy 3d plot av all data for full oversikt ---------
figure(3)
surf(nk(1:100:end),nj,y(:,1:100:end));
title('Virkelig tetthesprofil')
xlabel('Sampler, (30sek)'), ylabel('Målepunkt'), zlabel('Tetthet');
