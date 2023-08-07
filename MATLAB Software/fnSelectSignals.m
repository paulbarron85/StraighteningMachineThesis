function [selectedSignalArrayReduced, selectedSignalDataReduced, numOfSelectedSignalsReduced] = fnSelectSignals( ...
selectedSignal, selectedFeature, featureArray, R2, upperR2, lowerR2, r2ReducedThreshold, verbose)
%{
Description: This function...
Date: 2023/03/19
Author: Paul Barron
Inputs:  
    selectedSignal: INT, Signal # to analyse
    selectedFeature: INT, The feature selected to use for comparison with all the
    other signals
    featureArray: 3D array of INT, The feature data, an arry with dimensions
    num of pusles x num of features x num of sensors (224 x 16 x 12)
    R2: R2 data for all combinations of sensors, num of features x num of
    features (16 x 16)
    upperR2: INT, Upper range for the R2 threshold
    lowerR2: INT, Lower range for the R2 threshold
    r2ReducedThreshold: INT, Threshold for comparing subsequent R2 values
    verbose: Boolean, print out intermediate values
Outputs:    
    selectedSignalArray: 
    selectedSignalData:
    numOfSelectedSignals:
%}
    numOfCombinedFeatures = size(R2, 1);
    selectedSignalArray = []; % Array of correlated features
    for i = 1:selectedSignal-1
        if R2(i,selectedSignal) > lowerR2 && R2(i,selectedSignal) < upperR2
            selectedSignalArray = [selectedSignalArray i];
        end
    end
    for i = selectedSignal + 1:numOfCombinedFeatures
        if R2(selectedSignal,i) > lowerR2 && R2(selectedSignal,i) < upperR2
            selectedSignalArray = [selectedSignalArray i];
        end
    end

    selectedSignalArrayReduced = selectedSignalArray;
    for index1 = 1 : size(selectedSignalArrayReduced, 2)
        duplicates = [];
        for index2 = index1 + 1 : size(selectedSignalArrayReduced, 2)
            if R2(selectedSignalArrayReduced(index1), selectedSignalArrayReduced(index2)) > r2ReducedThreshold
                if verbose == true
                    fprintf("Sig %.0f Sig %.0f = %.2f", ...
                        selectedSignalArrayReduced(index1), ...
                        selectedSignalArrayReduced(index2), ...
                        R2(selectedSignalArrayReduced(index1), ...
                        selectedSignalArrayReduced(index2)));
                    fprintf('\n');
                end
                duplicates = [duplicates selectedSignalArrayReduced(index2)];
            end
        end
        
        for i = 1:size(duplicates, 2)
            ignoreFeature = duplicates(i);
            [tf,loc] = ismember(ignoreFeature, selectedSignalArrayReduced);
            selectedSignalArrayReduced(selectedSignalArrayReduced == ignoreFeature) = [];
        end
    end

    % Add the original selected feature back into the array
    selectedSignalArray = [selectedSignalArray selectedSignal]; 
    selectedSignalArray = sort(selectedSignalArray);
    numOfSelectedFeatures = size(selectedSignalArray, 2);
    selectedFeatureData = {numOfSelectedFeatures};
    
    for i = 1:numOfSelectedFeatures
        selectedFeatureData{i} = featureArray(:, selectedFeature, selectedSignalArray(i));
    end

    if verbose == true 
        disp(selectedSignalArray);
    end

    selectedSignalArrayReduced = [selectedSignalArrayReduced selectedSignal];
    selectedSignalArrayReduced = sort(selectedSignalArrayReduced);
    numOfSelectedSignalsReduced = size(selectedSignalArrayReduced, 2);
    selectedSignalDataReduced = {numOfSelectedSignalsReduced};

    for i = 1:numOfSelectedSignalsReduced
        selectedSignalDataReduced{i} = featureArray(:, selectedFeature, selectedSignalArray(i));
    end
    
    if verbose == true 
        disp(selectedSignalArrayReduced);
    end
end