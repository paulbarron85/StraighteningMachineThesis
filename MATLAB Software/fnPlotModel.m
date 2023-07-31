function [beta] = fnPlotModel(Y, X1, txtTitle, labelY, labelX1)
    n = size(Y, 1);
    X = [ones(n,1) X1];
    k = size(X, 2) - 1; % Number of parameters for model
    beta = inv(X' * X) * (X' * Y);
    
    Y_est = X * beta;
    RSS = sum((Y_est - Y).^2);
    RSS = var(Y_est - Y) / var(Y);
    
    figure(); hold on;
    scatter(X1, Y);
    interval = max(X1) - min(X1);
    x1fit = min(X1):interval:max(X1);
    yfit = beta(1) + beta(2).*x1fit;
    plot(x1fit, yfit);
    xlabel(labelX1, 'Interpreter', 'none');
    ylabel(labelY, 'Interpreter', 'none');
    title(txtTitle, 'Interpreter', 'none');

    % Fit equation from compare function
    FIT = 100 * (1-norm(Y-Y_est)/norm(Y-mean(Y)));
    fprintf("FIT = %2.2f", FIT);
end