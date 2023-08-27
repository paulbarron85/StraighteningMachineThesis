function [] = fnPlotCorrelations(rawDataArray, r2Values, fileNum, lowerBound, upperBound, signalName, sensorNames)
%{
    Date: 2023/08/23
    Filename: fnPlotCorrelations.m
    Author: Paul Barron
    Description: This function plots the signals against each other as well
    as printing the R2 values on the plots which are within the specified
    range.
%}
figure();
    tiledlayout(12,12,'TileSpacing','None', 'Padding','tight');
    numOfSignals = size(signalName, 2);
    numpoints = size(cell2mat(rawDataArray{fileNum}(1, 2)), 1);
    pointidx = 1 : numpoints; 
    for signalIndex1 = 1:numOfSignals
        for signalIndex2 = signalIndex1:numOfSignals
            if signalIndex1 ~= signalIndex2
                sig1 = cell2mat(rawDataArray{fileNum}(signalIndex1, 2));
                sig2 = cell2mat(rawDataArray{fileNum}(signalIndex2, 2));
                nexttile((signalIndex1-1) * numOfSignals + signalIndex2);
                scatter(sig1, sig2, 2, pointidx, 'filled');
                colormap jet;
                xticklabels({});
                yticklabels({});
                DataX = interp1( [0 1], xlim(), 0.5 );
                DataY = interp1( [0 1], ylim(), 0.5 );
                r2Val = r2Values(fileNum, signalIndex1, signalIndex2);
                if r2Val > lowerBound && r2Val < upperBound
                    text(DataX, DataY, num2str(r2Val, 2), 'HorizontalAlignment','center');
                end
            end
        end
    end
    % Add labels for signal names on the diagonals
    for i = 1:size(sensorNames, 2)
        nexttile((i-1) * numOfSignals + i);
        str = char(sensorNames(i));
        text(0.5, 0.5, str(1:5), HorizontalAlignment='center', VerticalAlignment='middle');
        xticklabels({});
        yticklabels({});
    end
end