function H = hessian(fun,k,varargin)
% Hessian.m - Danner Hessiske matrise basert p� nummerisk sentral derivajson.
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
fx = feval(fun,varargin{:});    % Kun for � finne dimensjon
m = length(fx);
% Lager opp tom jacobimatrise
H = zeros(m,n);
% Initierer peturberte vektore
vararginh = varargin;
vararginl = varargin;
for i=1:n
    % Peturberer i begge retninger
    vararginh{k}(i) = varargin{k}(i) + h;
    vararginl{k}(i) = varargin{k}(i) - h;
    % Funksjonsverdier for peturberte vektore
    fx = feval(fun,varargin{:});
    fxh = feval(fun,vararginh{:});
    fxl = feval(fun,vararginl{:});
    % Resetter Peturberte vektore
    vararginh{k}(i) = vararginh{k}(i) - h;
    vararginl{k}(i) = vararginl{k}(i) + h;
    % Nummerisk derivasjon med sentral formulering
    H(:,i) = (fxh - 2*fx + fxl)/(h^2); % Danner kolonne i
end