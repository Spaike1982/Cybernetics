function J = jacobi_err(fun,B,x,y)
% jacobi.m - Danner jacob matrise
% 
% Innganger:
% fun - funksjon som benyttes, eks myfunction
% k - variabel i funksjonen som det skal deriveres rundt, 
% varargin - inngangsvariable i funksjonen, f.eks myfunction(x,u)
%
% Utganger:
% J - Jacobimatrisen
%
h = sqrt(eps);           % Derivasjons step lengde
n = length(B);      % 
fx = feval(fun,B,x) - y;    % Kun for å finne dimensjon
m = length(fx);
% Lager opp tom jacobimatrise
J = zeros(m,n);
% Initierer peturberte vektore
Bh = B;
for i=1:n
    % Peturberer
    Bh(i) = B(i) + h;
    % Funksjonsverdier for peturberte vektore
    fxh = feval(fun,Bh,x) - y;
    % Resetter Peturberte vektore
    Bh(i) = Bh(i) - h;
    % Nummerisk derivasjon
    J(:,i) = (fxh - fx)/h; % Danner kolonne i i jacobimatrisa
end