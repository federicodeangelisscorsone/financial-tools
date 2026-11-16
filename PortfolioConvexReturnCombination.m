function [X] = PortfolioConvexReturnCombination(timetable1,timetable2,phi,min_inv)
% PortfolioConvexReturnCombination is a function that computes a long-only mean-variance
% efficient frontier in which the expected-return vector is a convex
% combination of two return definitions:
%
%     M = phi * mean(timetable1) + (1 - phi) * mean(timetable2)
% and risk is the portfolio variance x'*Sigma*x, with Sigma the sample
% covariance of timetable1.
%
% For P = 20 target values of M*x, equally spaced between the
% minimum-variance portfolio and the maximum-M portfolio, it solves
%     min x'*Sigma*x   s.t.  M*x = target,  0.99 <= sum(x) <= 1,
%                            min_inv <= x_i <= 1.
% INPUTS: 
% (i)   timetable1 - T-by-n timetable of periodic asset returns (decimals).
%       Used for both the first return definition (sample mean) and the
%       covariance matrix.
% (ii)  timetable2 - timetable with the second return definition for the
%       same n assets, same column order. Its sample mean is used.
%       Must be in the same units as the returns in timetable1 (e.g.
%       expected return per period);
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
    timetable1 timetable
    timetable2 timetable
    phi (1,1) double {mustBeBetween(phi,0,1)}
    min_inv (1,1) double {mustBeBetween(min_inv,0,1)}
end

arguments (Output)
    X double
end

% --- 0) some introductory variables ---
n = width(timetable1); %number of assets
P = 20; % number of frontier points

% ---- 1) Risk matrix H  ----
rr = timetable1.Variables;
Sigma_rr = cov(rr);
H = 2.*Sigma_rr;

% ---- 3) Mean return (used inside the M vector) ----
mu_rr = mean(rr);

% ---- 4) Objective return vector M ----
mu_obj = timetable2.Variables; % extract the variables
mu_obj = mean(mu_obj);

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