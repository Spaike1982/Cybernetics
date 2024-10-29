function [T,P,E,Bpcr,b0pcr,RMSEPpcr,RMSECpcr,X_pcr,Y_pcr,pk]=myPCR(xcal,ycal,xval,yval,A,g)
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
%           A - Velg antall prisippale komponenter, defalut er automatisk.
%           g - autoskalering av data (sentreing og skalering), default
%           er autoskalering
%
% Output:   T - Scorematrise
%           P - Loadingmatrise
%           E - Residuale
%           Bpcr - Regressjonskoeffisienter
%           B0pcr - Regressjonskoeffisienter (skal ikke mulipliseres med
%           variable (y_hat=Bpcr*x_new+b0pcr)
%           RMSEPpcr - Gjennomsnittelig modellfeil med testsett validering
%           RMSECpcr - Gjennomsnittelig modellfeil uten validering
%           X_pcr - Aktuelle inngangsdata brukt til å danne modellen
%           Y_pcr - Aktuelle utgangsdata brukt til å danne modellen
%           pk - Antall prinsippale komponenter brukt i modellen

if nargin == 5; g = 1; end  % Setter defalut verdi
if nargin == 4; g = 1; A = -1; end % Setter defalut verdier

ncal=length(ycal);
nval=length(yval);
nvar=size(xcal,2);

if g==1; % Autoskalering
    ycal_s=ycal-ones(ncal,1)*sum(ycal)/ncal;
    xcal_s=xcal-ones(ncal,1)*sum(xcal)/ncal;
    yval_s=yval-ones(nval,1)*sum(yval)/nval;
    xval_s=xval-ones(nval,1)*sum(xval)/nval;
    ycal_s=ycal_s/sqrt(sum(ycal_s.^2)/(ncal-1));
    for j=1:size(xcal_s,2)
        xcal_s(:,j)=xcal_s(:,j)/sqrt(sum(xcal_s(:,j).^2)/(ncal-1));
    end
    yval_s=yval_s/sqrt(sum(yval_s.^2)/(nval-1));
    for j=1:size(xval_s,2)
        xval_s(:,j)=xval_s(:,j)/sqrt(sum(xval_s(:,j).^2)/(nval-1));
    end
else
    xcal_s=xcal; xval_s=xval; ycal_s=ycal; yval_s=yval;
end
X_pcr=xcal_s; Y_pcr=ycal_s;

%% Utfører PCA ved hjelp av singulærverdidekomposisjon (Alternativt med
%% NIPALS)
if A == -1  % Atomatisk valg av antall komponenter i modellen
    Ta = zeros(ncal,1/2*nvar*(nvar+1)); % Lager opp plass
    Pa = zeros(nvar,1/2*nvar*(nvar+1));
    Ea = zeros(ncal,nvar^2);
    Bpcra = zeros(1,nvar^2);
    b0pcra = zeros(1,nvar);
    RMSEPpcra = zeros(1,nvar);
    for a=1:nvar % PC dekomposisjon for alle komponenter  
        [U S V]=svd(xcal_s);
        U1 = U(:,1:a);
        S1 = S(1:a,1:a);
        V1 = V(:,1:a);
        T = U1*S1; % Score vector matrix.
        P = V1; % Loading vector matrix.
        E = xcal_s-T*P'; % Residuale

        b_s=P*pinv(T'*T)*T'*ycal_s; % Regressjonsvektor, eventuellt Bpcr=V1*pinv(S1)*U1'*y;
       if g == 1 % uskalererer regressjonsvektor for bruk på fremtidige data (X)
            b0pcr = (mean(ycal)-((mean(xcal).*(ones(1,nvar)*std(ycal)./std(xcal)))*b_s));
            Bpcr = (diag(ones(1,nvar)*std(ycal)./std(xcal)))*b_s;
        else
            b0pcr=0;
            Bpcr = b_s;
        end
        RMSECpcr=sqrt(sum((ycal-(xcal*Bpcr+b0pcr)).^2)/ncal); % Validering
        RMSEPpcr=sqrt(sum((yval-(xval*Bpcr+b0pcr)).^2)/nval); % Validering

        Ta(:,1/2*a*(a-1)+1:1/2*a*(a+1)) = T; % Lagrer scores
        Pa(:,1/2*a*(a-1)+1:1/2*a*(a+1)) = P; % Lagrer loadings
        Ea(:,nvar*(a-1)+1:nvar*a) = E; % Lagrer residuale
        RMSEPpcra(a) = RMSEPpcr; % Lagrer RMSEP
        Bpcra(:,nvar*(a-1)+1:nvar*a)=Bpcr;
        b0pcra(a)=b0pcr;
    end
    for k=1:nvar % Finner hvilken modell som gir minimum RMSEP
        RMSEPpcr = RMSEPpcra(k);
        if  RMSEPpcr == min(RMSEPpcra)
            break;
        end
    end
    pk = k;
    T=Ta(:,1/2*k*(k-1)+1:1/2*k*(k+1)); % Lagrer optimal modell
    P=Pa(:,1/2*k*(k-1)+1:1/2*k*(k+1)); % Lagrer optimal modell
    E=Ea(:,nvar*(k-1)+1:nvar*k); % Lagrer optimal modell
    Bpcr=Bpcra(:,nvar*(k-1)+1:nvar*k)'; % Lagrer optimal modell
    b0pcr=b0pcra(k); % Lagrer optimal modell

else % Manuellt valg av komponenter
    a = A;
    pk = a;
    [U S V]=svd(xcal_s);
    U1 = U(:,1:a);
    S1 = S(1:a,1:a);
    V1 = V(:,1:a);
    T = U1*S1;                      % Score vector matrix.
    P = V1;                         % Loading vector matrix.
    E = xcal_s-T*P';                % Residuale

    b_s=P*pinv(T'*T)*T'*ycal_s; % eventuellt Bpcr=V1*pinv(S1)*U1'*y;

    if g == 1 % Uskalering av B
        b0pcr= (mean(ycal)-((mean(xcal).*(ones(1,nvar)*std(ycal)./std(xcal)))*b_s));
        Bpcr = (diag(ones(1,nvar)*std(ycal)./std(xcal)))*b_s;
    else
        b0pcr=0;
        Bpcr=b_s;
    end
    RMSECpcr=sqrt(sum((ycal-(xcal*Bpcr+b0pcr)).^2)/ncal); % Validering
    RMSEPpcr=sqrt(sum((yval-(xval*Bpcr+b0pcr)).^2)/nval); % Validering
end

