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
signalNumberToPlot = 5; 
[~,numOfFiles] = size(filenames);
allPulses = {numOfFiles};
flag = {numOfFiles};
totalPulses = 0;
for i=1:numOfFiles
    dataStruct = load(filenames(i) + ".mat");
    dataArray = struct2array(dataStruct); 

    %pulses is a 2D array with dimensions (1 * numOfPulses)
    [pulses, mask, flag{i}] = stateDetection(dataArray, threshold);
        
    % Plot the extracted Signal 20 pulses for this particular file
    subplot(4, 4, i);
    hold on;
    [~, numOfPulses] = size(pulses);
    if (numOfPulses > 0)
        for j=1:numOfPulses
            plot(pulses{j}(:, signalNumberToPlot)); 
        end
    end
    title(filenames(i), 'Interpreter', 'none');



    % Combine the pulse data for this file with all the others    
    for pulseIndex = 1:numOfPulses
        for columnIndex = 1:12
            X{totalPulses + pulseIndex, columnIndex} = timetable(pulses{pulseIndex}(:, columnIndex), 'SampleRate', 1/Ts);
        end
    end
    
    %{
    for pulseIndex = 1:numOfPulses
        for columnIndex = 1:12
            Z{totalPulses + pulseIndex}(:,columnIndex) = timetable(pulses{pulseIndex}(:,columnIndex), 'SampleRate', 1/Ts);
        end
    end
    %}

    totalPulses = totalPulses + numOfPulses;
end


%{
% Plot the state detection signal vs 21:20 Actual Moment under Rollers
figure();
signalNumberToPlot = 5; % This is signal 21:20
for i=1:numOfFiles
    dataStruct = load(filenames(i) + ".mat");
    dataArray = struct2array(dataStruct);

    [pulses, mask, flag{i}] = stateDetection(dataArray, threshold);

    subplot(4, 4, i);
    hold on;
    plot(cell2mat(dataArray(signalNumberToPlot, 2)));
    plot(mask);
    title(filenames(i), 'Interpreter', 'none');
end
%}