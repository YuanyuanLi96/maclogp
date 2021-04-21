#' Diabetes data
#'
#' These data consist of observations on 442 patients, with the 
#' response of interest being a quantitative measure of disease progression
#'  one year after baseline. There are ten baseline variables and
#'   have been normalized to have mean 0 and Euclidean
#'    norm 1. The response variable has been centered (mean 0).
#'
#' @format A data frame with 442 rows and 11 variables:
#' \describe{
#'   \item{V1}{age}
#'   \item{V2}{sex}
#'   \item{V3}{body-mass index}
#'   \item{V4}{average blood pressure}
#'   \item{V5}{blood serum measurement 1}
#'   \item{V6}{blood serum measurement 2}
#'   \item{V7}{blood serum measurement 3}
#'   \item{V8}{blood serum measurement 4}
#'   \item{V9}{blood serum measurement 5}
#'   \item{V10}{blood serum measurement 6}
#'   \item{V11}{disease progression}
#' }
#' @source \url{https://web.stanford.edu/~hastie/Papers/LARS/diabetes.sdata.txt}
#' @references{ Efron, Hastie, Johnstone and Tibshirani (2003), Least Angle Regression.
#' \emph{Annals of Statistics}.
#' }
"diabetes"
