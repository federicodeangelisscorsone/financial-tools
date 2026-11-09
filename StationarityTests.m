function [results_adf,results_pp,results_kpss] = StationarityTests(timetable1,lags)
%"StationarityTests" is a function that applies a collection of statistical
%tests to a timetable. If the timetable is a matrix, it consider each
%column as a single variable.
%An example of timetable in which you can apply this
%function is given as an output from the "FittingData" function

arguments (Input)
    timetable1 timetable
    lags double
end

arguments (Output)
    results_adf table
    results_pp table
    results_kpss table
end

% size of the timetable
[rows, cols] = size(timetable1);

% compute the statistical test
for k = 1:cols
    subset = timetable1{:,k};
    [h_adf(k),pValue_adf(k),stat_adf(k),cValue_adf(k)] = adftest(subset,"Lags",lags,"Model","ARD");
    [h_pp(k),pValue_pp(k),stat_pp(k),cValue_pp(k)] = pptest(subset,"Lags",lags,"Model","ARD");
    [h_kpss(k),pValue_kpss(k),stat_kpss(k),cValue_kpss(k)] = kpsstest(subset,"Lags",lags);
end

%########
% WRITING RESULTS
%########

% ADF results
results_adf = table(h_adf',pValue_adf',stat_adf',cValue_adf');
results_adf.Properties.VariableNames = ["h_adf","pValue_adf","stat_adf","cValue_adf"];
results_adf.vrbl = categorical(timetable1.Properties.VariableNames)';
results_adf = movevars(results_adf,"vrbl","Before","h_adf");

% PP results
results_pp = table(h_pp',pValue_pp',stat_pp',cValue_pp');
results_pp.Properties.VariableNames = ["h_pp","pValue_pp","stat_pp","cValue_pp"];
results_pp.vrbl = categorical(timetable1.Properties.VariableNames)';
results_pp = movevars(results_pp,"vrbl","Before","h_pp");

% KPSS results
results_kpss = table(h_kpss',pValue_kpss',stat_kpss',cValue_kpss');
results_kpss.Properties.VariableNames = ["h_kpss","pValue_kpss","stat_kpss","cValue_kpss"];
results_kpss.vrbl = categorical(timetable1.Properties.VariableNames)';
results_kpss = movevars(results_kpss,"vrbl","Before","h_kpss");

end
