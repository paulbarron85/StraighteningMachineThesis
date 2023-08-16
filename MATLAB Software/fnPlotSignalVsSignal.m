function [R2] = fnPlotSignalVsSignal(FeatureTable, lowerBound, upperBound, featureIndex, featureNames, signalName, sensorNames)
    figure();
    t = tiledlayout(12,12,'TileSpacing','None', 'Padding','tight');
    %title(t, "Feature " + featureIndex + ": " + featureNames(featureIndex) );
    "Feature " + featureIndex + ": " + featureNames(featureIndex);
    numpoints = size(FeatureTable.(signalName(1) + featureNames(1)), 1);
    pointidx = 1 : numpoints; 
    numOfSignals = size(signalName, 2);
    R2 = zeros(numOfSignals, numOfSignals);
    for signalIndex1 = 1:numOfSignals
        for signalIndex2 = signalIndex1:numOfSignals
            if signalIndex1 ~= signalIndex2
                sig1 = FeatureTable.(signalName(signalIndex1) + featureNames(featureIndex));
                sig2 = FeatureTable.(signalName(signalIndex2) + featureNames(featureIndex));
                nexttile((signalIndex1-1) * numOfSignals + signalIndex2);
                scatter(sig1, sig2, 3, pointidx, 'filled');
                colormap( jet(numpoints) );
                xticklabels({});
                yticklabels({});

                mdl = fitlm(sig1, sig2);
                R2(signalIndex1, signalIndex2) = mdl.Rsquared.Ordinary;

                DataX = interp1( [0 1], xlim(), 0.5 );
                DataY = interp1( [0 1], ylim(), 0.5 );
                if R2(signalIndex1, signalIndex2) > lowerBound && R2(signalIndex1, signalIndex2) < upperBound
                    text(DataX, DataY, num2str(R2(signalIndex1, signalIndex2), 2), 'HorizontalAlignment','center');
                end
            end
        end
    end
    % Add labels for signal names on the diagonals
    for i = 1:size(sensorNames, 2)
        nexttile((i-1) * numOfSignals + i);
        str = char(sensorNames(i));
        text(0, 0.5, str(1:5));
        xticklabels({});
        yticklabels({});
        R2(signalIndex1, signalIndex1) = 1;
    end
end