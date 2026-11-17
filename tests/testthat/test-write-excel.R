test_that("completed clinical tables round-trip through Excel", {
  skip_if_not_installed("readxl")
  data("prostate", package = "clinical")
  for (total in c(FALSE, TRUE)) {
    ma <- initialization(prostate[, "Hospital"], total.column = total)
    # The ordered analysis uses permutation testing; keep the test repeatable.
    set.seed(123)
    for (feature in c("Gender", "Gleason score", "BMI", "Age")) {
      ma <- add_analysis(ma, feature, prostate[, feature])
    }
    before <- serialize(ma, NULL)
    path <- tempfile(fileext = ".xlsx")
    on.exit(unlink(path), add = TRUE)
    result <- withVisible(write_excel(ma, path))
    expect_identical(result$value, path)
    expect_false(result$visible)
    expect_identical(serialize(ma, NULL), before)
    actual <- as.data.frame(readxl::read_xlsx(path, col_types = "text", trim_ws = FALSE))
    expected <- as.data.frame(ma@x)
    expect_identical(names(actual), names(expected))
    expect_identical(nrow(actual), nrow(expected))
    # Excel readers return blank cells as NA; preserve all nonblank text exactly.
    for (column in names(expected)) {
      values <- as.character(expected[[column]])
      values[!is.na(values) & values == ""] <- NA_character_
      expect_identical(actual[[column]], values)
    }
    expect_identical("Total" %in% names(actual), total)
  }
})

test_that("export rejects empty objects and invalid paths", {
  ma <- initialization(factor(c("A", "B", "A", "B")))
  expect_error(write_excel(data.frame(x = 1), tempfile(fileext = ".xlsx")),
               "clinical.table")
  expect_error(write_excel(ma, tempfile(fileext = ".xlsx")), "no analysis results")
  ma <- add_analysis(ma, "category", factor(c("a", "b", "a", "b")))
  for (path in list(NULL, NA_character_, character(), c("a.xlsx", "b.xlsx"),
                    "", "summary.csv", 1)) {
    expect_error(write_excel(ma, path), "ending in .xlsx")
  }
})
