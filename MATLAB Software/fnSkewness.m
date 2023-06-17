function [skew] = fnSkewness(inputArray)
%SKEWNESS Summary of this function goes here
%   Detailed explanation goes here
m = mean(inputArray);
N = size(inputArray, 2);
numerator = sum(( inputArray - m ) .^ 3);
denominator = sum(( inputArray - m ) .^ 2);
numerator = numerator / N;
denominator = ( sqrt( denominator / N )) ^3;
skew = numerator / denominator;