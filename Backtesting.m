function [Pf] = backtesting(data, X)
%backtesting a function to compute the value of a portfolio over time
arguments (Input)
    data struct
    X double
end

arguments (Output)
    Pf struct
end

ClosingPrices = data.ClosingPrices;
time = data.time_performance;
ClosingPrices = ClosingPrices(time,:);

prices = ClosingPrices{:, :};   % extract numeric matrix
ir = diff(prices) ./ prices(1:end-1,:);
Pf.time = ClosingPrices.Time(1:end);

Rp_ret = ir*X;
Pf.value = 100*cumprod([1; 1+Rp_ret]);

end