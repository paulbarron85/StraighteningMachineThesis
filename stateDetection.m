%{
Description: This function
Date: 
Author: Paul Barron
pulses: numOfPulses x numOfSignals x pulseNumOfSamples
mask: array of length numOfSamples
%}

function [pulses, mask, flag] = stateDetection(dataArrayLocal, threshold)
    
    % Extract signal #5 (Signal 20)
    signal20 = dataArrayLocal(5,2);
    signal20 = cell2mat(signal20);
    
    % 
    [fullDataLength, ~] = size(signal20);
    [numOfSignals, ~] = size(dataArrayLocal);
    mask = zeros(1, fullDataLength);
    
    % Loop through the data and record transitions from below 600 to above
    % and visa versa
    startValues = [];
    endValues = [];
    startLow = false;
    for i=2:fullDataLength
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
        for j = 1:numOfSignals
            arrayData = cell2mat(dataArrayLocal(j,2));
            columnToAdd = arrayData( startValues(i):endValues(i) );
            signalArray(:,j) = columnToAdd;
        end
        pulses{i} = signalArray;
    end

    % Todo: Add check to see if there are any false
    for i=1:size(startValues)
        sprintf("End values: %d Start values: %d Length: %d", endValues(i), startValues(i), endValues(i) - startValues(i))
    end
    flag = false;
end