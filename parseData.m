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

% Names of the signals in the data
sensorNames = [ "21:28 Vibration measurements (mm per s)"...
                "21:36 Actual force (KN)"...
                "21:35 Set point force (KN)"...
                "21:20 Actual moment under Rolls (Nm)"...
                "21:12 Actual moment over Rolls (Nm)"...
                "21:31 Width position (mm)"...
                "31:32 Height position (?)"...
                "21:33 Error position for height (?)"...
                "21:34 Error position for the width (?)"...
                "21:10 Position over Rolls (mm)"...
                "21:07 Angle over Rolls (degrees)"...
                "21:17 Angle under roll (degrees)"];

pulseThreshold = 600; % Threshold for state detection given by company
minPulseTimeThreshold = 500; % Samples
Ts = 0.02; % Sampling interval for data
filenames = [ "B_01_04" "B_02_04" "B_03_04" "B_04_04", "B_05_04" ...
              "B_06_04" "B_07_04" "B_08_04" "B_09_04" "B_10_04", ...
              "B_11_04" "B_12_04" "B_13_04" "B_30_03" "B_31_03" ];

% Loop through the files, load the data the perform the state detection
% Extract the pulses for each sensor signal based on Signal 20
figure(); 
signalNumberToPlot = 5; 
[~,numOfFiles] = size(filenames);
mask = {numOfFiles};
flag = {numOfFiles};
pulsesInSingleFile = {numOfFiles};
rawDataArray = {numOfFiles};
totalPulses = 1;
for fileIndex=1:numOfFiles
    % Load the data for the current file
    rawDataStruct = load(filenames(fileIndex) + ".mat");
    rawDataArray{fileIndex} = struct2array(rawDataStruct); 

    %pulses is a 2D array with dimensions (1 * numOfPulses)
    [pulsesInSingleFile{fileIndex}, mask{fileIndex}, flag{fileIndex}] = stateDetection(rawDataArray{fileIndex}, pulseThreshold, minPulseTimeThreshold);
    
    % Plot the extracted Signal 20 pulses for this particular file
    subplot(4, 4, fileIndex);
    hold on;
    numOfFalsePulses = 0;
    numOfTruePulses = 0;
    [~, numOfPulses] = size(pulsesInSingleFile{fileIndex});
    for pulseIndex=1:numOfPulses
        plot(pulsesInSingleFile{fileIndex}{pulseIndex}(:, signalNumberToPlot)); 
        if (flag{fileIndex}(pulseIndex) == true)
            numOfFalsePulses = numOfFalsePulses + 1;
        else
            numOfTruePulses = numOfTruePulses + 1;
        end
    end
    title(filenames(fileIndex), 'Interpreter', 'none');
    %sprintf("%d: False: %d True: %d", i, numOfFalsePulses, numOfTruePulses)

    % Combine the pulse data for this file with all the others    
    for pulseIndex = 1:numOfPulses
        if flag{fileIndex}(pulseIndex) == false
            for sensorIndex = 1:12
                combinedPulseData{totalPulses, sensorIndex} = timetable(pulsesInSingleFile{fileIndex}{pulseIndex}(:, sensorIndex), 'SampleRate', 1/Ts, 'VariableNames', sensorNames(sensorIndex));
            end
            totalPulses = totalPulses + 1;
        end
    end
end


% Plot the state detection signal vs 21:20 Actual Moment under Rollers
figure();
signalNumberToPlot = 5; % This is signal 21:20
for fileIndex=1:numOfFiles
    subplot(4, 4, fileIndex);
    hold on;
    plot(cell2mat(rawDataArray{fileIndex}(signalNumberToPlot, 2)));
    plot(mask{fileIndex});
    title(filenames(fileIndex), 'Interpreter', 'none');
end