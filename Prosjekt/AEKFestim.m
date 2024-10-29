function [Xh,Xb,Yb,Kk,Phat,Pbar,t] = AEKFestim(f,g,x0,Y,dt,tfin)

% Simulasjonsparametere
t = 1:dt:tfin;
nSim = length(t);
nx = length(x0);
ny = size(Y,2);
h = 1:size(Y,2);
h = h';
% Støy
wm = zeros(nx,1);
vm = zeros(ny,1);
% Initielle kovariansmatriser
Rwm1 = 1e-6*eye(nx);
Rvm1 = 1*eye(ny);
Lw = 1e6;
Lv = 10;
% Lagringsplass
Xb = zeros(nx,nSim);
Xh = Xb;
Yb = zeros(ny,nSim);
Kk = zeros(nx,ny*nSim);
Pbar = zeros(nx,nx*nSim);
Phat = Pbar;
% Estimeringsløkke
xb = x0;
Pb = 1*eye(nx);
% Beskrankninger
xL = [0,600,950,5,6,40,41];
xH = [50,900,1200,40,41,100,101];
for k = 1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av EKF : ',num2str(p)]);
    % Henter målinger
    y = Y(k,:)';
    
    % Lagring
    Xb(:,k) = xb';                  % xb(k|k-1)
    Pbar(:,nx*k-nx+1:nx*k) = Pb;    % Pb(k|k-1)
    
    xb = physcheck(xb,xL,xH);
    % Kalmanfilter
    [xh,xb,yb,K,Pb,Ph,Rw,Rv] = AEKF(f,g,xb,y,wm,vm,Pb,Rwm1,Rvm1,Lw,Lv,h,dt);
    Rwm1 = Rw;
    Rvm1 = Rv;
       
    % Lagring
    Xh(:,k) = xh';                  % xh(k|k)
    Yb(:,k) = yb';                  % yb(k|k)
    Kk(:,ny*k-ny+1:ny*k) = K;
    Phat(:,nx*k-nx+1:nx*k) = Ph;    % Ph(k|k)
    
    % Plotting
    figure(1)
    plot(h,y,'*',h,yb);
end
