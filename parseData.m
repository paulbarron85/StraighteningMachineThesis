%{
SIGNALS (Ts = 0.02s)
21:28 Vibrationsmätn. Inkommande material (Vibration measurements. Incoming material) (mm/s) (0.02s)
21:36 Actual force (measured value for the foce) (KN) (0.02s)
21:35 Set point force (reference value for the force)  (KN) (0.02s)
21:20 Actual moment under Rolls (Nm) (0.02s)
21:12 Actual momento over Rolls (Nm) (0.02S)
21:31 Width position (mm) 0.02s
31:32 Height position (?) 0.02s
21:33 error position for height (?) 0.02s
21:34 error position for the width (?) 0.02s
21:10 Positon övervals (Position over Rolls) (mm) 0.02s
21:7 Vinklar övervals (Angle over Rolls) (degrees) 0.02s
21:17 Viknlar undervals (Angles under roll) (degrees) 0.02s
%}

close all; clear;
threshold = 600; % Threshold for state detection given by company

% Names of the signals in the data
SensorName = [  "21:28 Vibration measurements. Incoming material) (mm/s)"...
                "21:36 Actual force (measured value for the foce) (KN)"...
                "21:35 Set point force (reference value for the force)  (KN)"...
                "21:20 Actual moment under Rolls (Nm)"...
                "21:12 Actual momento over Rolls (Nm)"...
                "21:31 Width position (mm)"...
                "31:32 Height position (?)"...
                "21:33 error position for height (?)"...
                "21:34 error position for the width (?)"...
                "21:10 Positon övervals (Position over Rolls) (mm)"...
                "21:7 Vinklar övervals (Angle over Rolls) (degrees)"...
                "21:17 Viknlar undervals (Angles under roll) (degrees)"];

Ts = 0.02; % Sampling interval for data
filenames = [ "B_01_04" "B_02_04" "B_03_04" "B_04_04", "B_05_04" ...
              "B_06_04" "B_07_04" "B_08_04" "B_09_04" "B_10_04", ...
              "B_11_04" "B_12_04" "B_13_04" "B_30_03" "B_31_03" ];

% Loop through the files, load the data the perform the state detection
% Extract the pulses for each sensor signal based on Signal 20
figure(); 
signalNumberToPlot = 5; % 
numOfFiles = size(filenames, 2);
allPulses = {numOfFiles};
for i=1:numOfFiles
    dataStruct = load(filenames(i) + ".mat");
    dataArray = struct2array(dataStruct); 

    %pulses is a 2D array with dimensions (1 * numOfPulses)
    [pulses, mask, flag] = stateDetection(dataArray, threshold);
    
    [~, numOfPulses] = size(pulses);
    
    % Plot the etracted signal 20 pulses for this particular files
    subplot(4, 4, i);
    hold on;
    for j=1:numOfPulses
        plot(pulses{j}(:, signalNumberToPlot)); 
    end
    title(filenames(i), 'Interpreter', 'none');

    % Combine the pulse data for this file with all the others
    allPulses{i} = pulses;
end


% Plot the state detection signal vs Signal 20
figure();
signalNumberToPlot = 5;
for i=1:size(filenames, 2)
    dataStruct = load(filenames(i) + ".mat");
    dataArray = struct2array(dataStruct);

    [pulses, flag] = stateDetection(dataArray, threshold);

    subplot(4, 4, i);
    hold on;
    plot(cell2mat(dataArray(signalNumberToPlot, 2)));
    plot(flag);
    title(filenames(i), 'Interpreter', 'none');
end

pulseTable = cell2table (pulses);