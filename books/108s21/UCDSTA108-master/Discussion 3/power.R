alpha=0.05
n=25
delta= abs((1-0)/0.5)
#two-sided (same with B.5)
critical.value=qt(p=1-alpha/2, df=n-2)
power= pt(q=critical.value, df=n-2, ncp=delta, lower.tail = FALSE)+
  pt(q=-critical.value, df=n-2, ncp=delta)
power

#one-sided
critical.value=qt(p=1-alpha, df=n-2)
power= pt(q=critical.value, df=n-2, ncp=delta, lower.tail = FALSE)
power





