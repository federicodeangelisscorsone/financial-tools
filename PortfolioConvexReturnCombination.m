function [X] = PortfolioConvexReturnCombination(timetable_momentum,timetable_value,phi,min_inv)
% PortfolioConvexReturnCombination is a function that computes the optimal weights of a portfolio optimization problem in which:
% - the return is a convex combination of two different definition of returns*
% - the risk is defined as returns variance;
% INPUTS: 
% (i) "timetable_momentum" is a timetable expressing market returns;
% (ii) "timetable_value" is a timetable expressing a fundamental ratio, such as
% CAPE or B/M;
% (iii) "phi" is the coefficient of the convex combination between value
% and momentum;
% (iv) "min_inv" is the minimum investment in each element;
% OUTPUTS:
% X = n-by-20 matrix of portfolio weights: each column is one point of the
% efficient frontier, from the minimum-variance portfolio to the maximum-return one;
%
% *See the paper "Mixing Momentum and Value Strategies in Portfolio
% Optimization" De Angelis Scorsone F. 
 
arguments (Input)
    timetable_momentum timetable
    timetable_value timetable
    phi (1,1) double {mustBeBetween(phi,0,1)}
    min_inv (1,1) double {mustBeBetween(min_inv,0,1)}
end

arguments (Output)
    X double
end

% --- 0) some introductory variables ---
n = width(timetable_momentum); %number of assets
P = 20; % number of frontier points

% ---- 1) Risk matrix H  ----
rr = timetable_momentum.Variables;
Sigma_rr = cov(rr);
H = 2.*Sigma_rr;

% ---- 3) Mean return (used inside the M vector) ----
mu_rr = mean(rr);

% ---- 4) Objective return vector M ----
mu_obj = timetable_value.Variables; % extract the variables
mu_obj = mu_obj(end,:);

% ---- 5) Objective return vector M ----
M = phi.*mu_rr+(1-phi).*mu_obj;

% ---- 6) Linear constraints ----
if min_inv == 0
    % we are not considering minimum investment in each industry but only an aggregate constraint
    AA = [ones(1,n); -ones(1,n)];     % sum(x)<=1 and sum(x)>=0.99
    C1 = [1;         -0.99];
    lb = zeros(n,1);
else
    AA = [ones(1,n); -ones(1,n)];   % sum(x)<=1 and sum(x)>=0.99 and each (x) >= Threshold
    C1 = [1;         -0.99];
    lb = ones(n,1).*min_inv; % it implies a minimum investment in each stock/elements of "min_inv" percentage
end

% ---- 7) Bounds and solver options ----
f  = zeros(n,1);
ub = ones(n,1);
opts_quad = optimoptions('quadprog','Display','none','MaxIterations',1000);
opts_lin = optimoptions('linprog','Display','none');

% ---- 8) Feasible return range (min-risk point and max return) ----
x_sol = quadprog(H,f,AA,C1,[],[],lb,ub,[],opts_quad); %solving for the minimum variance portfolio
pi_min_feasible = M*x_sol; % return of min-risk portfolio
[~,ret_max] = linprog(-M,AA,C1,[],[],lb,ub,opts_lin); % maximize M*x (it's negative since linprog is a minimizer)
pi_max_feasible = -ret_max;
pi_vec_M = linspace(pi_min_feasible,pi_max_feasible,P); % creating the array of returns

% ---- 9)  Frontier for each level of risk return ----
X = NaN(n,P); %pre-allocation
for j = 1:P
    beq = pi_vec_M(j); %for each level of return...
    [X(:,j),fval,exitflag(j)] = quadprog(H,f,AA,C1,M,beq,lb,ub,[],opts_quad); %...minimize the variance
end

fprintf('=== Optimization: Convex Return Definition === \n');
fprintf('Optimization: %d/%d solutions\n', sum(exitflag==1), P);


end