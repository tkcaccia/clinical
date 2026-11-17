
\name{continuous.test}

\alias{continuous.test}

\title{Continuous Information}

\description{Summarization of the continuous information.}

\usage{
continuous.test (name,
                 x,    
                 y,
                 center = c("median", "mean"),
                 digits = 3,
                 scientific = FALSE, 
                 range = c("IQR","95\%CI","range","sd"), 
                 logchange = FALSE,
                 pos=2, 
                 method=c("non-parametric","parametric"),
                 total.column=FALSE, ...) 
}

\arguments{
  \item{name}{the name of the feature.}
  \item{x}{the information to summarize.}
  \item{y}{the classification of the cohort.}
  \item{center}{A character string specifying the measure of central tendency to report: either \code{"median"} or \code{"mean"}.}
  \item{digits}{how many significant digits are to be used.}
  \item{scientific}{either a logical specifying whether result should be encoded in scientific format.}
  \item{range}{the range to be visualized.}
  \item{logchange}{either a logical specifying whether log2 of fold change  should be visualized.}
  \item{pos}{a value indicating the position of range to be visualized. 1 for column, 2 for row.}
  \item{method}{a character string indicating which test method is to be computed. "non-parametric" (default), or "parametric".}
  \item{total.column}{option to visualize the total (by default = "\code{FALSE}")}
  \item{...}{further arguments to be passed to or from methods.}
}

\value{
    The function returns a table with the summarized information and the relative p-value. For non-parametric method, if the number of group is equal to two, the p-value is computed using the Wilcoxon rank-sum test, Kruskal-Wallis test otherwise. For parametric method, if the number of group is equal to two, the p-value is computed using the Student's t-Test, ANOVA one-way otherwise.
  }

\details{
Group summaries are returned even when fewer than two groups have observed
values. The p-value is \code{NA} when fewer than two groups have observations
or all observations with a non-missing group label are identical. Missing group
labels do not count as an observed group. The total summary includes all
non-missing values in \code{x} and uses the requested \code{range}.

The numeric p-value is also available as the \code{"p-value"} attribute.
The \code{"shapiro test"} attribute contains the Shapiro-Wilk p-value when
\code{x} has between 3 and 5000 non-missing, finite observations and is not
constant; otherwise it is \code{NA}. Log fold change is reported only when
\code{y} has exactly two levels.
}

\author{Stefano Cacciatore}

  \seealso{\code{\link{correlation.test}}, \code{\link{categorical.test}}, \code{\link{txtsummary}}}

\examples{
data(prostate)

hosp=prostate[,"Hospital"]
gender=prostate[,"Gender"]
GS=prostate[,"Gleason score"]
BMI=prostate[,"BMI"]
age=prostate[,"Age"]

A=categorical.test("Gender",gender,hosp)
B=categorical.test("Gleason score",GS,hosp)

C=continuous.test("BMI",BMI,hosp,digits=2)
D=continuous.test("Age",age,hosp,digits=1)

rbind(A,B,C,D)


}
\keyword{continuous.test}








