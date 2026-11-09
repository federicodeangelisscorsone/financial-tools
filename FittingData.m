function [output1] = FittingData(timetable1,variable_of_interest,variable_fitted)
% "FittingData" is a function that extract from, a stacked timetable, a
% sub-timetable in which the content is given by "variable_fitted" and the
% columns are taken from "variable_of_interest".
% Similar to the built-in function unstack


arguments (Input)
    timetable1 timetable
    variable_of_interest string
    variable_fitted string
end

arguments (Output)
    output1 timetable
end

% extracting a subset of the data composed by the variable name and the
% selected variable
timetable1 = timetable1(:,[variable_of_interest,variable_fitted]);
timetable1 = convertvars(timetable1,variable_of_interest,"categorical");
% extracting the single name of the variables
tickers = unique(timetable1(:,variable_of_interest).Variables);
% creating and empty timetable
tmtbl = timetable(unique(timetable1.public_date));

for k = 1:length(tickers)
    var_single = timetable1(timetable1(:,variable_of_interest).Variables == tickers(k), :);
    var_single = sortrows(var_single,timetable1.Properties.DimensionNames{1});
    var_single = removevars(var_single, variable_of_interest);
    var_single.Properties.VariableNames(1) = string(tickers(k));
    tmtbl = synchronize(tmtbl, var_single);
end

% writing the output
output1 = tmtbl;

end