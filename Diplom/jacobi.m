function J = jacobi(fun,k,varargin)
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
n = length(varargin{k});      % 
fx = feval(fun,varargin{:});    % Kun for å finne dimensjon
m = length(fx);
% Lager opp tom jacobimatrise
J = zeros(m,n);
% Initierer peturberte vektore
vararginh = varargin;
for i=1:n
    % Peturberer
    vararginh{k}(i) = varargin{k}(i) + h;
    % Funksjonsverdier for peturberte vektore
    fxh = feval(fun,vararginh{:});
    % Resetter Peturberte vektore
    vararginh{k}(i) = vararginh{k}(i) - h;
    % Nummerisk derivasjon
    J(:,i) = (fxh - fx)/h; % Danner kolonne i i jacobimatrisa
end