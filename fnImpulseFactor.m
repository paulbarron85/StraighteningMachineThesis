function [impulseFactor] = fnImpulseFactor(inputArray)
%FNIMPULSEFACTOR Summary of this function goes here
%   Detailed explanation goes here
impulseFactor = max(inputArray) / mean(inputArray);
end

