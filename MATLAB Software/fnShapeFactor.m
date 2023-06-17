function [shapeFactor] = fnShapeFactor(inputArray)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
numerator = fnRMS(inputArray);
absArray = abs(inputArray);
denominator = mean(absArray);
shapeFactor = numerator/denominator;
end