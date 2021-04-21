#' @import rlist
#' @import BMA
#' @import plot.matrix
#' @importFrom graphics axis plot
#' @importFrom stats gaussian lm rnorm
#' @importFrom utils combn

Generate.Y <- function(predy, sigmasq, n) {
  Y = predy + rnorm(n,0, sd = sqrt(sigmasq))
  return(Y)
}


#every sublist should have same structure
flatten = function(alist,K){
  newlist=alist[[1]]
  if (K >1){
    for(j in 2:K){
      newlist=Map(rbind,newlist,alist[[j]])
    }
  }
  return(newlist)
}

matchfunc =function(a,b){
  c = all(a%in%b) & all(b%in% a)
  return(as.numeric(c))
}


#Calculate and rank the BIC values of all models
Sel = function(models,data,method= "bic", n,eps=1e-6){
  if (method=="aic")k=2
  if (method=="bic")k=log(n)
  m = length(models)
  score = rep(0,m)
  sigmasq = rep(0,m)
  betals = list()
  Y=data$y
  X=data$x
  for (i in 1 :m){
    len = length(models[[i]])
    if (len==0){
      fit=lm(Y~1)
    }else{
      Xi = X[,models[[i]]]
      fit=lm(Y~Xi)
    }
    sigmasq[i] = sum((fit$residuals - mean(fit$residuals))^2)/n
    betals[[i]]=fit$coefficients
    df = sum(abs(betals[[i]][-1])>eps)+1
    score[i] = n * log(sigmasq[i]) + k * df
  }
  result = list()
  result$rank = order(score)
  result$betals= betals
  selected = result$rank[1]
  result$index = selected
  result$hat_M = models[[selected]]
  result$predy=cbind(1,X[,result$hat_M]) %*% betals[[selected]]
  result$sigmasq=sigmasq[selected]
  return(result)
}
