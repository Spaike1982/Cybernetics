function [Bh,Bb] = kalmanestim(fun,Bb,h,rho)

% Antall "tilstander"
nB = length(Bb);
% Antall "m�linger"
nh = length(rho); % = length(h)
% M�lest�y kovarians
Rv = 100*eye(nh);
% Prosesst�y kovarians (Jo h�yere verdi jo raskere konvergens)
Rw = 100*eye(nB);
% Tilstandstransisjonsmatrise
A = eye(nB);
% Prosesst�y transisjonsmatrise
C = eye(nB);
% M�leligning
rhobar = feval(fun,Bb,h);
% Line�risering av m�leligning
D = jacobi_central(fun,1,Bb,h);
% Beregning av kalmanfilterforsterkning
K = dlqe(A,C,D,Rw,Rv);
% Aposteriori estimat
Bh = Bb + K*(rho-rhobar);
% Apriori Prediksjon

