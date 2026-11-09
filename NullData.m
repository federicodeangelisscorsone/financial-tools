function [NaN_Inf_values,zero_values] = NullData(timetable1)
% "NullData" is a function that checks for the number of NaN, Inf and
% zero values in a timetable with a structure as the output of the
% function "FittingData" (see also the built-in function "unstack").
% It stops in the case there are NaN or Inf values

arguments (Input)
    timetable1 timetable
end

arguments (Output)
    NaN_Inf_values logical
    zero_values logical
end

% Extracting variables from the timetable 
input = timetable1.Variables;

% Check whether there are Inf or NaN values in the timetable
NaN_Inf_values = ~isfinite(input); % it gives 0 if the value is finite and 1 if is NaN or Inf
% if there is at least one value equal to 1 i.e. a NaN or a Inf, it stops
% the code
assert(~any(NaN_Inf_values,"all"),"There are NaN of Inf value in the timetable"); 

% check whether there are zero values in the timetable
zero_values = ~(input);
