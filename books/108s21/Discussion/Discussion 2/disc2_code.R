X = c(1,0,2,0,3,1,0,1,2,0)
Y = c(16, 9, 17, 12, 22, 13, 8, 15, 19, 11)
n = length(X)

b1hat = sum((X-mean(X))*(Y-mean(Y)))/sum((X-mean(X))^2)
#same with t(X-mean(X))%*%(Y-mean(Y))/sum((X-mean(X))^2)[1]

b0hat = mean(Y) - b1hat*mean(X)
fit.y = b0hat + b1hat*X
mse = 1/(n-2)*sum((Y - fit.y)^2)
se.b1hat = sqrt(mse/sum((X-mean(X))^2))
se.b0hat = sqrt(mse*(1/n+ mean(X)^2/sum((X - mean(X))^2)))

fit = lm(Y~X)
summary(fit)

#coefficients estimated by model:
coef = fit$coefficients
b0hat = coef[1]
b1hat = coef[2]
MSE = summary(fit)$sigma^2
b0hat
b1hat
se.b0hat = summary(fit)$coefficients[1,"Std. Error"]
se.b1hat = summary(fit)$coefficients[2,"Std. Error"]

#Test statistics:
alpha = 0.01
p = 1-alpha/2
t.value = (b1hat-1)/se.b1hat
critical.value= qt(p, df = n - 2)
abs(t.value) > critical.value
#Reject H0 if get TRUE

#confidence interval
lb.b1hat = b1hat - critical.value*se.b1hat
ub.b1hat = b1hat + critical.value*se.b1hat



