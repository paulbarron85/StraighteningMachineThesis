function [clearanceFactor] = fnClearanceFactor(inputArray)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N = size(inputArray, 2);
numerator = max(inputArray);
denominator = ( sum( sqrt(abs(inputArray)) ) / N ) ^ 2;
clearanceFactor = numerator / denominator;
end