% 2. Ordens transferfunksjonstest
clear; clc; format short g

% Frekvens formulering
zeta = 1; % Kritisk dempet
K = 1; % Forsterkning
omega = 1; % Udempet resonansvinkelfrekvens
tau = 1; % Tidsforsinkelse

sys = tf(K, [(zeta/omega)^2 2*zeta/omega 1], 'OutputDelay', tau)
step(sys)
% Tids formulering

