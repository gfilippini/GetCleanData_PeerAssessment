# Getting and Cleaning Data Course Project
## Giuliano Filippini

This file describes how run_analysis.R script works.

The purpose of this script is to demonstrate the steps to collect, clean and make a tidy data set for further analysis.
The data consists on information about data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This analysis uses the package reshape2

### R script steps:
0. - library for package reshape2
1. - download file
2. - read the tables of interest
3. - Join tables
4. - Input labels on the full data
5. - select only the fields with "mean and standard deviation"
6. - creates the final table with the means of each measure by activity and subject
7. - creates a .txt file with the mesurements - a tidy data