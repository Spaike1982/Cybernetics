%% PCA/SVD analyse

clear; clc; clf;
format short g

%% Laster inn reell data
lesfil('C:\Documents and Settings\Administrator\My Documents\Skole\2KIT - V�r 2007\Hovedoppgave\Matlab\Diplom\sep1p.mat');
X = data(1:50:end,1:107);

 
% %% Autoskalering av data
% % Sentrering
% n=size(X,1);
% % X=X-ones(n,1)*sum(X)/n;
% % Skalering
% for j=1:size(X,2)
%     X(:,j)=X(:,j)/sqrt(sum(X(:,j).^2)/(n-1));
% end

%% PCA/SVD - dekomposisjon:
a=10; % Antall prinsippale komponenter
[U S V] = svd(X);
U1=U(:,1:a);
S1=S(1:a,1:a);
V1=V(:,1:a);
T = U1*S1;                      % Score vector matrix.
P = V1;                         % Loading vector matrix.
E=X-T*P';                       % Residuale

%% Plotting
% Singul�rverdi plot (sjekke informasjonen fanget i komponentene)
figure(1)
plot(diag(S1))
% Loading vektore
figure(2)
plot(T(:,2:3));
% Score vektore
figure(3)
plot(P(:,2:4));


%%% ---- 2D plot av prinsippale komponeter ---- %%%
% % (For � sjekke korrelasjoner mellom sampler, mellom variable og mellom sample
% og variable)
% % Velg komponter som skal plottes mot hverandre
% PCx = 1;
% PCy = 2;
% % Scoreplot
% sampler = 1:size(X,1);
% sampler = num2str(sampler');
% figure(4)
% title('Scoreplot');
% axis([min(T(:,PCx)), max(T(:,PCx)), min(T(:,PCy)), max(T(:,PCy))])
% text(T(:,PCx),T(:,PCy),sampler);
% % Loadingplot
% variable = 1:size(X,2);
% variable = num2str(variable');
% figure(5)
% title('Loadingplot')
% axis([min(P(:,PCx)), max(P(:,PCx)), min(P(:,PCy)), max(P(:,PCy))])
% text(P(:,PCx),P(:,PCy),variable);