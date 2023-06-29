function [featureTable,outputTable] = diagnosticFeatures(inputData)
%DIAGNOSTICFEATURES recreates results in Diagnostic Feature Designer.
%
% Input:
%  inputData: A table or a cell array of tables/matrices containing the
%  data as those imported into the app.
%
% Output:
%  featureTable: A table containing all features and condition variables.
%  outputTable: A table containing the computation results.
%
% This function computes features:
%  TimeTable_sigstats/ClearanceFactor
%  TimeTable_sigstats/CrestFactor
%  TimeTable_sigstats/ImpulseFactor
%  TimeTable_sigstats/Kurtosis
%  TimeTable_sigstats/Mean
%  TimeTable_sigstats/PeakValue
%  TimeTable_sigstats/RMS
%  TimeTable_sigstats/SINAD
%  TimeTable_sigstats/SNR
%  TimeTable_sigstats/ShapeFactor
%  TimeTable_sigstats/Skewness
%  TimeTable_sigstats/Std
%  TimeTable_sigstats/THD
%  TimeTable1_sigstats/ClearanceFactor
%  TimeTable1_sigstats/CrestFactor
%  TimeTable1_sigstats/ImpulseFactor
%  TimeTable1_sigstats/Kurtosis
%  TimeTable1_sigstats/Mean
%  TimeTable1_sigstats/PeakValue
%  TimeTable1_sigstats/RMS
%  TimeTable1_sigstats/SINAD
%  TimeTable1_sigstats/SNR
%  TimeTable1_sigstats/ShapeFactor
%  TimeTable1_sigstats/Skewness
%  TimeTable1_sigstats/Std
%  TimeTable1_sigstats/THD
%  TimeTable2_sigstats/ClearanceFactor
%  TimeTable2_sigstats/CrestFactor
%  TimeTable2_sigstats/ImpulseFactor
%  TimeTable2_sigstats/Kurtosis
%  TimeTable2_sigstats/Mean
%  TimeTable2_sigstats/PeakValue
%  TimeTable2_sigstats/RMS
%  TimeTable2_sigstats/SINAD
%  TimeTable2_sigstats/SNR
%  TimeTable2_sigstats/ShapeFactor
%  TimeTable2_sigstats/Skewness
%  TimeTable2_sigstats/Std
%  TimeTable2_sigstats/THD
%  TimeTable3_sigstats/ClearanceFactor
%  TimeTable3_sigstats/CrestFactor
%  TimeTable3_sigstats/ImpulseFactor
%  TimeTable3_sigstats/Kurtosis
%  TimeTable3_sigstats/Mean
%  TimeTable3_sigstats/PeakValue
%  TimeTable3_sigstats/RMS
%  TimeTable3_sigstats/SINAD
%  TimeTable3_sigstats/SNR
%  TimeTable3_sigstats/ShapeFactor
%  TimeTable3_sigstats/Skewness
%  TimeTable3_sigstats/Std
%  TimeTable3_sigstats/THD
%  TimeTable4_sigstats/ClearanceFactor
%  TimeTable4_sigstats/CrestFactor
%  TimeTable4_sigstats/ImpulseFactor
%  TimeTable4_sigstats/Kurtosis
%  TimeTable4_sigstats/Mean
%  TimeTable4_sigstats/PeakValue
%  TimeTable4_sigstats/RMS
%  TimeTable4_sigstats/SINAD
%  TimeTable4_sigstats/SNR
%  TimeTable4_sigstats/ShapeFactor
%  TimeTable4_sigstats/Skewness
%  TimeTable4_sigstats/Std
%  TimeTable4_sigstats/THD
%  TimeTable5_sigstats/ClearanceFactor
%  TimeTable5_sigstats/CrestFactor
%  TimeTable5_sigstats/ImpulseFactor
%  TimeTable5_sigstats/Kurtosis
%  TimeTable5_sigstats/Mean
%  TimeTable5_sigstats/PeakValue
%  TimeTable5_sigstats/RMS
%  TimeTable5_sigstats/SINAD
%  TimeTable5_sigstats/SNR
%  TimeTable5_sigstats/ShapeFactor
%  TimeTable5_sigstats/Skewness
%  TimeTable5_sigstats/Std
%  TimeTable5_sigstats/THD
%  TimeTable6_sigstats/ClearanceFactor
%  TimeTable6_sigstats/CrestFactor
%  TimeTable6_sigstats/ImpulseFactor
%  TimeTable6_sigstats/Kurtosis
%  TimeTable6_sigstats/Mean
%  TimeTable6_sigstats/PeakValue
%  TimeTable6_sigstats/RMS
%  TimeTable6_sigstats/SINAD
%  TimeTable6_sigstats/SNR
%  TimeTable6_sigstats/ShapeFactor
%  TimeTable6_sigstats/Skewness
%  TimeTable6_sigstats/Std
%  TimeTable6_sigstats/THD
%  TimeTable8_sigstats/ClearanceFactor
%  TimeTable8_sigstats/CrestFactor
%  TimeTable8_sigstats/ImpulseFactor
%  TimeTable8_sigstats/Kurtosis
%  TimeTable8_sigstats/Mean
%  TimeTable8_sigstats/PeakValue
%  TimeTable8_sigstats/RMS
%  TimeTable8_sigstats/SINAD
%  TimeTable8_sigstats/SNR
%  TimeTable8_sigstats/ShapeFactor
%  TimeTable8_sigstats/Skewness
%  TimeTable8_sigstats/Std
%  TimeTable8_sigstats/THD
%  TimeTable7_sigstats/ClearanceFactor
%  TimeTable7_sigstats/CrestFactor
%  TimeTable7_sigstats/ImpulseFactor
%  TimeTable7_sigstats/Kurtosis
%  TimeTable7_sigstats/Mean
%  TimeTable7_sigstats/PeakValue
%  TimeTable7_sigstats/RMS
%  TimeTable7_sigstats/SINAD
%  TimeTable7_sigstats/SNR
%  TimeTable7_sigstats/ShapeFactor
%  TimeTable7_sigstats/Skewness
%  TimeTable7_sigstats/Std
%  TimeTable7_sigstats/THD
%  TimeTable9_sigstats/ClearanceFactor
%  TimeTable9_sigstats/CrestFactor
%  TimeTable9_sigstats/ImpulseFactor
%  TimeTable9_sigstats/Kurtosis
%  TimeTable9_sigstats/Mean
%  TimeTable9_sigstats/PeakValue
%  TimeTable9_sigstats/RMS
%  TimeTable9_sigstats/SINAD
%  TimeTable9_sigstats/SNR
%  TimeTable9_sigstats/ShapeFactor
%  TimeTable9_sigstats/Skewness
%  TimeTable9_sigstats/Std
%  TimeTable9_sigstats/THD
%  TimeTable11_sigstats/ClearanceFactor
%  TimeTable11_sigstats/CrestFactor
%  TimeTable11_sigstats/ImpulseFactor
%  TimeTable11_sigstats/Kurtosis
%  TimeTable11_sigstats/Mean
%  TimeTable11_sigstats/PeakValue
%  TimeTable11_sigstats/RMS
%  TimeTable11_sigstats/SINAD
%  TimeTable11_sigstats/SNR
%  TimeTable11_sigstats/ShapeFactor
%  TimeTable11_sigstats/Skewness
%  TimeTable11_sigstats/Std
%  TimeTable11_sigstats/THD
%  TimeTable10_sigstats/ClearanceFactor
%  TimeTable10_sigstats/CrestFactor
%  TimeTable10_sigstats/ImpulseFactor
%  TimeTable10_sigstats/Kurtosis
%  TimeTable10_sigstats/Mean
%  TimeTable10_sigstats/PeakValue
%  TimeTable10_sigstats/RMS
%  TimeTable10_sigstats/SINAD
%  TimeTable10_sigstats/SNR
%  TimeTable10_sigstats/ShapeFactor
%  TimeTable10_sigstats/Skewness
%  TimeTable10_sigstats/Std
%  TimeTable10_sigstats/THD
%
% Organization of the function:
% 1. Compute signals/spectra/features
% 2. Extract computed features into a table
%
% Modify the function to add or remove data processing, feature generation
% or ranking operations.

% Auto-generated by MATLAB on 16-Mar-2023 07:34:41

% Create output ensemble.
outputEnsemble = workspaceEnsemble(inputData,'DataVariables',["TimeTable";"TimeTable1";"TimeTable2";"TimeTable3";"TimeTable4";"TimeTable5";"TimeTable6";"TimeTable7";"TimeTable8";"TimeTable9";"TimeTable10";"TimeTable11"]);

% Reset the ensemble to read from the beginning of the ensemble.
reset(outputEnsemble);

% Append new signal or feature names to DataVariables.
outputEnsemble.DataVariables = unique([outputEnsemble.DataVariables;"TimeTable_sigstats";"TimeTable1_sigstats";"TimeTable2_sigstats";"TimeTable3_sigstats";"TimeTable4_sigstats";"TimeTable5_sigstats";"TimeTable6_sigstats";"TimeTable8_sigstats";"TimeTable7_sigstats";"TimeTable9_sigstats";"TimeTable11_sigstats";"TimeTable10_sigstats"],'stable');

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = ["TimeTable","TimeTable1","TimeTable2","TimeTable3","TimeTable4","TimeTable5","TimeTable6","TimeTable8","TimeTable7","TimeTable9","TimeTable11","TimeTable10"];

% Loop through all ensemble members to read and write data.
while hasdata(outputEnsemble)
    % Read one member.
    member = read(outputEnsemble);

    % Get all input variables.
    TimeTable = readMemberData(member,"TimeTable",["Time","21:07 Angle over Rolls (degrees)"]);
    TimeTable1 = readMemberData(member,"TimeTable1",["Time","21:10 Position over Rolls (mm)"]);
    TimeTable2 = readMemberData(member,"TimeTable2",["Time","21:12 Actual moment over Rolls (Nm)"]);
    TimeTable3 = readMemberData(member,"TimeTable3",["Time","21:17 Angle under roll (degrees)"]);
    TimeTable4 = readMemberData(member,"TimeTable4",["Time","21:20 Actual moment under Rolls (Nm)"]);
    TimeTable5 = readMemberData(member,"TimeTable5",["Time","21:28 Vibration measurements (mm per s)"]);
    TimeTable6 = readMemberData(member,"TimeTable6",["Time","21:31 Width position (mm)"]);
    TimeTable8 = readMemberData(member,"TimeTable8",["Time","21:33 Error position for height (mm)"]);
    TimeTable7 = readMemberData(member,"TimeTable7",["Time","21:32 Height position (mm)"]);
    TimeTable9 = readMemberData(member,"TimeTable9",["Time","21:34 Error position for the width (mm)"]);
    TimeTable11 = readMemberData(member,"TimeTable11",["Time","21:36 Actual force (KN)"]);
    TimeTable10 = readMemberData(member,"TimeTable10",["Time","21:35 Set point force (KN)"]);

    % Initialize a table to store results.
    memberResult = table;

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable.("21:07 Angle over Rolls (degrees)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable_sigstats},'VariableNames',"TimeTable_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable1.("21:10 Position over Rolls (mm)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable1_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable1_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable1_sigstats},'VariableNames',"TimeTable1_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable2.("21:12 Actual moment over Rolls (Nm)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable2_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable2_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable2_sigstats},'VariableNames',"TimeTable2_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable3.("21:17 Angle under roll (degrees)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable3_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable3_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable3_sigstats},'VariableNames',"TimeTable3_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable4.("21:20 Actual moment under Rolls (Nm)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable4_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable4_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable4_sigstats},'VariableNames',"TimeTable4_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable5.("21:28 Vibration measurements (mm per s)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable5_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable5_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable5_sigstats},'VariableNames',"TimeTable5_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable6.("21:31 Width position (mm)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable6_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable6_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable6_sigstats},'VariableNames',"TimeTable6_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable8.("21:33 Error position for height (?)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable8_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable8_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable8_sigstats},'VariableNames',"TimeTable8_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable7.("31:32 Height position (?)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable7_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable7_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable7_sigstats},'VariableNames',"TimeTable7_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable9.("21:34 Error position for the width (?)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable9_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable9_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable9_sigstats},'VariableNames',"TimeTable9_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable11.("21:36 Actual force (KN)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable11_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable11_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable11_sigstats},'VariableNames',"TimeTable11_sigstats")]; %#ok<AGROW>

    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = TimeTable10.("21:35 Set point force (KN)");
        ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
        CrestFactor = peak2rms(inputSignal);
        ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
        Kurtosis = kurtosis(inputSignal);
        Mean = mean(inputSignal,'omitnan');
        PeakValue = max(abs(inputSignal));
        RMS = rms(inputSignal,'omitnan');
        SINAD = sinad(inputSignal);
        SNR = snr(inputSignal);
        ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
        Skewness = skewness(inputSignal);
        Std = std(inputSignal,'omitnan');
        THD = thd(inputSignal);

        % Concatenate signal features.
        featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

        % Package computed features into a table.
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable10_sigstats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,13);
        featureNames = ["ClearanceFactor","CrestFactor","ImpulseFactor","Kurtosis","Mean","PeakValue","RMS","SINAD","SNR","ShapeFactor","Skewness","Std","THD"];
        TimeTable10_sigstats = array2table(featureValues,'VariableNames',featureNames);
    end

    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({TimeTable10_sigstats},'VariableNames',"TimeTable10_sigstats")]; %#ok<AGROW>

    %% Write all the results for the current member to the ensemble.
    writeToLastMemberRead(outputEnsemble,memberResult)
end

% Gather all features into a table.
selectedFeatureNames = ["TimeTable_sigstats/ClearanceFactor","TimeTable_sigstats/CrestFactor","TimeTable_sigstats/ImpulseFactor","TimeTable_sigstats/Kurtosis","TimeTable_sigstats/Mean","TimeTable_sigstats/PeakValue","TimeTable_sigstats/RMS","TimeTable_sigstats/SINAD","TimeTable_sigstats/SNR","TimeTable_sigstats/ShapeFactor","TimeTable_sigstats/Skewness","TimeTable_sigstats/Std","TimeTable_sigstats/THD","TimeTable1_sigstats/ClearanceFactor","TimeTable1_sigstats/CrestFactor","TimeTable1_sigstats/ImpulseFactor","TimeTable1_sigstats/Kurtosis","TimeTable1_sigstats/Mean","TimeTable1_sigstats/PeakValue","TimeTable1_sigstats/RMS","TimeTable1_sigstats/SINAD","TimeTable1_sigstats/SNR","TimeTable1_sigstats/ShapeFactor","TimeTable1_sigstats/Skewness","TimeTable1_sigstats/Std","TimeTable1_sigstats/THD","TimeTable2_sigstats/ClearanceFactor","TimeTable2_sigstats/CrestFactor","TimeTable2_sigstats/ImpulseFactor","TimeTable2_sigstats/Kurtosis","TimeTable2_sigstats/Mean","TimeTable2_sigstats/PeakValue","TimeTable2_sigstats/RMS","TimeTable2_sigstats/SINAD","TimeTable2_sigstats/SNR","TimeTable2_sigstats/ShapeFactor","TimeTable2_sigstats/Skewness","TimeTable2_sigstats/Std","TimeTable2_sigstats/THD","TimeTable3_sigstats/ClearanceFactor","TimeTable3_sigstats/CrestFactor","TimeTable3_sigstats/ImpulseFactor","TimeTable3_sigstats/Kurtosis","TimeTable3_sigstats/Mean","TimeTable3_sigstats/PeakValue","TimeTable3_sigstats/RMS","TimeTable3_sigstats/SINAD","TimeTable3_sigstats/SNR","TimeTable3_sigstats/ShapeFactor","TimeTable3_sigstats/Skewness","TimeTable3_sigstats/Std","TimeTable3_sigstats/THD","TimeTable4_sigstats/ClearanceFactor","TimeTable4_sigstats/CrestFactor","TimeTable4_sigstats/ImpulseFactor","TimeTable4_sigstats/Kurtosis","TimeTable4_sigstats/Mean","TimeTable4_sigstats/PeakValue","TimeTable4_sigstats/RMS","TimeTable4_sigstats/SINAD","TimeTable4_sigstats/SNR","TimeTable4_sigstats/ShapeFactor","TimeTable4_sigstats/Skewness","TimeTable4_sigstats/Std","TimeTable4_sigstats/THD","TimeTable5_sigstats/ClearanceFactor","TimeTable5_sigstats/CrestFactor","TimeTable5_sigstats/ImpulseFactor","TimeTable5_sigstats/Kurtosis","TimeTable5_sigstats/Mean","TimeTable5_sigstats/PeakValue","TimeTable5_sigstats/RMS","TimeTable5_sigstats/SINAD","TimeTable5_sigstats/SNR","TimeTable5_sigstats/ShapeFactor","TimeTable5_sigstats/Skewness","TimeTable5_sigstats/Std","TimeTable5_sigstats/THD","TimeTable6_sigstats/ClearanceFactor","TimeTable6_sigstats/CrestFactor","TimeTable6_sigstats/ImpulseFactor","TimeTable6_sigstats/Kurtosis","TimeTable6_sigstats/Mean","TimeTable6_sigstats/PeakValue","TimeTable6_sigstats/RMS","TimeTable6_sigstats/SINAD","TimeTable6_sigstats/SNR","TimeTable6_sigstats/ShapeFactor","TimeTable6_sigstats/Skewness","TimeTable6_sigstats/Std","TimeTable6_sigstats/THD","TimeTable8_sigstats/ClearanceFactor","TimeTable8_sigstats/CrestFactor","TimeTable8_sigstats/ImpulseFactor","TimeTable8_sigstats/Kurtosis","TimeTable8_sigstats/Mean","TimeTable8_sigstats/PeakValue","TimeTable8_sigstats/RMS","TimeTable8_sigstats/SINAD","TimeTable8_sigstats/SNR","TimeTable8_sigstats/ShapeFactor","TimeTable8_sigstats/Skewness","TimeTable8_sigstats/Std","TimeTable8_sigstats/THD","TimeTable7_sigstats/ClearanceFactor","TimeTable7_sigstats/CrestFactor","TimeTable7_sigstats/ImpulseFactor","TimeTable7_sigstats/Kurtosis","TimeTable7_sigstats/Mean","TimeTable7_sigstats/PeakValue","TimeTable7_sigstats/RMS","TimeTable7_sigstats/SINAD","TimeTable7_sigstats/SNR","TimeTable7_sigstats/ShapeFactor","TimeTable7_sigstats/Skewness","TimeTable7_sigstats/Std","TimeTable7_sigstats/THD","TimeTable9_sigstats/ClearanceFactor","TimeTable9_sigstats/CrestFactor","TimeTable9_sigstats/ImpulseFactor","TimeTable9_sigstats/Kurtosis","TimeTable9_sigstats/Mean","TimeTable9_sigstats/PeakValue","TimeTable9_sigstats/RMS","TimeTable9_sigstats/SINAD","TimeTable9_sigstats/SNR","TimeTable9_sigstats/ShapeFactor","TimeTable9_sigstats/Skewness","TimeTable9_sigstats/Std","TimeTable9_sigstats/THD","TimeTable11_sigstats/ClearanceFactor","TimeTable11_sigstats/CrestFactor","TimeTable11_sigstats/ImpulseFactor","TimeTable11_sigstats/Kurtosis","TimeTable11_sigstats/Mean","TimeTable11_sigstats/PeakValue","TimeTable11_sigstats/RMS","TimeTable11_sigstats/SINAD","TimeTable11_sigstats/SNR","TimeTable11_sigstats/ShapeFactor","TimeTable11_sigstats/Skewness","TimeTable11_sigstats/Std","TimeTable11_sigstats/THD","TimeTable10_sigstats/ClearanceFactor","TimeTable10_sigstats/CrestFactor","TimeTable10_sigstats/ImpulseFactor","TimeTable10_sigstats/Kurtosis","TimeTable10_sigstats/Mean","TimeTable10_sigstats/PeakValue","TimeTable10_sigstats/RMS","TimeTable10_sigstats/SINAD","TimeTable10_sigstats/SNR","TimeTable10_sigstats/ShapeFactor","TimeTable10_sigstats/Skewness","TimeTable10_sigstats/Std","TimeTable10_sigstats/THD"];
featureTable = readFeatureTable(outputEnsemble,'Features',selectedFeatureNames);

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = unique([outputEnsemble.DataVariables;outputEnsemble.ConditionVariables;outputEnsemble.IndependentVariables],'stable');

% Gather results into a table.
outputTable = readall(outputEnsemble);
end
