function results = portfolioRiskReturnMetrics(values, rf, periodsPerYear)
% portfolioRiskReturnMetrics
% Computes risk/return diagnostics for multiple portfolios.
%
% INPUTS:
%   values          - TxN matrix of portfolio values (T time points, N portfolios)
%   rf              - annual risk-free rate (e.g., 0.02 for 2%)
%   periodsPerYear - number of observations per year (252 daily, 12 monthly, etc.)
%
% OUTPUT:
%   results - struct containing metrics for each portfolio

arguments (Input)
   values double
   rf double
   periodsPerYear double
end
arguments (Output)
    results struct
end


if nargin < 2 || isempty(rf)
    rf = 0;
end
if nargin < 3 || isempty(periodsPerYear)
    periodsPerYear = 252;
end

% Compute simple returns
returns = diff(values) ./ values(1:end-1, :);

% Log returns (optional, useful for some analyses)
logReturns = diff(log(values));

% Mean and volatility (annualized)
meanRet = mean(returns) * periodsPerYear;
volRet  = std(returns) * sqrt(periodsPerYear);

% Sharpe ratio (annualized)
sharpe = (meanRet - rf) ./ volRet;

% Max drawdown
nPort = size(values, 2); % preallocation
maxDD = zeros(1, nPort); % preallocation
peaks = cummax(values, 1);
drawdowns = (values - peaks) ./ peaks;
maxDD = min(drawdowns, [], 1);

% Total return
totalReturn = (values(end, :) ./ values(1, :)) - 1;

% Package results
results = struct();
results.simpleReturns = returns;
results.logReturns = logReturns;
results.annualizedReturn = meanRet;
results.annualizedVolatility = volRet;
results.sharpeRatio = sharpe;
results.maxDrawdown = maxDD;
results.totalReturn = totalReturn;

end