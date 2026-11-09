# Data-Management 🧮

### FittingData (MATLAB)
FittingData is a function that extract from, a stacked timetable, a  sub-timetable in which the content is given by "variable_fitted" and the columns are taken from "variable_of_interest". Similar to the built-in function unstack

# Analysis ⌨️

### StationarityTests (MATLAB)
StationarityTests is a function that applies a collection of statistical tests to a timetable. If the timetable is a matrix, it consider each column as a single variable.
An example of timetable in which you can apply this function is given as an output from "FittingData" function

### NullData (MATLAB)
NullData "NullData" is a function that checks for the number of NaN, Inf and zero values in a timetable with a structure as the output of the function "FittingData" (see also the built-in function "unstack"). It stops in the case there are NaN or Inf values
