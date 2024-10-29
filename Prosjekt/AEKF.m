function [xh,xb,yb,K,Pb,Ph,Rw,Rv] = AEKF(f,g,xb,y,wm,vm,Pb,Rwm1,Rvm1,Lw,Lv,h,dt)

% EKF.m: Adaptive Extended Kalman Filter, funksjon som beregner estimater
% av ikke m�lbare tilstander. Forskjellen p� det utvidede kalmanfilteretet
% mot et vanlig line�rt kalmanfilter er at det benytter seg av uline�re
% funksjoner og LTV modell i riccatiligningene slik at K kan vareiere med
% tiden. Dette filteret estimerer ogs� prosess og/eller
% m�lest�ykovariansmatrisene, derav navnet adaptivt.
%
% Basert p� en LTI modell av formen:
%   x(k+1) = Ax(k) + Bu(k) + Cw(k)
%   y(k) = Dx(k) + Eu(k) + Fv(k)
%
% Fuksjonsrutine:
%
%   [xh,xb,yb,K,Pb,Ph] = EKF(xb,u,y,wm,vm,Pb,Rw,Rv,dt)
%
% Andre funksjoner som kreves internt
%
%   f.m - Tilstandsfunksjon slik at f(x,u,wm)
%   g.m - M�lelining slik at g(x,u,vm)
%   rk4int - Integrasjon av tilstandsligning
%   javobi_central - Line�risering
%
% Innganger:
%
%   xb - Initiellt aprioriestimat av tilstandene
%   u - P�drag
%   y - M�linger
%   wm - Middelverdi av prosessforstyrrelse
%   vm - Midderlverdi av m�lest�y
%   Pb - Initiellt apriori tiltandskovarians matrise
%   Rw - Prosessforstyrrelse kovariansmatrise
%   Rv - M�lest�y kovariansmatrise
%   dt - sampletid slik at dt = k+1 - k
%
% Utganger:
%
%   xh - aposteriori estimat av tilstandene
%   xb - apriori estimat av tilstandene
%   yb - aprioris estimat av m�lingene
%   K - Kalmanfilterforsterkning
%   Pb - Apriori tilstandskovarians matrise
%   Ph - Aposteriori tilstandskovarians matrise
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved H�gskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] David Di Ruscio, "Tilstandsestimering og kalmanfilter",
%       Telemark university college, March 11, 2003.

%% Kalmanfilter algoritme:
% M�leoppdatering
yb = feval(g,xb,h,vm);

% Line�risering av m�leligning
D = jacobi_central(g,1,sqrt(eps),xb,h,vm);
F = jacobi_central(g,3,sqrt(eps),xb,h,vm);

% Kalmanfilterforsterkning.
K = Pb*D'*pinv(D*Pb*D' + F*Rvm1*F');

% Aposteriori tilstandsestimat
xh = xb + K*(y - yb);

% Avvik for adaptiv instilling
dx = xh-xb;
yh = feval(g,xh,h,vm);
dy = y - yh;

% Oppdatering av apriori estimat
xb = rk4int(f,dt,xh,wm);

% Line�risering av tilstandsligning
Ac = jacobi_central(f,1,sqrt(eps),xh,wm);
A = expm(Ac*dt); % Eksakt diskretisering
C = jacobi_central(f,2,sqrt(eps),xh,wm);

% Oppdatering av aposteriori tilstandskovriansmatrise
Ix = eye(size(A,1)); % Identitetsmatrise
Ph = (Ix-K*D)*Pb*(Ix-K*D)' + K*Rvm1*K';

% Oppdatering av prosesst�y kovariansmatrise
Rwo = dx*dx' + Pb - Ph - Rwm1;
% MA
Rw = Rwm1 + (Rwo-Rwm1)/Lw;

% Oppdatering av apriori tilstandskovariansmatrise
Pb = A*Ph*A' + C*Rwm1*C';

% Oppdatering av m�lest�ykovariansmatrise
Rv = Rvm1;

% Rvo = dy*dy' - D*Pb*D';
% % MA
% Rv = Rvm1 + (Rvo-Rvm1)/Lv;

