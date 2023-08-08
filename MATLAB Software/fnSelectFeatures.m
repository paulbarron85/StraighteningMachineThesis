function [selectedFeatureArrayReduced, selectedFeatureDataReduced, numOfSelectedFeaturesReduced] = fnSelectFeatures( ...
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
    selectedFeatureArray: 
    selectedFeatureData:
    numOfSelectedFeatures:
%}
    numOfCombinedFeatures = size(R2, 1);
    selectedFeatureArray = []; % Array of correlated features
    for i = 1:selectedFeature-1
        if R2(i,selectedFeature) > lowerR2 && R2(i,selectedFeature) < upperR2
            selectedFeatureArray = [selectedFeatureArray i];
        end
    end
    for i = selectedFeature + 1:numOfCombinedFeatures
        if R2(selectedFeature,i) > lowerR2 && R2(selectedFeature,i) < upperR2
            selectedFeatureArray = [selectedFeatureArray i];
        end
    end

    selectedFeatureArrayReduced = selectedFeatureArray;
    for index1 = 1 : size(selectedFeatureArrayReduced, 2)
        duplicates = [];
        for index2 = index1 + 1 : size(selectedFeatureArrayReduced, 2)
            if R2(selectedFeatureArrayReduced(index1), selectedFeatureArrayReduced(index2)) > r2ReducedThreshold
                if verbose == true
                    fprintf("Sig %.0f Sig %.0f = %.2f", ...
                        selectedFeatureArrayReduced(index1), ...
                        selectedFeatureArrayReduced(index2), ...
                        R2(selectedFeatureArrayReduced(index1), ...
                        selectedFeatureArrayReduced(index2)));
                    fprintf('\n');
                end
                duplicates = [duplicates selectedFeatureArrayReduced(index2)];
            end
        end
        
        for i = 1:size(duplicates, 2)
            ignoreFeature = duplicates(i);
            [tf,loc] = ismember(ignoreFeature, selectedFeatureArrayReduced);
            selectedFeatureArrayReduced(selectedFeatureArrayReduced == ignoreFeature) = [];
        end
    end

    % Add the original selected feature back into the array
    selectedFeatureArray = [selectedFeatureArray selectedFeature]; 
    selectedFeatureArray = sort(selectedFeatureArray);

    selectedFeatureArrayReduced = [selectedFeatureArrayReduced selectedFeature];
    selectedFeatureArrayReduced = sort(selectedFeatureArrayReduced);
    numOfSelectedFeaturesReduced = size(selectedFeatureArrayReduced, 2);
    selectedFeatureDataReduced = {numOfSelectedFeaturesReduced};

    for i = 1:numOfSelectedFeaturesReduced
        selectedFeatureDataReduced{i} = featureArray(:, selectedFeatureArrayReduced(i), selectedSignal);
    end
    
    if verbose == true 
        disp(selectedFeatureArray);
        disp(selectedFeatureArrayReduced);
    end
end