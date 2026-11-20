function [rw,t2] = HoldingWindow(t1,m)
% "HoldingWindow" is a function that computes:
% - the timerange
% - the datetime
% of an initial datetime "t" and added by "m" months

arguments (Input)
    t1 datetime
    m (1,1) double
end

arguments (Output)
    rw timerange
    t2 datetime
end

end
