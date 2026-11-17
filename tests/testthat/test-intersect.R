test_that("duplicates cannot create or remove intersection members", {
  x <- c("A", "B")
  y <- c("B", "C", "C")
  expect_identical(clinical::intersect(x, y), "B")
  expect_identical(clinical::intersect(c("A", "B", "B"), y), "B")

  x <- c("GW22_01_003", "SADT001")
  y <- c("SADT001", "SOL_PCO_165", "SOL_PCO_165")
  expect_identical(clinical::intersect(x, y), "SADT001")
  expect_false("SOL_PCO_165" %in% clinical::intersect(x, y))
})

test_that("two-vector intersections agree exactly with base R", {
  pairs <- list(
    list(c("C", "A", "B", "A"), c("B", "C", "C", "D")),
    list(character(), "A"), list("A", character()),
    list("A", "B"), list(NULL, c(1, 2)),
    list(c(NA_character_, "A", NA_character_), c("B", NA_character_)),
    list(c(3, 1, 2, 2, NA, NaN), c(NaN, 2, 3, NA)),
    list(c(3L, 1L, 2L), c(2L, 3L)),
    list(c(TRUE, FALSE, NA), c(NA, TRUE)),
    list(factor(c("B", "A", "B", NA), levels = c("B", "A", "C")),
         factor(c("C", "B", NA), levels = c("C", "B", "A"))),
    list(factor(c("A", "B")), c("B", "C"))
  )
  for (pair in pairs) {
    expected <- base::intersect(pair[[1]], pair[[2]])
    expect_identical(clinical::intersect(pair[[1]], pair[[2]]), expected)
  }
})

test_that("every result belongs to all inputs, regardless of duplicates", {
  cases <- list(
    list(c("A", "B", "C"), c("B", "C", "D"), c("C", "D", "E")),
    list(c("A", "A", "B"), c("B", "C", "C"), c("B", "D")),
    list(c("B", "B", "A"), c("B", "B", "C"), c("B", "B", "D")),
    list(c(NA, 1, 1), c(1, NA, 2), c(NA, 1, 3), c(1, NA)),
    list("A", character(), c("A", "A")),
    list(factor(c("A", "B")), factor(c("B", "C")), factor("B"))
  )
  for (vectors in cases) {
    result <- do.call(clinical::intersect, vectors)
    expect_identical(result, Reduce(base::intersect, vectors))
    for (vector in vectors) expect_true(all(result %in% vector))
    expect_identical(anyDuplicated(result), 0L)
  }
  expect_identical(do.call(clinical::intersect, cases[[1]]), "C")
  expect_identical(do.call(clinical::intersect, cases[[2]]), "B")
})

test_that("intersect retains its API without warnings", {
  expect_no_warning(result <- clinical::intersect(c("A", "B"), c("B", "C", "C")))
  expect_identical(result, "B")
})
