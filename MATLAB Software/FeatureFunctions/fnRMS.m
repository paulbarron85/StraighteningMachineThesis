function [RMS] = fnRMS(inputArray)
%rootMS Summary of this function goes here
%   Detailed explanation goes here
N = size(inputArray, 2);
summation = sum( inputArray.^2 );
RMS = sqrt ( summation / N);