# clinical 0.1.1

* Fix incorrect intersections caused by counting duplicate values across
  concatenated inputs. Intersections now use successive `base::intersect()`
  calls, preserving base semantics for types, missing values and empty results.
* Add `intersect_multiple()` as the preferred API. The exported `intersect()`
  remains as a deprecated compatibility wrapper and emits a warning. It still
  masks `base::intersect()` when the package is attached; use the explicit base
  function for two-vector intersections.
* Compatibility: results are no longer always character vectors or `NULL`;
  their types and ordering now follow base R on the installed R version.
