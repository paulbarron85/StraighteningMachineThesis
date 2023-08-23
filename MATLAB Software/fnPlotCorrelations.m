function [] = fnPlotCorrelations(rawDataArray, r2Values, fileNum, lowerBound, upperBound, signalName, sensorNames)
    figure();
    t = tiledlayout(12,12,'TileSpacing','None', 'Padding','tight');
    %title(t, "Raw signals vs each other: File number " + fileNum);
    numOfSignals = size(signalName, 2);
    numpoints = size(cell2mat(rawDataArray{fileNum}(1, 2)), 1);
    pointidx = 1 : numpoints; 
    for signalIndex1 = 1:numOfSignals
        for signalIndex2 = signalIndex1:numOfSignals
            if signalIndex1 ~= signalIndex2
                sig1 = cell2mat(rawDataArray{fileNum}(signalIndex1, 2));
                sig2 = cell2mat(rawDataArray{fileNum}(signalIndex2, 2));
                nexttile((signalIndex1-1) * numOfSignals + signalIndex2);
                scatter(sig1, sig2, 3, pointidx, 'filled');
                colormap( jet(numpoints) );
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