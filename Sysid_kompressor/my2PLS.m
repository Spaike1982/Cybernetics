function [w1,w2tilde,t1,tm2tilde,p2tilde,tw1tilde,tw2tilde]=my2PLS(xcal_s,ycal_s,W,A)
% Funksjon som reduserer en PLS modell til en 2PLS modell.
%
% Innput:   xcal_s - Aktuelle inngangsdata brukt i selve pls dekomposisjoen
%           ycal_s - Aktuelle utgangsdata brukt i selve pls dekomposisjoen
%           W - PLS komponenter.
%           A - Prinsippale komponenter brukt til � danne PLS modellen
%
% Output:   w1 - 1. 2pls komponent (lik som pls komponent)
%           w2tilde - 2. 2pls komponent
%           t1 - 1. x-score vektor
%           tm2tilde - 2. x-score vektor
%           p2tilde - 2. x-loading vektor
%           tw1tilde - 1. x-score vektor, ortogonal
%           tw2tilde - 2. x-score vektor, ortogonal


%% Kompressjon til 2PLS modell med kun 2 komponenter for prosessoverv�kning
% komprimerer til ikke ortogonal 2PLS faktorisering
X=xcal_s;
a=inv(W'*X'*X*W)*W'*X'*ycal_s;
w1=W(:,1); % 1. Loadingweight vektor (uforabdret)
w2tilde=W(:,2:A)*a(2:A)/norm(W(:,2:A)*a(2:A)); % 2. Loadingweight vektor (2PLS)
t1=X*w1;    % 1. X-scorevektor (uforandret)
tm2tilde=X*w2tilde; % 2. X-scorevektor (2PLS)
% Transformerer til ortogonale 2PLS scores
d=-t1'*tm2tilde/(tm2tilde'*tm2tilde);
f=sqrt(1+d^2);
p2tilde=(-d*w1+w2tilde)/f; % 2. X-Loadingvektor
tw1tilde=t1+d*tm2tilde; % 1. X-scorevektor
tw2tilde=f*tm2tilde; % 2. X-scorevektor