function [kurt] = fnKurtosis(inputArray)
%KERTOSIS Summary of this function goes here
%Kurtosis quantifies the peak value of the PDF.
%   Detailed explanation goes here
m = mean(inputArray);
N = size(inputArray, 1);
numerator = sum( ( inputArray - m ) .^4 );
denominator = sum( ( inputArray - m ) .^2) ;
kurt = N * numerator / (denominator^2);