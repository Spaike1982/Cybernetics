function varargout = linearize_peturb(x, w, v, u, epsilon, varargin)
%
% linearize_peturb.m: Funksjon som danner en line�r tilstandsrommodell:
%
%           x(k+1) = A*x(k) + B*u(k) + C*w(k)
%             y(k) = D*x(k) + E*u(k) + F*v(k)
%
% fra en uline�r modell:
%
%           dx/dt = f(x(k),u(k),w(k))
%            y(k) = g(x(k),u(k),v(k))
%
% Basert p� peturbasjon rundt et arbeidspunkt (xs,us)
%
% Funksjonsrutine
%
%   varargout = varargout = linearize(x, w, v, u ,varargin)
%
%   eksempel p� brukem�te:
%
%   [A,B,D] = linearize(x, w, v, u ,'A','B','D')
%
% Andre funksjoner som kreves internt
%
%   f.m - Tilstandsfunksjon av formen f(x,u,w)
%   g.m - M�lelining av formen g(x,u,v)
%
% Innganger:
%
%   x - Tilstandsvektor
%   w - Prosessforstyrrelse vektor
%   v - M�lest�y vektor
%   u - P�drag
%   epsilon - peturbajonsst�rrelse
%   varargin - Modellmatriser som skal finnes. (eks 'A','B','D')
%
% Utganger:
%
%   varargout - Modellmatrisene som spesifisert i varargin
%
% Merk:
%
%  1. De genrelle nummeriske peturbasjonsrutinene for jacobimatrisene A, B,
% .. kan og brude erstattes av analytisk derivasjonskode. 
%  2. For mer n�yaktig derivasjon se jacobi_central.m eller
%  jacobi_richardson.m
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved H�gskulen i
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
    epsilon = sqrt(eps);
elseif nia < 5 + nop
    error('[ linearize ] Ikke nok inngangsargumenter, se help linearize! ');
end

for k=1:nop

    switch varargin{k}

        case 'A'
            %%%========================================================
            %%%             Beregn A = df/dx
            %%%========================================================
            A  = zeros(nx, nx);
            %%%------------------
            fa = f(x,u,w);
            for j=1:nx
                xtemp = x;
                xtemp(j) = xtemp(j) + epsilon;
                fpa = f(xtemp,u,w);
                A(:,j) = (fpa-fa)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = A;


        case 'B'
            %%%========================================================
            %%%             Beregn B = df/du
            %%%========================================================
            B = zeros(nx, nu);
            %%%------------------
            fb = f(x,u,w);
            for j=1:nu
                utemp = u;
                utemp(j) = utemp(j) + epsilon;
                fpb = f(x,utemp,w);
                B(:,j) = (fpb-fb)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = B;


        case 'D'
            %%%========================================================
            %%%             Beregn D = dg/dx
            %%%========================================================
            D = zeros(ny, nx);
            %%%------------------
            fd = g(x,u,v);
            for j=1:nx
                xtemp = x;
                xtemp(j) = xtemp(j) + epsilon;
                fpd = g(xtemp,u,v);
                D(:,j) = (fpd-fd)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = D;


        case 'E'
            %%%========================================================
            %%%             Beregn E = dg/du
            %%%========================================================
            E = zeros(ny, nu);
            %%%------------------
            fe = g(x,u,v);
            for j=1:nu
                utemp = u;
                utemp(j) = utemp(j) + epsilon;
                fpe = g(x,utemp,v);
                E(:,j) = (fpe-fe)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = E;


        case 'C'
            %%%========================================================
            %%%             Beregn C = df/dw
            %%%========================================================
            C = zeros(nx, nw);
            %%%------------------
            fc = f(x,u,w);
            for j=1:nw
                wtemp = w;
                wtemp(j) = wtemp(j) + epsilon;
                fpc = f(x,u,wtemp);
                C(:,j) = (fpc-fc)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = C;


        case 'F'
            %%%========================================================
            %%%             Beregn F = dg/dv
            %%%========================================================
            F = zeros(ny, nv);
            %%%------------------
            ff = g(x,u,v);
            for j=1:nv
                vtemp = v;
                vtemp(j) = vtemp(j) + epsilon;
                fpf = g(x,u,vtemp);
                F(:,j) = (fpf-ff)/epsilon;
            end
            %%%--------------------------------------------------------
            varargout{k} = F;

        otherwise
            error('Ugyldig fuksjonsargument, se help linearize_peturb');
    end

end

%------------------------------------------------------------------------
%--------------