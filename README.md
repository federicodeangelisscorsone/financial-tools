These are the functions I created to assist me during my work.

# Data-Management 🧮

### FittingData (MATLAB)
FittingData is a function that extracts from a stacked timetable a sub-timetable in which the content is given by "variable_fitted" and the columns are taken from "variable_of_interest". Similar to the built-in function unstack.

# Analysis ⌨️

### StationarityTests (MATLAB)
StationarityTests is a function that applies a collection of statistical tests to a timetable. If the timetable is a matrix, it considers each column as a single variable.
An example of a timetable to which you can apply this function is the output of the "FittingData" function.

### BadData (MATLAB)
BadData is a function that checks for NaN, Inf and zero values in a timetable with a structure as the output of the function "FittingData" (see also the built-in function "unstack"). It returns logical arrays marking where these values are and issues a warning for each type found.

# Work in progress 🚧

The following functions are work in progress: Backtesting, PortfolioConcentration and PortfolioRiskReturnMetrics.
