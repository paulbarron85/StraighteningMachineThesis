function [] = fnPlotSignals(rawDataArray, fileNum, signalIndex1, signalIndex2, sensorNames)
    figure();    
    numpoints = size(cell2mat(rawDataArray{fileNum}(1, 2)), 1);
    pointidx = 1 : numpoints; 
    sig1 = cell2mat(rawDataArray{fileNum}(signalIndex1, 2));
    sig2 = cell2mat(rawDataArray{fileNum}(signalIndex2, 2));
    scatter(sig1, sig2, 3, pointidx, 'filled');
    colormap jet
    colorbar
    xlabel(char(sensorNames(signalIndex1)));
    ylabel(char(sensorNames(signalIndex2)));
    filename = "..\Latex Document\figures\File" + fileNum ...
        + "_Signal" + signalIndex1 ...
        + "vSignal" + signalIndex2;
    print(filename,'-depsc','-tiff');
end