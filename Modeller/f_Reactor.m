function dxdt = f(x,u,w)
%
% Vector field for the model from Exercise 6
%
%% Data for Level/Volumetric flow model of Exercise 6

% Vessel system
%--- volume:
V = 100; % liters
%--- heat transfer
homL = 7e5; % cal/mol
% Fluid data
%--- reactor density
rho = 1e3; % g/l
%--- coolant density
rhoc = rho;
%--- reactor heat capacity
cpS = 1; % cal/g/K
%--- coolant heat capacity
cpc = cpS;

% Reaction data
%--- preexponential factor
k0 = 7.2e10; % 1/min
%--- activation temperature
EdR = 9.98e3; % K
%--- reaction order
m = 1;
%--- reaction enthalpy
dHr = -2e5; % cal/mol

% Operational data
%--- reactor volumetric flow
dotV = u(2); % l/min
%--- reactor feed concentration
ciA = 1; % mol/l
%--- reactor feed temperature
Ti = 350; % K
%--- coolant volumetric flow
dotVc = u(1); % l/min
%--- coolant feed temperature
Tci = 350; % K

% Naming states
cA = x(1);
T = x(2);

% Vector fields for model
%--- reaction rate
r = k0*exp(-EdR/T)*cA^m;
%--- transferred heat
Qdot = dotVc*rhoc*cpc*(1 - exp(- homL/(rhoc*cpc*dotVc)))*(Tci - T);

%--- the vector fields
dcAdt = dotV*(ciA - cA)/V - m*r + w(1);
dTdt = dotV*(Ti - T)/V + (-dHr)*r/(rho*cpS) + Qdot/(rho*V*cpS) + w(2);

% Collecting vector fields in dydt
dxdt = [dcAdt; dTdt];