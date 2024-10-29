function [Bols,b0ols,RMSEPols,RMSECols]=myOLS(xcal,ycal,xval,yval)
% Funksjon som utfører prinsippal komponent dekomposisjon for derretter og danne en PCR regresjonsmodell.
% Valideringsmetode er testsettvalidering, siden dette er den eneste
% realistiske valideringen
%
% Innput:   xcal - Matrise med inngangsdata (kalibreing), kolonner er variable og rekker er sampler
%           xval - Matrise med inngangsdata (validering), kolonner er variable og
%                   rekker er sampler
%           ycal - Matrise med utgangsdata (kalibrering), kolonner er variable og
%                   rekker er sampler
%           yval - Matrise med utgangsdata (validering), kolonner er variable og
%                   rekker er sampler
%
% Output:   
%           Bols - Regressjonskoeffisienter
%           b0ols - Regressjonskoeffisienter (skal ikke mulipliseres med
%           variable (y_hat=Bpcr*x_new+b0pcr)
%           RMSEPols - Gjennomsnittelig modellfeil med testsett validering
%           RMSECols - Gjennomsnittelig modellfeil uten validering

% Finner størrelser på data
ncal = length(ycal); nval = length(yval);

% Benytter ligningen for en rett linje for kurvetilpasning, y = x*b1 + b2
X = [xcal,ones(ncal,1)];
Y = ycal;

% Finner minste kvadraters regerssjonskoeffisienter
B = pinv(X'*X)*X'*Y;
Bols = B(1:end-1);
b0ols = B(end);

% Validerer modell mot valideringsdata
RMSECols=sqrt(sum((ycal-(xcal*Bols+b0ols)).^2)/ncal); % Validering
RMSEPols=sqrt(sum((yval-(xval*Bols+b0ols)).^2)/nval); % Validering


