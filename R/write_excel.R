write_excel = function(ma, path) {
  if (!methods::is(ma, "clinical.table")) {
    stop("ma must be a clinical.table object created by initialization().")
  }
  if (is.null(ma@x) || nrow(ma@x) == 0L) {
    stop("ma has no analysis results. Use add_analysis() before exporting.")
  }
  if (!is.character(path) || length(path) != 1L || is.na(path) ||
      !nzchar(path) || !grepl("\\.xlsx$", path, ignore.case = TRUE)) {
    stop("path must be a single non-missing file name ending in .xlsx.")
  }
  writexl::write_xlsx(as.data.frame(ma@x), path = path)
  invisible(path)
}
