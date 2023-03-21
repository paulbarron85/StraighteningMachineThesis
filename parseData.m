%{
SIGNALS (Ts = 0.02s)
1 21:28 Vibrationsmätn. Inkommande material (Vibration measurements. Incoming material) (mm/s) (0.02s)
2 21:36 Actual force (measured value for the foce) (KN) (0.02s)
3 21:35 Set point force (reference value for the force)  (KN) (0.02s)
4 21:20 Actual moment under Rolls (Nm) (0.02s)
5 21:12 Actual momento over Rolls (Nm) (0.02S)
6 21:31 Width position (mm) 0.02s
7 31:32 Height position (?) 0.02s
8 21:33 error position for height (?) 0.02s
9 21:34 error position for the width (?) 0.02s
10 21:10 Positon övervals (Position over Rolls) (mm) 0.02s
11 21:7 Vinklar övervals (Angle over Rolls) (degrees) 0.02s
12 21:17 Viknlar undervals (Angles under roll) (degrees) 0.02s
%}

close all; clear;

% Names of the signals in the data
sensorNames = [ "21:07 Angle over Rolls (degrees)"...
                "21:10 Position over Rolls (mm)"...
                "21:12 Actual moment over Rolls (Nm)"...
                "21:17 Angle under roll (degrees)"...
                "21:20 Actual moment under Rolls (Nm)"... 
                "21:28 Vibration measurements (mm per s)"...               
                "21:31 Width position (mm)"...
                "31:32 Height position (?)"...
                "21:33 Error position for height (?)"...
                "21:34 Error position for the width (?)"...
                "21:35 Set point force (KN)"... 
                "21:36 Actual force (KN)"];

pulseThreshold = 600; % Threshold for state detection given by company
minPulseTimeThreshold = 500; % Samples
Ts = 0.02; % Sampling interval for data
subfolder = "Data/";
filenames = [ "B_01_04" "B_02_04" "B_03_04" "B_04_04", "B_05_04" ...
              "B_06_04" "B_07_04" "B_08_04" "B_09_04" "B_10_04", ...
              "B_11_04" "B_12_04" "B_13_04" "B_30_03" "B_31_03" ];

% Loop through the files, load the data the perform the state detection
% Extract the pulses for each sensor signal based on Signal 20
figure(); 
signalNumberForDetection = 5;
signalNumberToPlot = 5; % This is signal 21:20
numOfSensors = 12;
[~,numOfFiles] = size(filenames);
mask = {numOfFiles};
flag = {numOfFiles};
pulseData_FunctionOutput = {numOfFiles};
rawDataArray = {numOfFiles};
totalPulses = 1;
for fileIndex=1:numOfFiles
    % Load the data for the current file
    rawDataStruct = load(subfolder + filenames(fileIndex) + ".mat");
    rawDataArray{fileIndex} = struct2array(rawDataStruct); 

    %pulses is a 2D array with dimensions (1 * numOfPulses)
    [pulseData_FunctionOutput{fileIndex}, mask{fileIndex}, flag{fileIndex}, maxPulseLengths(fileIndex)] = stateDetection(rawDataArray{fileIndex}, pulseThreshold, minPulseTimeThreshold, signalNumberForDetection);
    
    % Plot the extracted Signal 20 pulses for this particular file
    subplot(4, 4, fileIndex);
    hold on;
    numOfFalsePulses = 0;
    numOfTruePulses = 0;
    [~, numOfPulses] = size(pulseData_FunctionOutput{fileIndex});
    for pulseIndex=1:numOfPulses
        plot(pulseData_FunctionOutput{fileIndex}{pulseIndex}(:, signalNumberToPlot));
    end
    title(filenames(fileIndex), 'Interpreter', 'none');

    % Combine the pulse data for this file with all the others    
    for pulseIndex = 1:numOfPulses
        if flag{fileIndex}(pulseIndex) == false % Only include pulses that aren't marked as potential false ones
            for sensorIndex = 1:numOfSensors % Add data for each sensor
                tempData = pulseData_FunctionOutput{fileIndex}{pulseIndex}(:, sensorIndex);
                pulseData_Timetable{totalPulses, sensorIndex} = timetable(tempData, 'SampleRate', 1/Ts, 'VariableNames', sensorNames(sensorIndex));
            end
            totalPulses = totalPulses + 1;
        end
    end
end

%% Pad to the length of longest pulse
maxPulseLength = max(maxPulseLengths) + 1;
for fileIndex = 1:numOfFiles
    for pulseIndex = 1:size(pulseData_FunctionOutput{fileIndex},2)
        temp = pulseData_FunctionOutput{fileIndex}{pulseIndex};
        numSamplesUnderMax = maxPulseLength - size(temp, 1);
        pulseData_Padded{fileIndex}{pulseIndex} = padarray (temp, numSamplesUnderMax, 12, "post");
        pulseData_DcRemoved{fileIndex}{pulseIndex} = temp - mean(temp, 1);
    end
end

%% Combine the data for all padded pulses
totalPulses = 1;
for fileIndex=1:numOfFiles
    for pulseIndex = 1:size(pulseData_FunctionOutput{fileIndex},2)
        if flag{fileIndex}(pulseIndex) == false % Only include pulses that aren't marked as potential false ones
            for sensorIndex = 1:numOfSensors % Add data for each sensor
                tempData = pulseData_Padded{fileIndex}{pulseIndex}(:, sensorIndex);
                pulseDataPadded_Timetable{totalPulses, sensorIndex} = timetable(tempData, 'SampleRate', 1/Ts, 'VariableNames', sensorNames(sensorIndex));
            end
        end
        totalPulses = totalPulses + 1;
    end
end

%% Plot padded data
figure(); hold on;
for fileIndex=1:numOfFiles
    subplot(4, 4, fileIndex); hold on;
    for pulseIndex = 1:size(pulseData_Padded{fileIndex},2)
        %plot( pulseData_Padded{fileIndex}{pulseIndex}(:,5) );
        plot( pulseData_DcRemoved{fileIndex}{pulseIndex}(:,5) );
    end
end

%% Plot the state detection signal vs 21:20 Actual Moment under Rollers
figure();
for fileIndex=1:numOfFiles
    subplot(4, 4, fileIndex);
    hold on;
    plot(cell2mat(rawDataArray{fileIndex}(signalNumberToPlot, 2)));
    plot(mask{fileIndex});
    title(filenames(fileIndex), 'Interpreter', 'none');
end