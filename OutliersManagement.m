function [out_timetable,perc_before,perc_after] = OutliersManagement(timetable1, findmethod, fillmethod)
% OutliersManagement is a function that detects the outliers in a timetable and replaces them,
% using the built-in functions "isoutlier" and "filloutliers". 
% The detection method and the fill method are chosen by the user. 
% Besides the cleaned timetable, it returns the share of values flagged as 
% outliers before and after the treatment, as a quick diagnostic.

arguments (Input)
    timetable1 timetable
    findmethod string
    fillmethod string
end

arguments (Output)
    out_timetable timetable
    perc_before double
    perc_after double
end

% Check the number of supposed outliers before the treatment
nBefore = nnz(isoutlier(timetable1, findmethod));
perc_before = nBefore/numel(timetable1)*100;

%fill the outliers
out_timetable = filloutliers(timetable1,fillmethod,findmethod);

% Check the number of supposed outliers after the treatment
nAfter = nnz(isoutlier(out_timetable, findmethod));
perc_after = nAfter/numel(out_timetable)*100;
fprintf("Outliers before treatment: %.2f%% | Outliers after treatment: %.2f%%\n", ...
    perc_before, perc_after)
