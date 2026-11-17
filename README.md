
## Installation

```
library(devtools)
install_github("tkcaccia/clinical")

```

## Intersections

Use `base::intersect(x, y)` for two vectors, or the explicit multi-vector API:

```r
clinical::intersect_multiple(
  c("A", "B"),
  c("B", "C", "C"),
  c("B", "D")
)
# [1] "B"
```

Starting in 0.1.1, `clinical::intersect()` uses the corrected logic but is
deprecated in favor of `intersect_multiple()`. The legacy export still masks
`base::intersect()` when the package is attached and emits a deprecation warning
when called. Results now follow base R semantics, including typed empty results
and handling of duplicates and missing values.
