31/4*(37-25) 
3^2
sqrt(36)
log(4)
cos(6)


## ------------------------------------------------------------------------
x = 6
x <- 5
5 -> x


## ------------------------------------------------------------------------
x+3
x^2
sqrt(x)
y = x^2


## ------------------------------------------------------------------------
x = 10
x = x+1


## ------------------------------------------------------------------------
# Create a vector
c(1,3,2,4)
# Save the vector as 'x'
x = c(1,3,2,4)

# R applies functions to every element of a vector
x - 10
x^2


## ------------------------------------------------------------------------
mean(x) # mean
sd(x) # standard deviation
var(x) # variance
summary(x)
sum(x) # sum of all elements
prod(x) # product of all elements
1*3*2*4
length(x) # number of elements

x[1:3] # the first three elements
x[3]

## ------------------------------------------------------------------------
patients101 = read.csv("~/books/108winter2020/Discussion/Discussion 1/patients101.csv")


## ------------------------------------------------------------------------
setwd("~/books/108winter2020/Discussion/Discussion 1")#set working directory
patients101 = read.csv("patients101.csv")#read the data set in the folder


## ------------------------------------------------------------------------
head(patients101)#Display the first six rows
patients101[1:6,]#Display the first six rows by row index
Y = patients101$sysBP # Extract variables from dataset
Y = patients101[,3] # or Extract variables by column index
patients101[1,3]#Display the value is row 1 and column 3


## ------------------------------------------------------------------------
# histograms
hist(Y) 
hist(Y, xlab = 'sysBP', ylab = 'frequency', main = 'Histogram of sysBP')

# boxplots
boxplot(Y, main = 'Boxplot of sysBP')

# scatterplots
X1 = patients101$weight
plot(X1, Y, xlab = 'weight', ylab = 'sysBP', main = 'Plot of weight versus sysBP')

