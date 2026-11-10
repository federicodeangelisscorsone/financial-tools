function [NaN_values,Inf_values,Zero_values] = BadData(timetable1)
% "BadData" is a function that checks for NaN, Inf and zero values in a
% timetable with a structure as the output of the function "FittingData"
% (see also the built-in function "unstack"). It returns logical arrays
% marking where these values are and issues a warning for each type found.

arguments (Input)
    timetable1 timetable
end

arguments (Output)
    NaN_values logical
    Inf_values logical
    Zero_values logical
end

% Extracting variables from the timetable 
data = timetable1.Variables;

% Check whether there are NaN values in the timetable
NaN_values = isnan(data); % it gives 1 if the value is NaN

% Check whether there are Inf values in the timetable
Inf_values = isinf(data); % it gives 1 if the value is Inf

% check whether there are NaN
if any(NaN_values,"all")
    warning("BadData:NaNValues","There are NaN values")
end

% check whether there are Inf
if any(Inf_values,"all")
    warning("BadData:InfValues","There are Inf values")
end

% check whether there are zeros values in the timetable
Zero_values = (data==0);
if any(Zero_values,"all")
    warning("BadData:ZeroValues","There are zero values")
end