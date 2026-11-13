function [timetable1_output,timetable2_output] = CheckColumns(timetable1,timetable2)
% "CheckColumns.m" checks that two timetables have the same variables (case-insensitive).
% Output: both timetables with UPPERCASE variable names and the columns of
% both sorted in alphabetical order, so that they match. Errors if the
% variable sets differ.

arguments (Input)
    timetable1 timetable
    timetable2 timetable
end

arguments (Output)
    timetable1_output timetable
    timetable2_output timetable
end

% Put the industries names in MAIUSC
timetable1.Properties.VariableNames = upper(timetable1.Properties.VariableNames);
timetable2.Properties.VariableNames = upper(timetable2.Properties.VariableNames);
% Are timetable1 variables members of the set of timetable2 variables?
assert(all(ismember(timetable1.Properties.VariableNames,timetable2.Properties.VariableNames)),...
    "timetable1 variables are not in timetable2 variable names set")
% Are timetable2 variables members of the set of timetable1 variables?
assert(all(ismember(timetable2.Properties.VariableNames,timetable1.Properties.VariableNames)),...
    "timetable2 variables are not in timetable1 variable names set")

% Are the tickers in the same order ? 
[~, sortedIdx] = sort(timetable2.Properties.VariableNames); %sorting columns
timetable2 = timetable2(:, sortedIdx); %re-assign with sorted columns
[~, sortedIdx] = sort(timetable1.Properties.VariableNames); %sorting columns
timetable1 = timetable1(:, sortedIdx); %re-assign with sorted columns
assert(all(categorical(timetable1.Properties.VariableNames) == categorical(timetable2.Properties.VariableNames)),...
    "Variable names of the timetables are not in the same order") 

% Output variables with columns name in UPPER and in the same order
timetable1_output = timetable1;
timetable2_output = timetable2;

end