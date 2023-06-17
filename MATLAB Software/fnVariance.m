function [variance] = fnVariance(inputArray)
% VARIANCE Summary of this function goes here
% Calculate the variance of a 1D array
m = mean(inputArray);
N = size(inputArray, 2);
summation = sum(( inputArray - m ) .^2);
variance = summation / (N-1);