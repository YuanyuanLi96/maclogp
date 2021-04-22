#' Mac and LogP measure
#'
#' This function allows you to obtain a model confidence set using Mac procedure and the LogP uncertainty measure
#' for a selection method based on an information criterion.
#' @param models A list with one entry for each model. Each entry is an
#' integer vector that specifies the columns of matrix \code{data$x} to be used
#' as a regressor in that model. An intercept will be fitted automatically.
#' @param data a list including
#' \describe{
#' \item{x}{covariates matrix, of dimension nobs and nvars;each row is an observation vector.}
#' \item{y}{response variable.}
#' }
#' @param B number of bootstrap replicates to perform; Default value is 200.
#' @param alpha a vector of significance levels. The confidence levels of the model confidence sets
#' are 1-\code{alpha}. Default value is 0.05.
#' @param method Information criterion. Users can choose from \code{"bic"}, \code{"aic"}.
#' Default value is \code{"bic"}.
#' @param delta A small positive number added inside of LogP when the bootstrap
#' probability of selected model is 1. Default value is \code{1e-4}.
#' @param eps toterance level in choosing models with total bootstrap probabilities
#' at least \code{1-alpha}. Default value is \code{1e-6}.
#' @return Returns an object of class “MAC”. An object of
#' class “MAC” is a list containing at least the following components:
#' \item{hat_M}{numeric index of selected model.}
#' \item{con_sets}{a list with with one entry for a \code{1-alpha} model confidence set.
#' Each entry is an integer vector that specifies the models selected in this set. The model
#' indexes used in \code{con_sets} are their orders in \code{models}.}
#' \item{length_con}{lengths of confidence sets.}
#' \item{order}{Model indexes with increasing information scores based on original data.}
#' \item{probs_inorder}{Bootstrap probabilities for the models in \code{order}.}
#' \item{beta_ls}{a list with one entry for each model. Each entry is a vector
#' of estimated coefficients based on original data for that model.}
#' \item{hat_prob}{the Bootstrap probability for single selected model.}
#' \item{hat_logp}{the LogP measure.}
#' @keywords Mac LogP
#' @seealso \code{\link{plot_MAC}}
#' @references 
#' Liu, X., Li, Y. & Jiang, J.(2020). Simple measures of uncertainty for model selection.
#' \emph{TEST}, 1-20.

#' @export
#' @examples
#' set.seed(0)
#' n= 50
#' B= 100
#' p= 5
#' x = matrix(rnorm(n*p, mean=0, sd=1), n, p)
#' true_b = c(1:3, rep(0,p-3))
#' y = x%*% true_b+rnorm(n)
#' alpha=c(0.1,0.05,0.01)
#' data=list(x=x,y=y)
#' models=Models_gen(1:p)
#' result=MAC(models, data, B, alpha)

##This is the method we proposed in our paper
MAC =function(models, data, B, alpha, method= "bic", delta=1e-4, eps=1e-6){
  X = data$x
  n = nrow(X)
  #select model using original data
  hat_M = Sel(models, data, method= method, n)#a list including \hat{M}, \hat{\psi} and rank
  hat_M_index = hat_M$index
  rank_M = hat_M$rank

  ##bootstrap procedure
  boot_index = rep(0, B)
  rank_boot = matrix(0, nrow = B, ncol = length(models))
  for (b in 1:B){
    #generate data under hat_M
    y_b <- Generate.Y(hat_M$predy,hat_M$sigmasq,n)
    dataF_b=list(y=y_b, x=X)
    #select model using bootstrap data
    hat_M_boot = Sel(models, dataF_b, method= method,n)#a list including \hat{M}, \hat{\psi} and rank
    boot_index[b] = hat_M_boot$index
    rank_boot[b,] = hat_M_boot$rank
  }

  result =list()
  result$hat_M = hat_M_index
  ##confidence sets
  prob_boot = apply(rank_boot, 2, function(x)sum(x == hat_M_index)/B)
  sum_prob = sapply(1:length(prob_boot), function(x)sum(prob_boot[1:x]))
  k = sapply(alpha, function(x)which(sum_prob-1+x>-eps)[1])
  result$con_sets = lapply(k, function(x)rank_M[1:x])
  result$length_con = k
  result$order= rank_M
  result$probs_inorder= prob_boot
  result$betals= hat_M$betals
  ##prob of \hat{M}_b = \hat{M}
  result$hat_prob = sum(boot_index == hat_M_index)/B
  result$hat_logP = log(1 - ifelse(result$hat_prob<1, result$hat_prob, 1 - delta))
  return(result)
}

