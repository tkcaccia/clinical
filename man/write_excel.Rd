\name{write_excel}
\alias{write_excel}
\title{Save a Clinical Summary Table to Excel}
\description{
Writes the completed summary table from a \code{clinical.table} object to an
Excel \code{.xlsx} file using \pkg{writexl}.
}
\usage{
write_excel(ma, path)
}
\arguments{
  \item{ma}{A \code{clinical.table} object created by \code{initialization()}
  and populated with \code{add_analysis()}.}
  \item{path}{A single file path ending in \code{.xlsx}. The parent directory
  must exist. An existing file at this path is overwritten.}
}
\details{
Exports the displayed summary table, including the Feature column, group
headings, formatted counts and percentages, and p-values. A Total column is
included when the object was initialized with \code{total.column = TRUE}.
Formatted summaries and p-values remain text. Internal row names, patient-level
inputs and object attributes are not exported. The object is not modified.
An object with no analysis results cannot be exported.
}
\value{The supplied \code{path}, invisibly.}
\examples{
data(prostate)
ma <- initialization(prostate[, "Hospital"])
ma <- add_analysis(ma, "Gender", prostate[, "Gender"])
ma <- add_analysis(ma, "Gleason score", prostate[, "Gleason score"])
ma <- add_analysis(ma, "BMI", prostate[, "BMI"])
ma <- add_analysis(ma, "Age", prostate[, "Age"])
path <- tempfile(fileext = ".xlsx")
write_excel(ma, path)
unlink(path)
}
\seealso{\code{\link{initialization}}, \code{\link{add_analysis}},
\code{\link[writexl]{write_xlsx}}}
\keyword{file}
