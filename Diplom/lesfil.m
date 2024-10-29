function lesfil(filbane)
%% lesfil.m: 
% Funksjon for å importere data fra en fil
%
%% Innganger i fuksjonen:
% filbane:  Spesifiser hele filbanen, eksempel:
% lesfil('c:/mappe/undermappe/datafil.mat')
% 
%% Utganger i fuksjonen:
% variable med data fra innlest fil

% Importer filen
nydata = load('-mat', filbane);

% Lagrer variable med data, der variable får navn definert i filen.
variable = fieldnames(nydata);
for i = 1:length(variable)
    assignin('base', variable{i}, nydata.(variable{i}));
end
