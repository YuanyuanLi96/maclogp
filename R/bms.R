#' Bayesian Model Confidence Set
#'
#' This function allows you to obtain a bayesian model confidence set with
#' approximate posterior model probability.
#' @param data a list including
#' \describe{
#' \item{x}{covariates matrix, of dimension nobs and nvars;each row is an observation vector.}
#' \item{y}{response variable.}
#' }
#' @param alpha a vector of significance levels. The confidence levels are 1-\code{alpha}.
#' Default value is 0.05.
#' @param eps toterance level in choosing models with total posteriors
#' at least \code{1-alpha}. Default value is \code{1e-6}.
#' @return Returns a list containing:
#' \item{models}{A list with one entry for each model. Each entry is an integer
#'  vector that specifies the columns of matrix \code{x} to be used as a regressor in that model.
#'  Models is ordered with decreasing posteriors.}
#' \item{con_sets}{a list with with one entry for a \code{1-alpha} model confidence set.
#' Each entry is an integer vector that specifies the models selected in this set. The model
#' indexes used in \code{con_sets} are their orders in \code{models}.}
#' \item{length_con}{lengths of confidence sets.}
#' \item{probs_inorder}{Model posteriors in decreasing order.}
#' \item{beta_ls}{a list with one entry for each model. Each entry is a vector
#' of estimated coefficients for that model.}
#' @seealso \code{\link[BMA]{bic.glm}}
#' @references 
#' Liu, X., Li, Y. & Jiang, J.(2020). Simple measures of uncertainty for model selection.
#' \emph{TEST}, 1-20.
#' 
#' Raftery, Adrian E. (1995). Bayesian model selection in social research (with Discussion). 
#' \emph{Sociological Methodology} 1995 (Peter V. Marsden, ed.), pp. 111-196.
#' @keywords Bayesian
#' @examples
#' n= 50
#' B= 100
#' p= 5 
#' x = matrix(rnorm(n*p, mean=0, sd=1), n, p)
#' true_b = c(1:3, rep(0,p-3))
#' y = x%*% true_b+rnorm(n)
#' alpha=c(0.1,0.05,0.01)
#' data=list(x=x,y=y)
#' result=bms(data,alpha)
#' @export

bms = function(data, alpha,eps=1e-6){
  Y= data$y
  X= data$x
  post = list()
  fit=bic.glm(X,Y,glm.family = gaussian(),
              occam.window=F, OR.fix=1000)
  mod.probs=fit$postprob
  mm = apply(fit$which,1, function(x)which(x==T))
  sum_prob = sapply(1:length(mod.probs), function(x)sum(mod.probs[1:x]))
  k = sapply(alpha,function(x)which(sum_prob-1+x >-eps)[1])
  result=list()
  result$models=mm
  result$con_sets = lapply(k, function(x)1:x)#return a list of sublists(models)
  result$length_con = k
  result$probs_inorder= mod.probs
  result$betals=apply(fit$mle,1,function(x)x[x!=0])
  return(result)
}
