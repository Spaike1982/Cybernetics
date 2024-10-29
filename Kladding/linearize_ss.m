function varargout = linearize_ss(x, w, v, u, dt, varargin)
%
% linearize_ss.m: Funksjon som danner en lineær tilstandsrommodell:
%
%           x(k+1) = A*x(k) + B*u(k) + C*w(k)
%             y(k) = D*x(k) + E*u(k) + F*v(k)
%
% fra en ulineær modell:
%
%           dx/dt = f(x(k),u(k),w(k))
%            y(k) = g(x(k),u(k),v(k))
%
% Basert på stedady state error reduction
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
%   staionary.m - For å finne stasjonær tilstand
%
% Innganger:
%
%   x - Tilstandsvektor
%   w - Prosessforstyrrelse vektor
%   v - Målestøy vektor
%   u - Pådrag
%   dt - Diskret sample tid dt = k+1-k
%   varargin - Modellmatriser som skal finnes. (eks 'A','B','D')
%
% Utganger:
%
%   varargout - Modellmatrisene som spesifisert i varargin
%
% Merk:
%   1. For å finne matrisene B, og E er det et krav at A og D er funnet
%   først. Slik at [B] = linearize(x, w, v, u ,'B') vil gi feilmelding.
%   Korrekt måte er [A,B] = linearize(x, w, v, u ,'A','B').
%   2. De nummeriske ligingene for jacobimatrisene A, B, .. kan og
%   brude erstattes av analytisk derivasjonskode.
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
if nia < 5 + nop
    error('[ linearize ] Ikke nok inngangsargumenter, se help linearize! ');
end

epsilon = sqrt(eps); % Peturbasjon step størrelse

for k=1:nop

    switch varargin{k}

        case {'A'}
            %%%========================================================
            %%%             Beregn A = df/dx
            %%%========================================================
            A  = zeros(nx, nx);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            fa = f(x,u,w);
            xpa = x;
            for j=1:nx
                xpa(j) = x(j) + epsilon;
                fpa = f(xpa,u,w);
                dxa(:,j) = xpa - x;
                dfa(:,j) = fpa - fa;
                xpa(j) = x(j);
            end
            A = dfa*inv(dxa);
            %%%--------------------------------------------------------
            varargout{k} = A;

        case {'B'}
            %%%========================================================
            %%%             Beregn B = df/du
            %%%========================================================
            B = zeros(nx, nu);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            upb = u;
            for j=1:nu
                upb(j) = u(j) + epsilon;
                xpb = stationary('f',x,dt,upb,w);
                dub(:,j) = upb - u;
                dxb(:,j) = xpb - x;
                upb(j) = u(j);
            end
            B = -A*dxb*inv(dub);
            %%%--------------------------------------------------------
            varargout{k} = B;

        case {'D'}
            %%%========================================================
            %%%             Beregn D = dg/dx
            %%%========================================================
            D = zeros(ny, nx);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            yc = g(x,u,v);
            xpc = x;
            for j=1:nx
                xpc(j) = x(j) + epsilon;
                ypc = g(xpc,u,v);
                dxc(:,j) = xpc - x;
                dyc(:,j) = ypc - yc;
                xpc(j) = x(j);
            end
            D = dxc*inv(dyc);
            %%%--------------------------------------------------------
            varargout{k} = D;

        case{'E'}
            %%%========================================================
            %%%             Beregn E = dg/du
            %%%========================================================
            E = zeros(ny, nu);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            yd = g(x,u,v);
            upd = u;
            for j=1:nu
                upd(j) = u(j) + epsilon;
                xpd = stationary('f',x,dt,upd,w);
                ypd = g(xpd,upd,v);
                dud(:,j) = upd - u;
                dxd(:,j) = xpd - x;
                dyd(:,j) = ypd - yd;
                upd(j) = u(j);
            end
            E = (dyd-D*dxd)*inv(dud);
            %%%--------------------------------------------------------
            varargout{k} = E;


        case 'C'
            %%%========================================================
            %%%             Beregn C = df/dw
            %%%========================================================
            C = zeros(nx, nw);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            fg = f(x,u,w);
            wpg = w;
            for j=1:nx
                wpg(j) = w(j) + epsilon;
                fpg = f(x,u,wpg);
                dwg(:,j) = wpg - w;
                dfg(:,j) = fpg - fg;
                wpg(j) = w(j);
            end
            C = dfg*inv(dwg);
            %%%--------------------------------------------------------
            varargout{k} = C;
            
        case 'F' % Her benyttes peturbasjonsmetoden
            %%%========================================================
            %%%             Beregn F = dg/dv
            %%%========================================================
            F = zeros(ny, nv);
            %%%---------- Erstatt denne seksjonen med analytisk uttrykk--------
            yh = g(x,u,v);
            vph = v;
            for j=1:nv
                vph(j) = v(j) + epsilon;
                yph = g(x,u,vph);
                dvh(:,j) = vph - v;
                dyh(:,j) = yph - yh;
                vph(j) = v(j);
            end
            F = dyh*inv(dvh);
            %%%--------------------------------------------------------
            varargout{k} = F;

        otherwise
            error('[ linearize ] Ugyldig fuksjonsargument, se help linearize');
    end

end

%------------------------------------------------------------------------
%--------------