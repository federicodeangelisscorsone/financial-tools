function [concentration] = PortfolioConcentration(X,idx)
% PortfolioConcentration computes the concentration of a set of portfolio
% weights

arguments (Input)
    X double
    idx string
end
arguments (Output)
    concentration double
end

format longg

if ndims(X) == 3
    [nrow, ncol, npage] = size(X);
    concentration = NaN(npage,ncol);
    for k = 1:npage
        for j = 1:ncol
            concentration_list = concentrationIndices(X(:, j, k));
            concentration(k,j) = concentration_list.(idx);
        end
    end
elseif ndims(X) == 2
    [nrow, ncol] = size(X);
    concentration = NaN(1,ncol);
    for j = 1:ncol
        concentration_list = concentrationIndices(X(:,j));
        concentration(j) = concentration_list.(idx);
    end
else
    disp("Error")
end

end