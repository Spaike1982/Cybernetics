function varargout = discretize_ss(dt, varargin)
%
% discretize_ss.m: Funksjon som danner en diskret modell av formen
%
%           x(k+1) = A*x(k) + B*u(k) + C*w(k)
%             y(k) = D*x(k) + E*u(k) + F*v(k)
%
% fra kontinuerlig modell av formen
%
%           dx/dt = Ac*x + Bc*u + Cc*w
%             y = Dc*x + Ec*u + Fc*v
%
% Basert på den eksakte løsningen av den kontinuerlige modellen
%
% Funksjonsrutine
%
%   varargout = discretize_ss(dt, varargin)
%
%   eksempel på brukemåte:
%
%   [Ad,Bd,Dd] = discretize_ss(dt, A, B, D)
%
% Andre funksjoner som kreves internt
%
% Innganger:
%
%   dt - Diskret sample tid dt = k+1-k
%   varargin - Modellmatriser som skal diskretiseres. (eks A, B, D)
%
% Utganger:
%
%   varargout - Diskrete modellmatrisene som spesifisert i varargin
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.
%
% Referanser:
%   [1] David Di Ruscio, "Optimal model based control", Lecture notes, 
% Telemark Univercity College, February 1997.

% Forsinkelse mellom pådrag og utgang 0 <= del < dt
del = 0;  % Vanlig antagelse
% Antall matriser
nop = length(varargin);
model = varargin;
% Loop gjennom varargin og diskretiser
for k=1:nop
    
    switch varargin{k}

        case {'A'}
            %%%========================================================
            %%%             Beregn A
            %%%========================================================
            A = expm(Ac*dt);
            varargout{k} = A;

        case {'B'}
            %%%========================================================
            %%%             Beregn B
            %%%========================================================
            if det(Ac) ~= 0 % Sjekker for singulæritet
            B = inv(Ac)*(expm(Ac*dt)-I)*Bc;
            else
                B = dt*Bc;  % Euler
            end
            varargout{k} = B;

        case {'D'}
            %%%========================================================
            %%%             Beregn D
            %%%========================================================
            D = Dc*expm(Ac*del);              
            varargout{k} = D;

        case{'E'}
            %%%========================================================
            %%%             Beregn E
            %%%========================================================
            E = Ec*expm(Ac*del);
            varargout{k} = E;
    end
end

%------------------------------------------------------------------------
%--------------