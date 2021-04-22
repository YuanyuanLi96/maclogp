#' Visualize model confidence sets
#'
#' This funcion generates a heat map for a given model confidence set. Each row represents
#' a model in the confidence set, and colored cell represents the variables in that model.
#' @param models A list with one entry for each model. Each entry is an
#' integer vector that specifies the columns of matrix X without intercept to be used
#' as a regressor in that model. Intercept will be fitted automatically for every model.
#' such as \code{1:p}.
#' @param alpha Significance levels. The confidence levels for confidence sets
#' are \code{1-alpha}.
#' @param con_sets a list with with one entry for a \code{1-alpha} model confidence set.
#' Each entry is an integer vector that specifies the models selected in this set. The model
#' indexes used in \code{con_sets} are their orders in \code{models}.
#' @param p the number of candidate variables.
#' @param xnames variable names of all candidate variables. Default is \code{1:p}.
#' @param color the color that indicates a variable is selected. Default is "lightblue".
#' @return Returns a logical matrix per confidence set
#' with one row per model and one column per variable indicating whether that
#' variable is in the model.
#'
#' Generates a corresponding heat map per confidence set with one row per model and
#' one column per variable indicating whether that
#' variable is in the model. A cell in white means the variable is not in that model;
#' a cell in user-specified color means the variable is in that model.
#' @export
#' @seealso \code{\link{MAC}}
#' @examples
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
#' plot_MAC(models, alpha, result$con_sets, p)
#' result2=bms(data, alpha)
#' plot_MAC(result2$models, alpha, result2$con_sets, p)

plot_MAC=function(models, alpha, con_sets, p,xnames=NULL,color="lightblue"){
  predictors=1:p
  if (is.null(xnames))xnames=as.character(predictors)
  result=list()
  for (i in 1:length(alpha)){
  bmatrix=t(sapply(con_sets[[i]], function(x)predictors %in%
                     (models[[x]])))
  result[[i]]=bmatrix
  row.names(bmatrix)=as.character(1:nrow(bmatrix))
  tittle=paste(paste(100*(1-alpha[i]),"%",sep=""),"MCS")
  plot(bmatrix, col=c("white",color),main = tittle,key=NULL,
       xlab="predictors", ylab="Models")
  axis(1,at=predictors,labels = xnames)
  }
  return(result)
}
