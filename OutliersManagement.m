function [out_timetable,perc_before,perc_after] = OutliersManagement(timetable1, findmethod, fillmethod)
% "OutliersManagement" is a function that checks for outliers and substitute them. 
% Moreover, it provides an overall diagnostics.

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
perc_before = nBefore/numel(timetable1);

%fill the outliers
out_timetable = filloutliers(timetable1,fillmethod,findmethod);

% Check the number of supposed outliers after the treatment
nAfter = nnz(isoutlier(out_timetable, findmethod));
perc_after = nAfter/numel(out_timetable);