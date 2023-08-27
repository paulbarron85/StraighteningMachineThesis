function [beta] = fnPlotModel(Y, X1, txtTitle, labelY, labelX1)
%{
    Date: 2023/08/23
    Filename: SignalVsSignal.mlx
    Author: Paul Barron
    Description: This function calculates a linear model using least
    squares and calculates the normalized FIT value. It plot the data using
    a scatter plot and then plots the linear model over the top of the
    data.
%}
    n = size(Y, 1);
    X = [ones(n,1) X1];
    k = size(X, 2) - 1; % Number of parameters for model
    beta = inv(X' * X) * (X' * Y);
    
    Y_est = X * beta;
    RSS = sum((Y_est - Y).^2);
    RSS = var(Y_est - Y) / var(Y);
    
    figure(); hold on;
    pointidx = 1 : n;
    scatter(X1, Y, 10, pointidx, 'o', 'filled');
    colormap( jet(n) );
    interval = max(X1) - min(X1);
    x1fit = min(X1):interval:max(X1);
    yfit = beta(1) + beta(2).*x1fit;
    plot(x1fit, yfit);
    xlabel(labelX1, 'Interpreter', 'none');
    ylabel(labelY, 'Interpreter', 'none');

    % Fit equation from compare function
    FitValue = 100 * (1-norm(Y-Y_est)/norm(Y-mean(Y)));

    annotation('textbox', [0.2 0.8, 0.1, 0.1], 'String', FitValue);
end