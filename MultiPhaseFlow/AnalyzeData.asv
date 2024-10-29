clear; clc;

%% Loading calibration and test data

% LoadData;     % Takes some time depending on CPU frequenzy
% % Time mean
% X   = [mean(Xa00);
%        mean(Xa02);
%        mean(Xa04);
%        mean(Xw100);
%        mean(Xw150);
%        mean(Xw200);
%        mean(Xw220);
%        mean(Xw250);
%        mean(Xw300);
%        mean(Xa01w50);
%        mean(Xa01w100);
%        mean(Xa01w150);
%        mean(Xa01w200);
%        mean(Xa02w50);
%        mean(Xa02w100);
%        mean(Xa02w150);
%        mean(Xa02w200);
%        mean(Xa03w50);
%        mean(Xa03w100);
%        mean(Xa03w150);
%        mean(Xa03w200);
%        mean(Xa03w300);
%        mean(Xa04w50);
%        mean(Xa04w100);
%        mean(Xa04w150);
%        mean(Xa04w200);
%        mean(Xa05w50);
%        mean(Xa05w100);
%        mean(Xa05w150);
%        mean(Xa05w200);
%        mean(Xa06w50);
%        mean(Xa06w100);
%        mean(Xa06w150);
%        mean(Xa06w200);
%        mean(Xa06w300)];
% 
% load calpar.mat   
       
Xraw = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat100gas0.5_SlugtimeG4W4.txt');
X = Xraw;

%% Surface plot to get a first look
% Raw
figure(1)
surf(X);
% % Scaling and centring
% Xm = mean(X);
% Xstd = std(X);
% X1 = ones(length(X),1);
% Xs = (X - X1*Xm)./(X1*Xstd);
% figure(2)
% surf(Xs)

% % Calibrated difference pressure
% Xmbar = zeros(size(X));
% for i = 1:size(X,2);
%     Xmbar(:,i) = [X(:,i),ones(length(X),1)]*B(i,:)';
% end
% figure(3)
% surf(Xmbar);

%% PCA to check correlations between sensors and samples
% Removing outliers
X = X;
[U,S,V] = svd(X);
T = U*S;            % Scores    (correlation between samples)
P = V;              % Loadins   (correlation between variables)
figure(4);
plot(diag(S));      % Singular values (information in scores and loadings)
% Velg komponenter som skal plottes
t1 = 1; t2 = 2;
p1 = t1; p2 = t2;
% Scoreplot - Sample correlations
sampler = 1:size(X,1);
sampler = num2str(sampler');
figure(5)
axis([min(T(:,t1)), max(T(:,t1)), min(T(:,t2)), max(T(:,t2))])
text(T(:,t1),T(:,t2),sampler);
% Loadingplot - Variable correlations
variable = 1:size(X,2);
variable = num2str(variable');
figure(6)
axis([min(P(:,p1)), max(P(:,p1)), min(P(:,p2)), max(P(:,p2))])
text(P(:,p1),P(:,p2),variable);
% Transforming dataset
A = 3;          % Princippal components (chosen from singularvalue plot)
Ta=U(:,1:A)*S(1:A,1:A);
Pa=V(:,1:A);
Epca = X-Ta*Pa';   % Residulas (assumed noise)