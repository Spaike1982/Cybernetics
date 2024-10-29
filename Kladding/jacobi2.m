function J = jacobi2(fun,k,varargin)
% jacobi.m - Danner jacob matrise basert på sentral derivasjon
% NB!: Funksjon designet for nøyaktighet og ikke hastighet
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
vararginl = varargin;
for i=1:n
    % Peturberer i begge retninger
    vararginh{k}(i) = varargin{k}(i) + h;
    vararginl{k}(i) = varargin{k}(i) - h;
    % Funksjonsverdier for peturberte vektore
    fxh = feval(fun,vararginh{:});
    fxl = feval(fun,vararginl{:});
    % Resetter Peturberte vektore
    vararginh{k}(i) = vararginh{k}(i) - h;
    vararginl{k}(i) = vararginl{k}(i) + h;
    % Nummerisk derivasjon med sentral formulering
    J(:,i) = (fxh - fxl)/(2*h); % Danner kolonne i i jacobimatrisa
end