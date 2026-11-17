library(clinical)

# Ordinary inputs retain the same tests and numeric attributes.
x <- c(1, 3, 5, 8, 9, 12)
y <- rep(c("A", "B"), each = 3)
for (method in c("non-parametric", "parametric")) {
    result <- continuous.test("value", x, y, method = method)
    expected <- if (method == "parametric") t.test(x ~ y)$p.value else
        wilcox.test(x ~ y, exact = FALSE)$p.value
    stopifnot(identical(attr(result, "p-value"), expected),
              identical(attr(result, "shapiro test"), shapiro.test(x)$p.value))
}

# Incomplete or constant features still produce usable summary rows.
for (values in list(rep(NA_real_, 6), rep(1, 6), c(1, 2), numeric(0))) {
    for (method in c("non-parametric", "parametric")) {
        result <- continuous.test("value", values, rep("A", length(values)),
                                  method = method)
        stopifnot(nrow(result) == 1, is.na(attr(result, "p-value")),
                  is.na(attr(result, "shapiro test")))
    }
}
for (method in c("non-parametric", "parametric")) {
    result <- continuous.test("constant", rep(1, 6), y, method = method)
    stopifnot(is.na(attr(result, "p-value")),
              is.na(attr(result, "shapiro test")))
}

# Missing labels must not count as an additional observed group.
result <- continuous.test("value", c(1, 2, 3, NA, NA, 6),
                          factor(c("A", "A", "A", "B", "B", NA)),
                          logchange = TRUE)
stopifnot(is.na(attr(result, "p-value")),
          is.na(attr(result, "p-logchange")))

# Single-group summaries and totals honor the requested range.
result <- continuous.test("value", x, rep("A", 6), range = "sd",
                          total.column = TRUE)
stopifnot(result$A == txtsummary(x, digits = 3, range = "sd"),
          result$Total == result$A)
for (pos in c(1, 2)) {
    result <- continuous.test("value", x, rep(NA_character_, 6), pos = pos,
                              total.column = TRUE, logchange = TRUE)
    stopifnot(ncol(result) == 3, is.na(attr(result, "p-value")))
}

# Shapiro's limits apply to observed values and include 5000 observations.
values <- c(1, 2, 4, rep(NA_real_, 5000))
result <- continuous.test("value", values, rep("A", length(values)))
stopifnot(identical(attr(result, "shapiro test"), shapiro.test(c(1, 2, 4))$p.value))
values <- seq_len(5000)
result <- continuous.test("value", values, rep("A", length(values)))
stopifnot(identical(attr(result, "shapiro test"), shapiro.test(values)$p.value))
result <- continuous.test("value", seq_len(5001), rep("A", 5001))
stopifnot(is.na(attr(result, "shapiro test")))

# Invalid arguments fail with a useful error.
for (call in list(
    quote(continuous.test("value", x, y, method = "invalid")),
    quote(continuous.test("value", x, y[-1])),
    quote(continuous.test("value", letters[1:6], y))
)) stopifnot(inherits(try(eval(call), silent = TRUE), "try-error"))
