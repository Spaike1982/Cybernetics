function m = matrixrep(v,n,c,r)
%
% matrixrep.m: Matrix replicate, fleksibel funksjon for kopiering av
% vektore som baserer seg på kronecker produkt NB! for kopiering av kun
% vektore refereres det til vectorrep som er raskere.
%
% Funksjonsrutine:
%   m = matrixrep(v,n,c,r)
%
% Innganger:
%   v - Matrise eller vektor som skal kopieres
%   n - Antall kopier
%   c - Retning for kopiering, c = 1 gir rekkehvis kopiering og c = 2 gir
%   kolonnehvis kopiering
%   r - Antall repetisjoner av kopieringen
%
% Utgang:
%   m - Resulterende matrise.
%
% Dimensjon på m:
%   Hvis vi har en matrisen med dimensjon dim(v) = iXj som skal kopieres,
%   får m enten dimensjon (c = 1): dim(m)=i*n X j*r eller (c = 2):
%   dim(m) = i*r X j*n.
%
% Eksempel:
%   Hvis du har en kolonnevektor v, med dimensjon dim(v) = i X 1, som først
%   skal kopieres n ganger i rekkeretning, for
%   deretter å repeteres r ganger:
%
%   m = matrixrep(v,n,1,r), der den resulterende matrisen m er av dimensjon:
%   dim(m) = i*n X r
%
% Sluttkommentar
%   Laget av Henning Winsnes i forbindelse med masteroppgaven ved Høgskulen i
%   Telemark 2007.

if c == 1
    m = kron(ones(n,r),v);
else
    m = kron(ones(r,n),v);
end
