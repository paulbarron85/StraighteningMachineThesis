function [R2] = fnPlotFeatureVsFeature(signalNum, sensorNames, featureNames, signalName, FeaturesAll)
    figure();
    t = tiledlayout(13,13,'TileSpacing','None', 'Padding','tight');
    title(t, "Signal " + signalNum + ": " + sensorNames(signalNum));
    numpoints = size(FeaturesAll.(signalName(signalNum) + featureNames(1)), 1);
    numFeatures = size(featureNames, 2);
    R2 = zeros(numFeatures, numFeatures);
    pointidx = 1 : numpoints;
    % Loop through features
    for featureIndex1 = 1:numFeatures
        feature1 = featureNames(featureIndex1);
        % Loop through features
        for featureIndex2 = featureIndex1+1 : numFeatures
            feature2 = featureNames(featureIndex2);
            sig1 = FeaturesAll.(signalName(signalNum) + feature1);
            sig2 = FeaturesAll.(signalName(signalNum) + feature2);

            mdl = fitlm(sig1, sig2);
            R2(featureIndex1, featureIndex2) = mdl.Rsquared.Ordinary;

            nexttile((featureIndex1-1) * 13 + featureIndex2);            
            scatter(sig1, sig2, 3, pointidx, 'filled');
            colormap( jet(numpoints) );
            xticklabels({});
            yticklabels({});

            DataX = interp1( [0 1], xlim(), 0.5 );
            DataY = interp1( [0 1], ylim(), 0.5 );
            %th = text(DataX, DataY, num2str(R2(i, j), 2), 'HorizontalAlignment','center');
            if R2(featureIndex1, featureIndex2) > 0.3
                text(DataX, DataY, num2str(R2(featureIndex1, featureIndex2), 2), 'HorizontalAlignment','center');
            end
        end
    end
    for featureIndex1 = 1:size(featureNames, 2)
        nexttile((featureIndex1-1) * 13 + featureIndex1);
        text(0, 0.5, featureNames(featureIndex1));
        xticklabels({});
        yticklabels({});
    end
end