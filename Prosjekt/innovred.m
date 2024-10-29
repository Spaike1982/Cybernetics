function [redinnov] = innovred(innov,redvec)

% For reduksjon av innovasjonsvektor slik at den kan benyttes sammen med 
% redusert K: fra redKFgain
ny = length(innov);
k = 2;
i = 1;
redinnov(i) = innov(i);
while k <= ny;
    % Sjekker for like kolonner 
    while redvec(i) ~= k
        redinnov(i) = redinnov(i) + innov(k);
        k = k + 1;
    end
    i = i + 1;
    redinnov(i) = innov(k);
    k = k + 1;
end