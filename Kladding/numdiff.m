function dfx = numdiff(fx,x)
% Nummerisk derivasjon av en vektor basert på central differences
% For høyrere ordens deriverte deriveres resultatet n ganger, eks 2. deriverte:
% d2f = numdiff(numdiff(f)). Variabel step lengde er ingen problem,
% Deriverer også i alle punkter i motsetning til matlabs diff som ikke tar
% med siste punkt
%
% Innganger:
% fun - funksjon som benyttes, eks myfunction
% k - variabel i funksjonen som det skal deriveres rundt,
% varargin - inngangsvariable i funksjonen, f.eks x,u i myfunction(x,u)
%
% Utganger:
% dfx - Deriverte av fx
%
n = size(fx,2);
dfx = zeros(size(fx));

% Central differences
% Første punkt
dfx(:,1) = (-3*fx(:,1) + 4*fx(:,2) - fx(:,3))/(x(3)-x(1));
% Vanli central differences
dfx(:,2:n-1) = (fx(:,3:n) - fx(:,1:n-2))./(x(3:end)-x(1:end-2));
% Siste punkt
dfx(:,n) = (fx(:,n-2) - 4*fx(:,n-1) + 3*fx(:,n))/(x(end)-x(end-2));
