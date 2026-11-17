\name{intersect_multiple}
\alias{intersect_multiple}
\alias{intersect}
\title{Intersection of Multiple Vectors}
\description{
Returns the unique elements shared by all supplied vectors using base R set
intersection semantics.
}
\usage{
intersect_multiple(x, y, ...)

intersect(x, y, ...)
}
\arguments{
  \item{x}{A vector.}
  \item{y}{A vector.}
  \item{...}{Additional vectors to include in the intersection.}
}
\details{
The implementation successively applies \code{\link[base]{intersect}} from
left to right. Duplicates within one input do not imply membership in another.
With two inputs the result is identical to \code{base::intersect(x, y)},
including ordering, missing values, types and class handling on the running
version of R. With more inputs, the same semantics apply at each step.

\code{intersect} is a deprecated compatibility wrapper and signals a
\code{deprecatedWarning}. Use \code{intersect_multiple} for new code. The
legacy export still masks \code{base::intersect} when the package is attached;
use \code{base::intersect} explicitly for the base two-vector function.
}
\value{
The result of \code{Reduce(base::intersect, list(x, y, ...))}. Empty results
follow base R semantics (for example, \code{character(0)} for disjoint character
vectors), rather than returning \code{NULL} unconditionally.
}
\examples{
x <- c("a", "b", "c")
y <- c("b", "c", "d", "d")
z <- c("c", "b", "e")

intersect_multiple(x, y, z)  # "b" and "c"
intersect_multiple(x, y, c("f", "g"))  # character(0)
}
\seealso{\code{\link[base]{intersect}}, \code{\link[base]{union}},
\code{\link[base]{setdiff}}}
\author{Stefano Cacciatore}
\keyword{sets}
