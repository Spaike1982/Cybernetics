function [Bh,Bb] = kalmanestim(fun,Bb,h,rho)

% Antall "tilstander"
nB = length(Bb);
% Antall "målinger"
nh = length(rho); % = length(h)
% Målestøy kovarians
Rv = 100*eye(nh);
% Prosesstøy kovarians (Jo høyere verdi jo raskere konvergens)
Rw = 100*eye(nB);
% Tilstandstransisjonsmatrise
A = eye(nB);
% Prosesstøy transisjonsmatrise
C = eye(nB);
% Måleligning
rhobar = feval(fun,Bb,h);
% Lineærisering av måleligning
D = jacobi_central(fun,1,Bb,h);
% Beregning av kalmanfilterforsterkning
K = dlqe(A,C,D,Rw,Rv);
% Aposteriori estimat
Bh = Bb + K*(rho-rhobar);
% Apriori Prediksjon

