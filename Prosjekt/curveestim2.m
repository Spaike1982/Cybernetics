function [Xh,Xb,Yb,t] = curveestim2(f,g,xb,Y,dt,tfin)

% Simulasjonsparametere
t = 1:dt:tfin;
nSim = length(t);
nx = length(xb);
ny = size(Y,2);
h = 1:ny;
h = h';
% Målestøy
v0 = zeros(ny,1);
w0 = zeros(nx,1);
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
    disp(['Prosent ferdig av lsqcurvefit : ',num2str(p)]);
    % Hent ut målinger
    y = Y(k,:)';
    yb = feval(g,xb,h,v0);
    Yb(:,k) = yb';
    Xb(:,k) = xb';
    xh = lsqcurvefit(g,xb,h,y,xL,xH);
    Xh(:,k) = xh';
    xb = rk4int(f,dt,xh,w0);
    
    % Plotting
    figure(1)
    plot(h,y,'*',h,yb);
end
