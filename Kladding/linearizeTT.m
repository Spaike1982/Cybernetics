function varargout = linearizeTT(x, w, v, u ,varargin)

% linearizeTT.m: Funksjon som danner en lineær tilstandsrommodell:
%
%           dx(k+1) = A*dx(k) + B*du(k) + C*dw(k)
%             dy(k) = D*dx(k) + E*du(k) + F*dv(k)
% 
%   der dx = x - xs, du = u - us, dy = y - ys, dw = w - ws, dv = v - vs
%   xs, us, ys, ws og vs er arbeidspunkter for den lineære modellen.
%
% fra en ulineær modell av Totanken ved HIT:
%
%           dx/dt = f(x(k),u(k),w(k))
%            y(k) = g(x(k),v(k))
%
% Funksjonsrutine
%
%   varargout = linearize(x, w, v, u ,varargin)
%
%   eksempel på brukemåte:
%
%   [A,B,C] = linearize(x, w, v, u ,'A','B','C')
%
%
% Innganger:
%
%   x - Tilstandsvektor
%   w - Prosessforstyrrelse vektor
%   v - Målestøy vektor
%   u - Pådrag for tilstander
%   u - Pådrag for målinger
%   varargin - Modellmatriser som skal finnes. (eks 'A','B','C')
%
% Utganger:
%
%   varargout - Modellmatrisene som spesifisert i varargin
%

% Dimensjoner
nx = length(x);
nu = length(u);
ny = length(g(x,u,v));
nw = length(w);
nv = length(v);

% Definerer konstanter fra oppgaveteksten:
K1 = 1097;
K2 = 1022; % For rigg 1
K3 = 423.22;
Ar  = 111.1; % [cm^2]

% Sjekker innganger
nop = length(varargin);
nia = nargin-1+nop;
if nia < 4 + nop
    error('[ linearize ] Ikke nok innganger, se help linearizeTT! ');
end

for k=1:nop

    switch varargin{k}

        case 'A'
            %%%========================================================
            %%%             Beregn A = df/dx
            %%%========================================================
            A = [-K1/(2*sqrt(x(1))*Ar), 0; K1/(2*sqrt(x(1))*Ar), -K2/(2*sqrt(x(2))*Ar)];
            %%%--------------------------------------------------------
            varargout{k} = A;


        case 'B'
            %%%========================================================
            %%%             Beregne B = df/du
            %%%========================================================
            B = [K3/Ar;0];
            %%%--------------------------------------------------------
            varargout{k} = B;


        case 'D'
            %%%========================================================
            %%%             Beregn D = dg/dx
            %%%========================================================
            D = eye(ny);
            %%%-------------------------------------------------------
            varargout{k} = D;


        case 'E'
            %%%========================================================
            %%%             Beregn E = dg/du
            %%%========================================================
            E = zeros(ny, nu);
            %%%--------------------------------------------------------
            varargout{k} = E;


        case 'C'
            %%%========================================================
            %%%             Beregn C = df/dw
            %%%========================================================
            C = eye(nx, nw);
            %%%--------------------------------------------------------
            varargout{k} = C;


        case 'F'
            %%%========================================================
            %%%             Beregn F = dg/dv
            %%%========================================================
            F = eye(ny, nv);
            %%%--------------------------------------------------------
            varargout{k} = F;

        otherwise
            error('[ linearize ] Ugyldig funksjonsargument, se help linearizeTT!');

    end

end

%------------------------------------------------------------------------
%--------------