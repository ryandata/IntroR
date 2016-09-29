# 2016-09-28 version

### R code from vignette source 'DataManipulationR.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: DataManipulationR.Rnw:30-31
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: install packages (eval = FALSE)
###################################################
## install.packages("Hmisc", dependencies=TRUE)
## install.packages("reshape", dependencies=TRUE)
## install.packages("reshape2",dependencies=TRUE)
## install.packages("foreign",dependencies=TRUE)
## install.packages("gdata", dependencies=TRUE)
## install.packages("xlsx", dependencies=TRUE)
## install.packages("readxl", dependencies=TRUE)
## install.packages("tidyr", dependencies=TRUE)
## install.packages("lubridate", dependencies=TRUE)
## install.packages("plyr", dependencies=TRUE)
## install.packages("dplyr", dependencies=TRUE)
## update.packages()


###################################################
### code chunk number 3: scan (eval = FALSE)
###################################################
## coffee<-scan(what="numeric")


###################################################
### code chunk number 4: read.table
###################################################
importdata<-read.table("http://ryanwomack.com/data/myfile.txt")


###################################################
### code chunk number 5: read.table parameters (eval = FALSE)
###################################################
importdata2<-read.table("http://ryanwomack.com/data/myfile2.txt", header=TRUE, sep=";",row.names="id", na.strings="..", stringsAsFactors=FALSE)


###################################################
### code chunk number 6: foreign (eval = FALSE)
###################################################
library(foreign)
download.file("http://ryanwomack.com/data/mydata.xpt", "mydata.xpt", mode="wb")
importdata3 <- read.xport ("mydata.xpt")
importdata4 <- read.spss ("http://ryanwomack.com/data/mydata.sav")
detach(package:foreign)


###################################################
### code chunk number 7: Excel files (eval = FALSE)
###################################################
library(gdata)
importdata5 <- read.xls ("http://ryanwomack.com/data/mydata.xlsx", 1)
importdata6 <- read.xls ("http://ryanwomack.com/data/mydata.xls", 1)
detach(package:gdata)

# using xlsx package - 32 bit R easier to get started with
# cannot read from http connection
download.file("http://ryanwomack.com/data/mydata.xls", "mydata.xls", mode='wb')
library(xlsx)
importdata7 <- read.xlsx ("mydata.xls", 1)

# Hadley Wickham's readxl is new, requires no external dependencies on Linux, Mac, Windows
# cannot read from http connection
library(readxl)
importdata8 <- read_excel ("mydata.xls", 1)



###################################################
### code chunk number 8: apply
###################################################
mymatrix <- cbind(c(22,33,44,55,66,77,88),c(303,322,33,11,393,220,100),c(4,3,5,2,6,2,5))
apply(mymatrix, 1, max)
apply(mymatrix, 2, mean)
apply(mymatrix, 1:2, sqrt)


###################################################
### code chunk number 9: lapply
###################################################
my_lapply_matrix<-lapply(mymatrix, sqrt)
head(my_lapply_matrix)


###################################################
### code chunk number 10: sapply
###################################################
my_sapply_matrix<-sapply(mymatrix, sqrt)
my_sapply_matrix


###################################################
### code chunk number 11: replicate
###################################################
replicate(6, sample(1:100,10))


###################################################
### code chunk number 12: rapply (eval = FALSE)
###################################################
rapply(as.list(mymatrix), sqrt, how="list")
rapply(as.list(mymatrix), sqrt, how="unlist")
rapply(as.list(mymatrix), sqrt, how="replace")
rapply(importdata, sqrt, how="replace", classes="integer")


###################################################
### code chunk number 13: tapply
###################################################
tapply(importdata$age, importdata$sex, mean)


###################################################
### code chunk number 14: if then
###################################################
if(mean(importdata$age)>30) "these people are old" else "these people are young"
ifelse((importdata$age)>30, "old", "young")


###################################################
### code chunk number 15: loops
###################################################
i <- 1
repeat {if (i > 10) break else {print(i); i <- i + 1;}}

i<-2
while (i <= 256) {print(i); i <- i *2}

for (i in seq(1:10))
{
sq<-i*i
if(sq>70) next
print(i*i)
}


###################################################
### code chunk number 16: Import Gender Statistics
###################################################
download.file("http://databank.worldbank.org/data/download/Gender_Stats_csv.zip","Gender.zip")
unzip("Gender.zip")
#change name..
genderstats<-read.csv("GenderStat_Data.csv")
head(genderstats)


###################################################
### code chunk number 17: Import Millenium Development Indicators
###################################################
download.file("http://databank.worldbank.org/data/download/MDG_csv.zip","MDG.zip")
unzip("MDG.zip")
#change name...
MDstats<-read.csv("MDG_Data.csv")

head(MDstats)

#change names - this step is not necessary in the current iteration of the data
library(reshape)
# myChanges<-c(?..Country.Name="Country.Name")
# genderstats<-rename(genderstats,myChanges)
# MDstats<-rename(MDstats,myChanges)

###################################################
### code chunk number 18: Inspect
###################################################
mode(genderstats)
class(genderstats) 
mode(MDstats)
class(MDstats)


###################################################
### code chunk number 19: Select Rows and Columns
###################################################
tinymatrix<-MDstats[1:10,1:10]
print(tinymatrix)


###################################################
### code chunk number 20: Examine Variable Names
###################################################
names(genderstats)
names(MDstats)


###################################################
### code chunk number 21: Levels
###################################################
table(genderstats$Country.Name)
table(MDstats$Country.Name)
levels(genderstats$Country.Name)
levels(MDstats$Country.Name)


###################################################
### code chunk number 22: Select Countries
###################################################
gscountry<-subset(genderstats, Country.Name=="China" | Country.Name=="India" | Country.Name=="United States")
MDcountry<-subset(MDstats, Country.Name=="China" | Country.Name=="India" | Country.Name=="United States")
table(gscountry$Country.Name)
table(MDcountry$Country.Name)

# dplyr - filter
# filter in dplyr is easy...
# this is a great tutorial
# http://rpubs.com/justmarkham/dplyr-tutorial
# https://github.com/justmarkham/dplyr-tutorial

library(dplyr)
gscountry <- filter(genderstats, Country.Name=="China" | Country.Name=="India" | Country.Name=="United States")
MDcountry<- filter(MDstats, Country.Name %in% c("China", "India", "United States"))


###################################################
### code chunk number 23: Check row.names
###################################################
row.names(genderstats)
row.names(gscountry)
row.names(MDstats)
row.names(MDcountry)


###################################################
### code chunk number 24: Select Variables from MDI
###################################################
myMDI<-subset(MDcountry, Indicator.Name=="Mobile cellular subscriptions (per 100 people)" | Indicator.Name=="Internet users (per 100 people)", select=c(Country.Name,Indicator.Name,X2000:X2008))
myMDI

#dplyr approach with chaining
myMDI <- MDcountry %>%
  filter (Indicator.Name %in% c("Mobile cellular subscriptions (per 100 people)", "Internet users (per 100 people)")) 
myMDI <- myMDI %>%  
  select(Country.Name, Indicator.Name, starts_with("X20"))

# see
# https://www.r-bloggers.com/the-complete-catalog-of-argument-variations-of-select-in-dplyr/

###################################################
### code chunk number 25: Select Variables from Gender
###################################################
mygender<-subset(gscountry, Indicator.Name=="Adolescent fertility rate (births per 1,000 women ages 15-19)" | Indicator.Name=="Fertility rate, total (births per woman)", select=c(Country.Name,Indicator.Name,X2000:X2008))
mygender

#dplyr approach with chaining
mygender <- gscountry %>%
  filter (Indicator.Name %in% c("Adolescent fertility rate (births per 1,000 women ages 15-19)", "Fertility rate, total (births per woman)")) 
mygender <- mygender %>%  
  select(Country.Name, Indicator.Name, starts_with("X20"))

###################################################
### code chunk number 26: rbind
###################################################
names(mygender)<-c("Country.Name","Indicator.Name","X2000","X2001","X2002","X2003","X2004","X2005","X2006","X2007","X2008")
names(mygender)
mydata<-rbind(myMDI,mygender)
head(mydata)


###################################################
### code chunk number 27: modifying variable names
###################################################
# this bit of code no longer applies to the changed data
# but is a useful function nevertheless
# library(reshape)
# myChanges<-c(Country.Name="Country_Name",Indicator.Name="Indicator_Name")
# mygender<-rename(mygender,myChanges)
# names(mygender)
# detach(package:reshape)

# in dplyr renaming is easy with the rename command
# it only affects selected variables
# note that the first element is the "new" name, and the second is the old
# this function does NOT take the assignment operator

rename(mygender, Nation = Country.Name)

#let's change that back for consistency with the rest of the code

rename(mygender, Country.Name = Nation)





###################################################
### code chunk number 28: merge
###################################################
mydata<-merge(mygender,myMDI,all=TRUE)
mydata

# dplyr supports database-style join operations (inner, outer, left, right, full)
# the dplyr equivalent is 

mydata2 <- full_join(mygender,myMDI)

# the tidyr package can also be used for data manipulation operations
# see
# https://rpubs.com/bradleyboehmke/data_wrangling
# https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

###################################################
### code chunk number 29: split
###################################################
mysplit<-split(mydata,mydata$Country.Name, drop=TRUE)
mysplit$China


###################################################
### code chunk number 30: relabeling
###################################################
mydata$Indicator.Name<-as.character(mydata$Indicator.Name)
changes<-grep("Adolescent",mydata$Indicator.Name)
mydata$Indicator.Name[changes]="adfert"
changes<-grep("Fertility",mydata$Indicator.Name)
mydata$Indicator.Name[changes]="totfert"
changes<-grep("Internet",mydata$Indicator.Name)
mydata$Indicator.Name[changes]="Internet"
changes<-grep("Mobile",mydata$Indicator.Name)
mydata$Indicator.Name[changes]="Mobile"
mydata$Indicator.Name


###################################################
### code chunk number 31: create a vector
###################################################
years<-paste("X",2000:2014, sep="")
years


###################################################
### code chunk number 32: reshape
###################################################
library(reshape)
mylongdata<-reshape(mydata, varying=years, direction="long", sep="")
mylongdata



###################################################
### code chunk number 33: melt and cast
###################################################
mymelt<-melt(mydata, id=c("Country.Name","Indicator.Name"))
mymelt$variable<-as.numeric(sub("X","",mymelt$variable))
names(mymelt)[3]<-"year"
head(mymelt)
mycast<-cast(mymelt,year+Country.Name~Indicator.Name)
head(mycast)

# some other useful dplyr functions

# summarise (British spelling preferred)

mycast %>%
  group_by(Country.Name) %>%
  summarise(avg_internet = mean(Internet, na.rm=TRUE))

# arrange (replaces sort/order functions in base R)

  arrange(mycast, desc(Internet))

# mutate (used to create new variables)
# must explicitly declare assignment to permanently store new variable

mycast <- 
mycast %>%
  select(Country.Name, year, Internet,totfert) %>%
  mutate(InternetFertilityRatio = Internet/totfert)


  arrange(mycast, InternetFertilityRatio)

###################################################
### code chunk number 34: examining the data
###################################################
str(mydata)
str(mylongdata)
str(mycast)


###################################################
### code chunk number 35: export formats for mydata
###################################################
write.csv(mydata,"mydata.csv")
library(foreign)
write.foreign(mydata, datafile="mydata.sav", codefile="mydata.sps", package="SPSS")


###################################################
### code chunk number 36: export formats for mycast
###################################################
write.csv(mycast,"mycast.csv")
library(foreign)
write.foreign(mycast, datafile="mycast.sav", codefile="mycast.sps", package="SPSS")


###################################################
### code chunk number 37: save
###################################################
save.image("mydata.RData")


###################################################
### code chunk number 38: bigmemory (eval = FALSE)
###################################################
install.packages("bigmemory",dependencies=TRUE) 
install.packages("biganalytics",dependencies=TRUE) 
library(bigmemory) 
library(biganalytics) 
# link for browser download
# https://drive.google.com/file/d/0B2zjf-zkx_lGTEduOVdub25tZG8/view?usp=sharing
# save as 2008.csv
myMatrix<-read.big.matrix("2008.csv", type="integer", header=TRUE) 
object.size(myMatrix)
# for comparison
object.size(genderstats)
summary(myMatrix) 
myRegression <- biglm.big.matrix(ArrDelay~Distance, data=myMatrix) 
summary(myRegression) 


###################################################
### code chunk number 39: Databases (eval = FALSE)
###################################################
install.packages("RMySQL",dependencies=TRUE) 
install.packages("DBI",dependencies=TRUE) 
library(RMySQL) 
library(DBI) 

# we connect to the publicly available genome server at genome.ucsc.edu
# see that site for documentation of tables and schema

con = dbConnect(MySQL(), host="genome-mysql.cse.ucsc.edu", user="genome", dbname="hg19") 
knownGene = dbReadTable (con, 'knownGene') 
head(knownGene) 
table(knownGene$chrom) 
sort(table(knownGene$chrom), decreasing=TRUE) 

proteins = dbGetQuery(con, "SELECT * FROM knownGene WHERE proteinID='O95872'") 
proteins
proteins[order(proteins$exonEnds, decreasing=TRUE), ]
dbDisconnect(con)

# connecting to databases is easy and transparent in dplyr
# see http://cran.r-project.org/web/packages/dplyr/vignettes/databases.html

# once the connection is made, we can operate on a remote database as if it is loaded in R

my_db <- src_mysql(dbname="hg19", host="genome-mysql.cse.ucsc.edu", user="genome")

my_db %>% tbl("knownGene") %>% head(5)

my_db %>% 
arrange(knownGene, desc(chrom))

knownGenesql<-tbl(my_db, "knownGene")

my_db %>% tbl("knownGene")
  filter(proteinID, c("095872"))
