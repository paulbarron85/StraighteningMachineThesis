function [selectedFeatureArray, selectedFeatureData, numOfSelectedFeatures] = fnSelectFeatures(selectedSignal, selectedFeature, featureArray, R2, upperR2, lowerR2)
    numOfCombinedFeatures = size(R2, 1);
    selectedFeatureArray = [selectedFeature]; % Array of correlated features
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
    selectedFeatureArray = sort(selectedFeatureArray);
    numOfSelectedFeatures = size(selectedFeatureArray, 2);
    selectedFeatureData = {numOfSelectedFeatures};
    
    for i = 1:numOfSelectedFeatures
        selectedFeatureData{i} = featureArray(:, selectedFeatureArray(i), selectedSignal);
    end
    
    numOfSelectedFeatures = size(selectedFeatureArray, 2);
end