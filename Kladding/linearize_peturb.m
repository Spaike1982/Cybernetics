function varargout = linearize_peturb(x, w, v, u ,varargin)
%
% linearize_peturb.m: Funksjon som danner en lineær tilstandsrommodell:
%
%           x(k+1) = A*x(k) + B*u(k) + C*w(k)
%             y(k) = D*x(k) + E*u(k) + F*v(k)
%
% fra en ulineær modell:
%
%           dx/dt = f(x(k),u(k),w(k))
%            y(k) = g(x(k),u(k),v(k))
%
% Basert på peturbasjon rundt et arbeidspunkt (xs,us)
%
% Funksjonsrutine
%
%   varargout = varargout = linearize(x, w, v, u ,varargin)
%
%   eksempel på brukemåte:
%
%   [A,B,D] = linearize(x, w, v, u ,'A','B','D')
%
% Andre funksjoner som kreves internt
%
%   f.m - Tilstandsfunksjon
%   g.m - Målelining
%
% Innganger:
%
%   x - Tilstandsvektor
%   w - Prosessforstyrrelse vektor
%   v - Målestøy vektor
%   u - Pådrag
%   varargin - Modellmatriser som skal finnes. (eks 'A','B','D')
%
% Utganger:
%
%   varargout - Modellmatrisene som spesifisert i varargin
%
% Merk:
%
%   De genrelle nummeriske peturbasjonsrutinene for jacobimatrisene A, B,
% .. kan og brude erstattes av analytisk derivasjonskode.
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] BHARATH REDDY ENDURTHI, "LINEARIZATION AND HEALTH ESTIMATION 
%       OF ATURBOFAN ENGINE", Masters Thesis, Cleverland State Univercity,
%       December 2004        

% Dimensjoner
nx = length(x);
nu = length(u);
ny = length(g(x,u,v));
nw = length(w);
nv = length(v);

% Sjekk antall innganger
nop = length(varargin);
nia = nargin-1+nop;
if nia < 4 + nop
    error('[ linearize ] Ikke nok inngangsargumenter, se help linearize! ');
end

epsilon = sqrt(eps); % Peturbasjon step størrelse

for k=1:nop

    switch varargin{k}

        case 'A'
            %%%========================================================
            %%%             Beregn A = df/dx
            %%%========================================================
            A  = zeros(nx, nx);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            f1 = f(x,u,w);
            for j=1:nx
                xtemp = x;
                xtemp(j) = xtemp(j) + epsilon;
                f2 = f(xtemp,u,w);
                A(:,j) = (f2-f1)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = A;


        case 'B'
            %%%========================================================
            %%%             Beregn B = df/du
            %%%========================================================
            B = zeros(nx, nu);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            f1 = f(x,u,w);
            for j=1:nu
                utemp = u;
                utemp(j) = utemp(j) + epsilon;
                f2 = f(x,utemp,w);
                B(:,j) = (f2-f1)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = B;


        case 'D'
            %%%========================================================
            %%%             Beregn D = dg/dx
            %%%========================================================
            D = zeros(ny, nx);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            f3 = g(x,u,v);
            for j=1:nx
                xtemp = x;
                xtemp(j) = xtemp(j) + epsilon;
                f4 = g(xtemp,u,v);
                D(:,j) = (f4-f3)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = D;


        case 'E'
            %%%========================================================
            %%%             Beregn E = dg/du
            %%%========================================================
            E = zeros(ny, nu);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            f3 = g(x,u,v);
            for j=1:nu
                utemp = u;
                utemp(j) = utemp(j) + epsilon;
                f4 = g(x,utemp,v);
                E(:,j) = (f4-f3)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = E;


        case 'C'
            %%%========================================================
            %%%             Beregn C = df/dw
            %%%========================================================
            C = zeros(nx, nw);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            f1 = f(x,u,w);
            for j=1:nw
                wtemp = w;
                wtemp(j) = wtemp(j) + epsilon;
                f5 = f(x,u,wtemp);
                C(:,j) = (f5-f1)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = C;


        case 'F'
            %%%========================================================
            %%%             Beregn F = dg/dv
            %%%========================================================
            F = zeros(ny, nv);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            f3 = g(x,u,v);
            for j=1:nv
                vtemp = v;
                vtemp(j) = vtemp(j) + epsilon;
                f6 = g(x,u,vtemp);
                F(:,j) = (f6-f3)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = F;

        otherwise
            error('Ugyldig fuksjonsargument, se help linearize_peturb');
    end

end

%------------------------------------------------------------------------
%--------------