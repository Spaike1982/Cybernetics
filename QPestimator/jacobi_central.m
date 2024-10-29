function J = jacobi_central(fun,k,h,varargin)
%
% jacobi_central.m: Funksjon som beregner jacobimatrisen basert på 
% nummerisk sentral derivasjon.
%
% Fuksjonsrutine
% 
%   J = jacobi_central(fun,k,h,varargin);
% 
% Eksempel på brukemåte for f(x,u): J = jacobi_central('f',2,0.1,x,u) 
% J = df/du = [df1/du1,...,df1/dun; 
%              df2/du1,...,df2/dun
%               .            .
%              dfN/du1,...,dfN/dun]
% 
% Innganger:
% 
%   fun - Funksjon som skal deriveres
%   k - Variabel i funksjonen det skal deriveres rundt.
%   h - derivasjonsskritt
%   varargin - variable i funksjonen
%
% Utganger:
%   J - Jacobimatrisen
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.
%
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