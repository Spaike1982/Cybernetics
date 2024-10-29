clear; clc;

% Warning: Loading all data simultaneous takes long time. Its recomended
% to load needed data only.

%% Only air
% DACVenturi
Xa00 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_0.0kg_min.txt');
Xa02 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_0.2kg_min.txt');
Xa04 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_0.4kg_min.txt');
%DACInlet

%% Only water
% DACVenturi
Xw100 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Water_100kg_min.txt');
Xw150 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Water_150kg_min.txt');
Xw200 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Water_200kg_min.txt');
Xw220 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Water_220kg_min.txt');
Xw250 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Water_250kg_min.txt');
Xw300 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Water_300kg_min.txt');
% % DACInlet
% Xw220I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 Wat220_Gas0.txt');
% Xw250I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat250gas0.txt');
% Xw300I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat300gas0.txt');

%% Water an Air
% DACVenturi
Xa01w50 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.1_50kg_min.txt');
Xa01w100 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.1_100kg_min.txt');
Xa01w150 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.1_150kg_min.txt');
Xa01w200 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.1_200kg_min.txt');
Xa02w50 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.2_50kg_min.txt');
Xa02w100 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.2_100kg_min.txt');
Xa02w150 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.2_150kg_min.txt');
Xa02w200 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.2_200kg_min.txt');
Xa03w50 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.3_50kg_min.txt');
Xa03w100 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.3_100kg_min.txt');
Xa03w150 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.3_150kg_min.txt');
Xa03w200 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.3_200kg_min.txt');
Xa03w300 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.3_300kg_min.txt');
Xa04w50 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.4_50kg_min.txt');
Xa04w100 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.4_100kg_min.txt');
Xa04w150 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.4_150kg_min.txt');
Xa04w200 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.4_200kg_min.txt');
Xa05w50 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.5_50kg_min.txt');
Xa05w100 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.5_100kg_min.txt');
Xa05w150 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.5_150kg_min.txt');
Xa05w200 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.5_200kg_min.txt');
Xa06w50 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.6_50kg_min.txt');
Xa06w100 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.6_100kg_min.txt');
Xa06w150 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.6_150kg_min.txt');
Xa06w200 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.6_200kg_min.txt');
Xa06w300 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT_13102008\DACVenturi_Air_Water_0.6_300kg_min.txt');
% Testset for the day after
Xa06w200t = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat200gas0.6.txt');
% % DACInlet
% Xa01w50I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat50gas0.1.txt');
% Xa01w100I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat100gas0.1.txt');
% Xa01w150I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat150gas0.1.txt');
% Xa01w200I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat200gas0.1.txt');
% Xa02w50I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat50gas0.2.txt');
% Xa02w100I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat100gas0.2.txt');
% Xa02w150I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat150gas0.2.txt');
% Xa02w200I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat200gas0.2.txt');
% Xa03w50I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat50gas0.3.txt');
% Xa03w100I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat100gas0.3.txt');
% Xa03w150I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat150gas0.3.txt');
% Xa03w200I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat200gas0.3.txt');
% Xa03w300I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat300gas0.3.txt');
% Xa04w50I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat50gas0.4.txt');
% Xa04w100I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat100gas0.4.txt');
% Xa04w150I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat150gas0.4.txt');
% Xa04w200I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat200gas0.4.txt');
% Xa05w50I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat50gas0.5.txt');
% Xa05w100I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat100gas0.5.txt');
% Xa05w150I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat150gas0.5.txt');
% Xa05w200I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat200gas0.5.txt');
% Xa06w50I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat50gas0.6.txt');
% Xa06w100I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat100gas0.6.txt');
% Xa06w150I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat150gas0.6.txt');
% Xa06w200I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat200gas0.6.txt');
% Xa06w300I = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\VenturiFlowHITOctober2008DAC2\13.10.2008 wat300gas0.6.txt');


%% Water and air slugs 
% adjusted to Water 200 [kg/min] and gas 0.5 [kg/min]. Reference flowrates
% logged in ividual files
Xg2w2 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat100gas0.5_SlugtimeG2W2.txt');
Xg2w4 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat100gas0.5_SlugtimeG2W4.txt');
Xg4w2 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat100gas0.5_SlugtimeG4W2.txt');
Xg4w4 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat100gas0.5_SlugtimeG4W4.txt');
Xg5w10 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat100gas0.5_SlugtimeG5W10.txt');
Xg10w5 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat100gas0.5_SlugtimeG10W5.txt');
Xg10w10 = load('\\dilbert\users\henningw\Documents\Jobb\Prediktor\Prosjekter\StatoilHydroLogging\Loggedata\HIT14102008\wat100gas0.5_SlugtimeG10W10.txt');