%{
    This script loads the features calculated by Matlab's Diagnostic
    Feature Designer
%}

load("DFD_FeatureTable_TimeDomain.mat");
load("DFD_FeatureTable_FreqDomain.mat");

load("DFD_FeatureTable_TimeDomain_DcRemoved.mat");
% load("DFD_FeatureTable_FreqDomain_DcRemoved.mat");

load("DFD_FeatureTable_TimeDomain_Padded.mat");
% load("DFD_FeatureTable_FreqDomain_Padded.mat");

load("DFD_FeatureTable_TimeDomain_DcRemovedPadded.mat");
% load("DFD_FeatureTable_FreqDomain_DcRemovedAndPadded.mat");

% Time Tables are equivelant to the Signal Numbers i.e. TimeTable = 21.07
signalNames_Time = [  
                "TimeTable_sigstats/"...
                "TimeTable1_sigstats/"...
                "TimeTable2_sigstats/"...
                "TimeTable3_sigstats/"...
                "TimeTable4_sigstats/"...
                "TimeTable5_sigstats/"...
                "TimeTable6_sigstats/"...
                "TimeTable7_sigstats/"...
                "TimeTable8_sigstats/"...
                "TimeTable9_sigstats/"...
                "TimeTable10_sigstats/"...
                "TimeTable11_sigstats/"
              ];
numOfSignals = size(signalNames_Time, 2);

% Time domain features produced by Matlab DFD
featureNames_Time = [
                "ClearanceFactor"... %1
                "CrestFactor"... %2
                "ImpulseFactor"... %3
                "Kurtosis"... %4
                "Mean"... %5
                "PeakValue"... %6
                "RMS"... %7
                "SNR"... %8
                "SINAD"... %9
                "ShapeFactor"... %10
                "Skewness"... %11
                "Std"... %12
                "THD" %13
               ];
numOfFeatures_Time = size(featureNames_Time, 2);

% Time Tables are equivelant to the Signal Numbers i.e. TimeTable = 21.07
signalNames_Freq = [  
                "TimeTable_ps_spec/"...
                "TimeTable1_ps_spec/"...
                "TimeTable2_ps_spec/"...
                "TimeTable3_ps_spec/"...
                "TimeTable4_ps_spec/"...
                "TimeTable5_ps_spec/"...
                "TimeTable6_ps_spec/"...
                "TimeTable7_ps_spec/"...
                "TimeTable8_ps_spec/"...
                "TimeTable9_ps_spec/"...
                "TimeTable10_ps_spec/"...
                "TimeTable11_ps_spec/"
              ];

% Time domain features produced by Matlab DFD
featureNames_Freq = [
                "BandPower"... %1
                "PeakAmp1"... %2
                "PeakFreq1"... %3
               ];
numOfFeatures_Freq = size(featureNames_Freq, 2);

%% 
% Convert timetables output from DFD to array
% Combine time domain features with frequency domain features
% Output is an array numOfPulses x numOfSignals x numOfFeatures
numOfTimeFeatures = size(featureNames_Time, 2);
numOfFreqFeatures = size(featureNames_Freq, 2);
numOfPulses = size(pulseData_Timetable, 1);
totalFeatures = numOfTimeFeatures + numOfFreqFeatures;
featureArray = zeros(numOfPulses, totalFeatures, numOfSignals);

% Take data from the time and freq domain features and combine them into an
% array
for signalIndex = 1 : numOfSignals
    for featureIndex = 1 : numOfTimeFeatures
        featureArray(:, featureIndex, signalIndex) = DFD_FeatureTable_TimeDomain.(signalNames_Time(signalIndex) + featureNames_Time(featureIndex));
    end
    for featureIndex = 1 : numOfFreqFeatures
        featureArray(:, featureIndex + numOfTimeFeatures, signalIndex) = DFD_FeatureTable_FreqDomain.(signalNames_Freq(signalIndex) + featureNames_Freq(featureIndex));
    end   
end
combinedFeatureNames = [featureNames_Time featureNames_Freq];
numOfCombinedFeatures = size(combinedFeatureNames,2);