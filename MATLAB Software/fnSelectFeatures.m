function [selectedFeatureArrayReduced, selectedFeatureDataReduced, numOfSelectedFeaturesReduced] = fnSelectFeatures( ...
selectedSignal, selectedFeature, featureArray, R2, upperR2, lowerR2, r2ReducedThreshold, verbose)
%{
    Date: 2023/08/23
    Filename: fnSelectFeatures.m
    Author: Paul Barron
    Description: This function removes features that are highly correlated
    from a set of original features.
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