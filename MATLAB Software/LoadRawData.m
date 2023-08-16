%{
    Load the filenames and sensor names to use in other scripts
%}

clear;
close all;
warning off;
saveFigures = false;

% Names of the signals in the data
sensorNames = [ "21:07 Angle over Rolls (deg)"...
                "21:10 Position over Rolls (mm)"...
                "21:12 Actual moment over Rolls (Nm)"...
                "21:17 Angle under roll (degrees)"...
                "21:20 Actual moment under Rolls (Nm)"... 
                "21:28 Vibration measurements (mm/s)"...               
                "21:31 Width position (mm)"...
                "21:32 Height position (mm)"...
                "21:33 Error position for height (mm)"...
                "21:34 Error position for the width (mm)"...
                "21:35 Set point force (kN)"... 
                "21:36 Actual force (kN)"];
numOfSignals = size(sensorNames, 2);

% Names of the signals in the data
sensorUnits = [ "Angle over (deg)"...
                "Pos over (mm)"...
                "Moment over (Nm)"...
                "Angle under (deg)"...
                "Moment under (Nm)"... 
                "Vibration (mm/s)"...               
                "Width position (mm)"...
                "Height position (mm)"...
                "Error height (mm)"...
                "Error width (mm)"...
                "SP force (KN)"... 
                "Act force (KN)"];

Ts = 0.02; % Sampling interval for data
fs = 1 / Ts;
dataSubfolder = "../SMT_data_20220520/";

filenames = [ "B_30_03" "B_31_03" "B_01_04" "B_02_04" ...
              "B_03_04" "B_04_04" "B_05_04" "B_06_04" ...
              "B_07_04" "B_08_04" "B_09_04" "B_10_04" ...
              "B_11_04" "B_12_04" "B_13_04" ];
numOfFiles = size(filenames, 2);