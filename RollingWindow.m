function [rw,t2] = RollingWindow(t1,m)
% "RollingWindow" is a function that computes:
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

% final datetime
t2 = t1+calmonths(m);
rw = timerange(t1,t2,"closed");

end