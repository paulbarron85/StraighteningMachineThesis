%{
Description: This function
Date: 
Author: Paul Barron
%}

function [pulses, maskingFunction] = stateDetection(dataArrayLocal, threshold)
    
    signal20 = dataArrayLocal(5,2);
    signal20 = cell2mat(signal20);
    
    [dataLength, ~] = size(signal20);
    [numOfSignals, ~] = size(dataArrayLocal);
    x = [1:dataLength];
    maskingFunction = zeros(1, dataLength);
    
    startValues = [];
    endValues = [];
    startLow = false;
    for i=2:dataLength
        if signal20(i) > threshold
            maskingFunction(i) = threshold;
        end

        if signal20(i) > threshold & signal20(i-1) <= threshold
            startValues(end+1) = i;
            startLow = true;
        end
        
        if signal20(i) < threshold & signal20(i-1) >= threshold & startLow
            endValues(end+1) = i;
        end
    end

    arraySize = size(startValues);
    numOfPulses = arraySize(2);
    
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
end