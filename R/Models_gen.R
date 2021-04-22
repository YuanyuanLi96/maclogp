##################################Main function
#' Generate all subset models
#'
#' This function generates a list including all subset models given a
#' vector of candidate predictors.
#' @param predictors a vector including the indexes of all predictors,
#' such as \code{1:p}.
#' @return Returns a list with one entry for each model. Each entry is an integer
#'  vector that specifies the columns of matrix \code{x} to be used as a regressor in that model.
#' @export
#' @seealso \code{\link[utils]{combn}}, \code{\link[rlist]{list.flatten}}
#' @examples
#' Models_gen(1:5)


#predictors is a vector,like 1,...,p
Models_gen = function(predictors){
  models = lapply(0:length(predictors), function(x)combn(predictors,x,simplify =F))
  models = list.flatten(models)
  names(models) =as.character(1:length(models))
  return(models)
}
