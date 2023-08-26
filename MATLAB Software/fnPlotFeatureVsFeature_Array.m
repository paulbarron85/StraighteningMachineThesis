function [R2] = fnPlotFeatureVsFeature_Array(featureArray, lowerBound, upperBound, signalIndex, featureNames, sensorNames)
    figure();
    numpoints = size(featureArray, 1); 
    numOfFeatures = size(featureArray, 2);
    tiledlayout(numOfFeatures, numOfFeatures, 'TileSpacing','None', 'Padding','tight');
    fprintf("Signal %i: %s", signalIndex, sensorNames(signalIndex));
    R2 = zeros(numOfFeatures, numOfFeatures);
    pointidx = 1 : numpoints;
    % Loop through features #1
    for featureIndex1 = 1:numOfFeatures
        % Loop through features #2
        for featureIndex2 = featureIndex1+1:numOfFeatures
            sig1 = featureArray(:, featureIndex1, signalIndex);
            sig2 = featureArray(:, featureIndex2, signalIndex);

            mdl = fitlm(sig1, sig2);
            R2(featureIndex1, featureIndex2) = mdl.Rsquared.Ordinary;

            nexttile((featureIndex1-1) * numOfFeatures + featureIndex2);            
            scatter(sig1, sig2, 3, pointidx, 'filled');
            colormap( jet(numpoints) );
            xticklabels({});
            yticklabels({});

            DataX = interp1( [0 1], xlim(), 0.5 );
            DataY = interp1( [0 1], ylim(), 0.5 );

            if R2(featureIndex1, featureIndex2) > lowerBound && R2(featureIndex1, featureIndex2) < upperBound
                text(DataX, DataY, num2str(R2(featureIndex1, featureIndex2), 2), 'HorizontalAlignment','center');
            end
        end
    end
    for featureIndex = 1 : numOfFeatures
        nexttile((featureIndex-1) * numOfFeatures + featureIndex);
        text(0.5, 0.5, int2str(featureIndex), HorizontalAlignment='center',VerticalAlignment='middle');
        xticklabels({});
        yticklabels({});
        R2(featureIndex, featureIndex) = 1;
    end
end
