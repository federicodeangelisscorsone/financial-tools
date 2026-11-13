These are the functions I created to assist me during my work.

# Data-Management 🧮

### FittingData (MATLAB)
FittingData is a function that extracts from a stacked timetable a sub-timetable in which the content is given by "variable_fitted" and the columns are taken from "variable_of_interest". Similar to the built-in function unstack.

### CheckColumns (MATLAB)
CheckColumns is a function that checks that two timetables have the same variables (case-insensitive), e.g. the same industries in a returns timetable and in a fundamentals timetable. It returns both timetables with UPPERCASE variable names and the columns sorted in the same (alphabetical) order, and it stops with an error if the two sets of variables differ.

# Analysis ⌨️

### StationarityTests (MATLAB)
StationarityTests is a function that applies a collection of statistical tests to a timetable. If the timetable is a matrix, it considers each column as a single variable.
An example of a timetable to which you can apply this function is the output of the "FittingData" function.

### BadData (MATLAB)
BadData is a function that checks for NaN, Inf and zero values in a timetable with a structure as the output of the function "FittingData" (see also the built-in function "unstack"). It returns logical arrays marking where these values are and issues a warning for each type found, reporting the percentage of affected values.

### OutliersManagement (MATLAB)
OutliersManagement is a function that detects the outliers in a timetable and replaces them, using the built-in functions "isoutlier" and "filloutliers". The detection method (e.g. "median", "mean", "quartiles") and the fill method (e.g. "linear", "previous", "clip") are chosen by the user. Besides the cleaned timetable, it returns and prints the percentage of values flagged as outliers before and after the treatment, as a quick diagnostic.

# Portfolio optimization 📈

### PortfolioValueMomentumMix (MATLAB)
PortfolioValueMomentumMix is a function that computes the efficient frontier (20 points) of a mean-variance problem in which the expected return is a convex combination, with weight "phi", of a momentum signal (the mean of past returns) and a value signal (the latest value of a fundamental ratio, e.g. CAEY or B/M). Risk is the variance of returns. The portfolio is long-only, invests between 99% and 100% of the wealth, and can impose a minimum investment in each asset. It uses the built-in solvers "quadprog" and "linprog" and returns the weights of each frontier portfolio. See the paper "Mixing Momentum and Value Strategies in Portfolio Optimization" (De Angelis Scorsone F., in preparation).

# Work in progress 🚧

The following functions are work in progress: Backtesting, PortfolioConcentration and PortfolioRiskReturnMetrics.
