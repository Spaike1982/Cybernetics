function [Xh,Xb,Yb,t] = curveestim(g,xb,Y,dt,tfin)

% Simulasjonsparametere
t = 1:dt:tfin;
nSim = length(t);
nx = length(xb);
ny = size(Y,2);
h = 1:ny;
h = h';
% Lager opp plass for lagring
Xb = zeros(nx,nSim);
Xh = Xb;
Yb = zeros(ny,nSim);
% Estimeringsløkke
% Beskrankninger
xL = [0,600,950,5,6,40,41];
xH = [50,900,1200,40,41,100,101];
for k = 1:nSim
    p = k/nSim*100;
    disp(['Prosent ferdig av Gauss Newton : ',num2str(p)]);
    % Hent ut målinger
    y = Y(k,:)';
    yb = feval(g,xb,h);
    Yb(:,k) = yb';
    Xb(:,k) = xb';
    xb = physcheck(xb,xL,xH);
    xh = gaussnewton(g,xb,h,y,0.1,20,xL,xH);
    Xh(:,k) = xh';
    xb = xh;
    
     % Plotting
    figure(1)
    plot(h,y,'*',h,yb);
end