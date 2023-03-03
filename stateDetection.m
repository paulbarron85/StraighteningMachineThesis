%{
Description: This function...
Date: 
Author: Paul Barron
pulses: numOfPulses x numOfSignals x pulseNumOfSamples
mask: array of length numOfSamples
%}

function [pulses, mask, flag] = stateDetection(dataArrayLocal, threshold, minPulseTimeThreshold)
    
    % Extract signal #5 (Signal 20)
    signal20 = dataArrayLocal(5,2);
    signal20 = cell2mat(signal20);
    
    % 
    [numOfDataSamples, ~] = size(signal20);
    [numOfSensors, ~] = size(dataArrayLocal);
    mask = zeros(1, numOfDataSamples);
    
    % Loop through the data and record transitions from below 600 to above
    % and visa versa
    startValues = [];
    endValues = [];
    startLow = false;
    for i=2:numOfDataSamples
        if signal20(i) > threshold
            mask(i) = threshold;
        end

        if signal20(i) > threshold & signal20(i-1) <= threshold
            startValues(end+1) = i;
            startLow = true;
        end
        
        if signal20(i) < threshold & signal20(i-1) >= threshold & startLow
            endValues(end+1) = i;
        end
    end


    [~, numOfPulses] = size(startValues);
    pulses = {};
    for i = 1:numOfPulses
        signalArray = zeros(endValues(i)-startValues(i)+1, 12);
        for j = 1:numOfSensors
            arrayData = cell2mat(dataArrayLocal(j,2));
            columnToAdd = arrayData( startValues(i):endValues(i) );
            signalArray(:,j) = columnToAdd;
        end
        pulses{i} = signalArray;
    end


    % Check whether we think any of the pulses are not valid
    pulseLengths = endValues - startValues;
    flag = false(numOfPulses);
    medianPulseLength = median(pulseLengths);
    for i = 1:numOfPulses
        sprintf("Median %d Length: %d", medianPulseLength, pulseLengths(i));
        %if ((pulseLengths(i) > (medianPulseLength * 1.2)) || (pulseLengths(i) < (medianPulseLength * 0.8)))
        if pulseLengths(i) < minPulseTimeThreshold
            flag(i) = true;
        end
    end
end