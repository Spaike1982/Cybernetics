function J = jacobi_richardson(fun,k,varargin)
% jacobi.m - Danner jacob matrise basert på richardson ekstrapolasjon
% NB!: Funksjon designet for maksimal nøyaktighet og ikke hastighet
% 
% Innganger:
% fun - funksjon som benyttes, eks myfunction
% k - variabel i funksjonen som det skal deriveres rundt, 
% varargin - inngangsvariable i funksjonen, f.eks myfunction(x,u)
%
% Utganger:
% J - Jacobimatrisen
%
h = 0.1;           % Derivasjons step lengde
n = length(varargin{k});      % 
fx = feval(fun,varargin{:});    % Kun for å finne dimensjon
m = length(fx);
% Lager opp tom jacobimatrise
J = zeros(m,n);
% Initierer peturberte vektore
vararginh = varargin;
vararginh2 = varargin;
vararginl = varargin;
vararginl2 = varargin;
for i=1:n
    % Peturberer i begge retninger
    vararginh{k}(i) = varargin{k}(i) + h;
    vararginh2{k}(i) = varargin{k}(i) + h/2;
    vararginl{k}(i) = varargin{k}(i) - h;
    vararginl2{k}(i) = varargin{k}(i) - h/2;
    % Funksjonsverdier for peturberte vektore
    fxh = feval(fun,vararginh{:});
    fxh2 = feval(fun,vararginh2{:});
    fxl = feval(fun,vararginl{:});
    fxl2 = feval(fun,vararginl2{:});
    % Resetter Peturberte vektore
    vararginh{k}(i) = vararginh{k}(i) - h;
    vararginh2{k}(i) = vararginh2{k}(i) - h/2;
    vararginl{k}(i) = vararginl{k}(i) + h;
    vararginl2{k}(i) = vararginl2{k}(i) + h/2;
    % Nummerisk derivasjon med richardison ekstrapolasjon
    J(:,i) =(fxh2 - fxl2)/h + ((fxh2 - fxl2)/h - (fxh - fxl)/(2*h))/3; % Danner kolonne i i jacobimatrisa
end