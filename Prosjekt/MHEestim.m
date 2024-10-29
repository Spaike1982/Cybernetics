function [Xh,Xb,Yb,Phat,Pbar,t] = MHEestim(f,g,x0,Y,dt,tfin)

% Simulasjonsparametere
t = 1:dt:tfin;
nSim = length(t);
nx = length(x0);
ny = size(Y,2);
nw = nx;
nv = ny;
h = 1:size(Y,2);
h = h';
% Pådrag
u = 0;
nu = length(u);
B = zeros(nx,nu);
E = zeros(ny,nu);
% Støy
wm = zeros(nw,1);
vm = zeros(nv,1);
Rw = 10*eye(nx); % Korrelasjon mellom prosesstøy
Rv = 1e10*eye(ny); % Antar ingen korrelasjon mellom målinger
% Estimeringsløkke
xb = x0;
Pb = 0.01*eye(nx);
Ph = Pb;
% Horisont lengde
N = 10;
% Initierer horisonter med N gamle data
yN = zeros(N*ny,1);
for i = 1:N
yN(i*ny-ny+1:i*ny) = Y(i,1:ny)';
end

% Vekter for kriteriet
Qx1 = inv(Ph);
Qv = inv(Rv);
Qw = inv(Rw);
% Lagringsplass
Xb = zeros(nx,nSim);
Xh = Xb;
Yb = zeros(ny,nSim);
Pbar = zeros(nx,nx*nSim);
Phat = Pbar;
% Beskrankninger
xL = [0,600,950,5,6,40,41];
xH = [50,900,1200,40,41,100,101];
for k = N+1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av MHE : ',num2str(p)]);
    % Henter målinger
    y = Y(k,:)';
    
    z = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon)

    % Lagring
    Xh(:,k) = xh';                  % xh(k|k)
    Yb(:,k) = yb';                  % yb(k|k)
    Phat(:,nx*k-nx+1:nx*k) = Ph;    % Ph(k|k)

    % Plotting
    figure(1)
    plot(h,y,'*',h,yb);
end

