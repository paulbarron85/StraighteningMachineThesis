%{
    Date: 2023/08/23
    Filename: MultivariateModel_FeatureVsFeatureArray_Signal3.mlx
    Author: Paul Barron
    Description: This script calls the function that plots the signal
    features against each other for every signal
%}
%%
lowerR2 = 0.3;
upperR2 = 0.8;
r2ReducedThreshold = 0.9;
selectedSignal = 3; %21:12 Actual moment over Rolls (Nm)
saveFigures = true;
R2 = fnPlotFeatureVsFeature_Array(featureArray_Standard, lowerR2, upperR2, selectedSignal, FeatureNames_Combined, sensorNames);
%%
disp(num2str(R2, '%.2f  '));
%% Combination 1

selectedFeature = 1;
[selectedFeatureArray, selectedFeatureData, numOfSelectedFeatures] = fnSelectFeatures( ...
    selectedSignal, selectedFeature, featureArray_Standard,R2, upperR2, lowerR2, r2ReducedThreshold, true);
%%
fig = figure(); hold on;
sensorNames(selectedSignal)
xlabel("Pulses");
ylabel("Feature value");
leg = {numOfSelectedFeatures};
secondaryAxisArrayIndex = [2 3];
legendAxis = [];
for i = 1:numOfSelectedFeatures
    if ismember(i, secondaryAxisArrayIndex)
        yyaxis right;
        ha = plot(selectedFeatureData{i});
        legendAxis = [legendAxis ha];
    else
        yyaxis left;
        hb = plot(selectedFeatureData{i});
        legendAxis = [legendAxis hb];
    end
    leg{i} = char(FeatureNames_Combined(selectedFeatureArray(i)));
end
hold off;
lgnd = legend(legendAxis, leg); 
set(lgnd,'color','none');
if (saveFigures == true)
    filename = "..\Latex Document\figures\Models_Signal" + selectedSignal + "Feature" + selectedFeature;
    print(filename,'-depsc','-tiff')    
    %export_fig(filename, '-eps', '-depsc');
end
%%
figure(); hold on;
x1 = selectedFeatureData{1};
x2 = selectedFeatureData{2};
x3 = selectedFeatureData{3};
t = 1:numOfPulses;
hl1 = line(t,x1,'Color','r');
ax1 = gca;
set(ax1,'XColor','r','YColor','r')
ax2 = axes('XAxisLocation','top',...
         'YAxisLocation','right',...
         'Color','none',...
         'XColor','k','YColor','k');
hl2 = line(t,x2,'Parent', ax2, 'Color','k');
hl3 = line(t,x3,'Parent', ax2, 'Color','k');
%%
xx = (1:numOfPulses)';
plotyyy(xx, selectedFeatureData{1}, xx, selectedFeatureData{2}, xx, selectedFeatureData{3}, leg);
sensorNames(selectedSignal)
xlabel("Pulses");
%%
selectedFeatureIdx = find(selectedFeatureArray == selectedFeature);
linearModelNum = 1;
for index = 1 : numOfSelectedFeatures
    if selectedFeatureArray(index) ~= selectedFeature
        fnPlotModel(selectedFeatureData{index}, ...
            selectedFeatureData{selectedFeatureIdx}, ...
            sensorNames(selectedSignal), ...
            FeatureNames_Combined(selectedFeatureArray(index)), ...
            FeatureNames_Combined(selectedFeature));
        if (saveFigures == true)
            filename = "..\Latex Document\figures\Models_Signal" + selectedSignal ...
                + "Feature" + selectedFeature ...
                + "_Linear" + linearModelNum;
            export_fig(filename, '-eps', '-depsc');
            linearModelNum = linearModelNum + 1;
        end
    end
end
%%
multivariateModelNum = 1;
if numOfSelectedFeatures > 2
    for index1 = 1 : numOfSelectedFeatures
        for index2 = index1+1 : numOfSelectedFeatures
            if selectedFeatureArray(index1) ~= selectedFeature && selectedFeatureArray(index2) ~= selectedFeature            
                Y_est = fnPlotModel3D( ...
                    selectedFeatureData{selectedFeatureIdx}, ...
                    selectedFeatureData{index1}, ...
                    selectedFeatureData{index2}, ...
                    sensorNames(selectedSignal), ...
                    FeatureNames_Combined(selectedFeatureArray(selectedFeatureIdx)), ...
                    FeatureNames_Combined(selectedFeatureArray(index1)), ...
                    FeatureNames_Combined(selectedFeatureArray(index2)));
                if (saveFigures == true)
                    filename = "..\Latex Document\figures\Models_Signal" + selectedSignal ...
                        + "Feature" + selectedFeature ...
                        + "_Multivariate" + multivariateModelNum;
                    export_fig(filename, '-eps', '-depsc');
                    multivariateModelNum = multivariateModelNum + 1;
                end
            end
        end
    end
end
%%
[FullPath,Filename,ext]=fileparts(matlab.desktop.editor.getActiveFilename);
currentFile = strcat(Filename, ext);
path = export(currentFile, Format="m", OpenExportedFile=false);