# clinical 0.1.1

* Fix incorrect intersections caused by counting duplicate values across
  concatenated inputs. Intersections now use successive `base::intersect()`
  calls, preserving base semantics for types, missing values and empty results.
* Compatibility: results are no longer always character vectors or `NULL`;
  their types and ordering now follow base R on the installed R version.
