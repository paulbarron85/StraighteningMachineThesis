% selectedRow is the row from the R2 matrix that we want to check
% selectedFeature refers to the feature array and what data we want to take
function [selectedSignalArray, selectedSignalData, numOfSelectedSignals] = fnSelectSignals(selectedRow, selectedFeature, featureArray, R2, upperR2, lowerR2)
    numOfCombinedFeatures = size(R2, 1);
    selectedSignalArray = [selectedRow]; % Array of correlated features
    for i = 1:selectedRow-1
        if R2(i,selectedRow) > lowerR2 && R2(i,selectedRow) < upperR2
            selectedSignalArray = [selectedSignalArray i];
        end
    end
    for i = selectedRow + 1:numOfCombinedFeatures
        if R2(selectedRow,i) > lowerR2 && R2(selectedRow,i) < upperR2
            selectedSignalArray = [selectedSignalArray i];
        end
    end
    selectedSignalArray = sort(selectedSignalArray);
    numOfSelectedSignals = size(selectedSignalArray, 2);
    selectedSignalData = {numOfSelectedSignals};
    
    for i = 1:numOfSelectedSignals
        selectedSignalData{i} = featureArray(:, selectedFeature, selectedSignalArray(i));
    end
    
    numOfSelectedSignals = size(selectedSignalArray, 2);
end