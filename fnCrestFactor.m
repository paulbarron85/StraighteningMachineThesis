function [crestFactor] = fnClearanceFactor(inputArray)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
crestFactor = max(inputArray) / fnRMS(inputArray);
end

