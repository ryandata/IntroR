# 2016-09-28 version

### R code from vignette source 'StatisticalFunctionsR.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: StatisticalFunctionsR.Rnw:30-31
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: getwd()
###################################################
getwd()


###################################################
### code chunk number 3: getwd
###################################################
getwd


###################################################
### code chunk number 4: Getwd (eval = FALSE)
###################################################
## Getwd()


###################################################
### code chunk number 5: Comment (eval = FALSE)
###################################################
## # this is a comment


###################################################
### code chunk number 6: setwd (eval = FALSE)
###################################################
## setwd("pathname")


###################################################
### code chunk number 7: install packages (eval = FALSE)
###################################################
## install.packages("ISwR", dependencies=TRUE)
## install.packages("Rcmdr", dependencies=TRUE)
## update.packages()


###################################################
### code chunk number 8: package loading
###################################################
library()
library("ISwR")
search()


###################################################
### code chunk number 9: save and load
###################################################
save.image("mydata.RData")
load("mydata.RData")


###################################################
### code chunk number 10: create data frame
###################################################
testdata <- data.frame()
testdata


###################################################
### code chunk number 11: print table
###################################################
sex<-c("M","F","M","F","M","F","M","F","M","F")
age<-c(22,35,43,52,58,23,36,46,39,31)
testdata<-data.frame(cbind(sex,age))
testdata


###################################################
### code chunk number 12: coffee
###################################################
coffee=c(3,1,2,5,0,2,0,1,3,2)
coffee


###################################################
### code chunk number 13: checking the characteristics
###################################################
mode(coffee)
mode(testdata)
mode(testdata$age)
mode(testdata$sex)
class(coffee)
class(testdata)
class(testdata$age)
class(testdata$sex)


###################################################
### code chunk number 14: as.numeric
###################################################
as.numeric(testdata$sex)


###################################################
### code chunk number 15: factor
###################################################
testdata$sex<-factor(testdata$sex, labels=c("Female", "Male"))
testdata$sex


###################################################
### code chunk number 16: cbind
###################################################
testdata<-cbind(testdata,coffee)
testdata


###################################################
### code chunk number 17: summary and table
###################################################
ls()
summary(testdata)
rm(list = ls())


###################################################
### code chunk number 18: loading data
###################################################
library("ISwR")
?ISwR
data()
library(help=ISwR)


###################################################
### code chunk number 19: 2+2
###################################################
2+2


###################################################
### code chunk number 20: 2+2 is 5
###################################################
funkyadd<-function(x,y)
{
x+y+1
}
funkyadd(2,2)


###################################################
### code chunk number 21: samples and distributions
###################################################
sample(1:100,10)
rnorm(10)
rnorm(10, mean=100, sd=20)


###################################################
### code chunk number 22: load data and summarize
###################################################
data(cystfibr)
?cystfibr
summary(cystfibr)


###################################################
### code chunk number 23: attaching a dataset
###################################################
mean(cystfibr$age)
# this generates an error
# mean(age)
attach(cystfibr)
mean(age)


###################################################
### code chunk number 24: descriptive statistics
###################################################
sd(age)
var(age)
median(age)
quantile(age)
summary(age)


###################################################
### code chunk number 25: histogram
###################################################
hist(age)


###################################################
### code chunk number 26: by
###################################################
by(cystfibr, cystfibr["sex"],summary)


###################################################
### code chunk number 27: table
###################################################
table(sex)
table(age,sex)


###################################################
### code chunk number 28: table continued (eval = FALSE)
###################################################
## table(height,age,sex)
## ftable(height,age,sex)


###################################################
### code chunk number 29: xtabs
###################################################
xtabs(~ age + sex, data=cystfibr)


###################################################
### code chunk number 30: t test
###################################################
t.test(pemax)
mean(pemax)
t.test(pemax, mu=100)


###################################################
### code chunk number 31: t test
###################################################
t.test(pemax, mu=90, conf.level=.99)


###################################################
### code chunk number 32: 2 sample t test
###################################################
t.test(pemax~sex)


###################################################
### code chunk number 33: chisquare
###################################################
ageheight<-table(age,height)
chisq.test(ageheight)


###################################################
### code chunk number 34: linear regression
###################################################
lm(pemax~tlc)


###################################################
### code chunk number 35: linear regression
###################################################
summary(lm(pemax~tlc))
regoutput<-lm(pemax~tlc)
names(regoutput)
regoutput$residuals


###################################################
### code chunk number 36: regression through the origin
###################################################
lm(pemax~ tlc -1)


###################################################
### code chunk number 37: predict
###################################################
predict(regoutput)


###################################################
### code chunk number 38: anova
###################################################
anova(regoutput)


###################################################
### code chunk number 39: correlation
###################################################
cor(height,weight)
cor.test(height,weight)


###################################################
### code chunk number 40: plot
###################################################
plot(regoutput, pch=3)


###################################################
### code chunk number 41: multiple regression
###################################################
lm(pemax ~ tlc + age + sex)
summary(lm(pemax ~ tlc + age + sex))


