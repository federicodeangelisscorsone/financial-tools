function [CellRW] = HoldingWindows(t)
%   CellRW = HOLDINGWINDOWS(t) returns a (numel(t)-1)-by-1 cell array.
%   Each cell holds a timerange object covering the holding period
%   between two consecutive dates in t:
%
%       CellRW{k} = (t(k), t(k+1)]
%
%   The left end is open because the portfolio is rebalanced at the close
%   of t(k): returns on t(k) belong to the previous period. The right end
%   is closed, so t(k+1) is the last day of period k.
%
%   Input:
%     t       - datetime vector of rebalancing dates, sorted in increasing
%               order (e.g. the window end dates t2 from RollingWindow).
%   Output:
%     CellRW  - cell array of timerange objects, used to index a timetable:
%               TT(CellRW{k}, :)
%

arguments (Input)
    t datetime
end

arguments (Output)
    CellRW cell
end

% length of the datetime array
len = length(t);

% pre-allocation of the output
CellRW = cell(len-1,1);

for k=2:len
    t2 = t(k);
    t1 = t(k-1);
    CellRW{k-1,:} = timerange(t1,t2,"openleft");
end

end