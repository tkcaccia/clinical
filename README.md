
## Installation

```
library(devtools)
install_github("tkcaccia/clinical")

```

## Save a clinical table to Excel

```r
library(clinical)
data(prostate)

ma <- initialization(prostate[, "Hospital"])
ma <- add_analysis(ma, "Gender", prostate[, "Gender"])
ma <- add_analysis(ma, "Gleason score", prostate[, "Gleason score"])
ma <- add_analysis(ma, "BMI", prostate[, "BMI"])
ma <- add_analysis(ma, "Age", prostate[, "Age"])

write_excel(ma, "clinical_summary.xlsx")
```

The workbook contains the displayed summary table with column headings and
formatted results. Set `total.column = TRUE` in `initialization()` to include
the Total column. `writexl` is installed automatically as a package dependency.
An existing file at the supplied path is overwritten.
