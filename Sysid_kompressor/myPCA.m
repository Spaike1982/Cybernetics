function [T,P,E,X_pca,a]=myPCA(X,s,k)
% Funksjon som utfører en prinsippal komponent dekomposisjon.
%
% Innput:   X - Matrise med data, kolonner er variable og rekker er sampler
%           s - sentrering av data, default ja
%           k - Skalering av data, default ja
%
% Output:   T - Scorematrise
%           P - Loadingmatrise
%           E - Residuale
%           X_pca - Den akutelle matrisen brukt i selve
%           singulærverdidekomposisjonen.
%           a - Antall PC valgt

if nargin == 2; k = 1; end
if nargin == 1; s = 1; k = 1; end

%% Autoskalering
if s == 1 % Sentrerer
    n=size(X,1);
    X=X-ones(n,1)*sum(X)/n;
end
if k == 1 % Standardiserer (Skalerer)
    for j=1:size(X,2)
        X(:,j)=X(:,j)/sqrt(sum(X(:,j).^2)/(n-1));
    end
end
X_pca=X;

%% Utfører PCA ved hjelp av singulærverdidekomposisjon (Alternativt med
%% NIPALS)
[U S V]=svd(X);
a=size(S,2);
plot(0:a-1,diag(S));
title('Singulærverdier');
disp(diag(S)');
a=dread('Velg antall prinsippale komponenter, default er maks antall',a);
U1=U(:,1:a);
S1=S(1:a,1:a);
V1=V(:,1:a);
T = U1*S1;                      % Score vector matrix.
P = V1;                         % Loading vector matrix.
E=X-T*P';                       % Residuale