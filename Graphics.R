# 2016-09-28 version

### R code from vignette source 'GraphicsR.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: GraphicsR.Rnw:32-33
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: setup (eval = FALSE)
###################################################
## install.packages("lattice",dependencies=TRUE)
## install.packages("ggplot2",dependencies=TRUE)


###################################################
### code chunk number 3: data
###################################################
library(lattice)
library(ggplot2)
data(diamonds)
?diamonds
attach(diamonds)


###################################################
### code chunk number 4: scatterplot
###################################################
plot(price~carat)
plot(x*y*z~carat)
xyplot(price~carat)
xyplot(x*y*z~carat)
qplot(price,carat)
qplot(x*y*z,carat)


###################################################
### code chunk number 5: grouped_scatterplots
###################################################
xyplot(price~carat| clarity)
ggplot(diamonds, aes(carat,price)) + facet_grid(.~clarity) + geom_point()


###################################################
### code chunk number 6: barplot_graphics
###################################################
barplot(table(cut))
barplot(table(clarity))
barplot(table(clarity,cut),beside=TRUE)


###################################################
### code chunk number 7: barchart_lattice
###################################################
barchart(table(cut))
barchart(table(clarity), horizontal=FALSE)
barchart(table(clarity,cut),horizontal=FALSE, stack=FALSE)


###################################################
### code chunk number 8: barchart_using_ggplot
###################################################
ggplot(diamonds, aes(cut) )+ geom_bar(position="stack") 
ggplot(diamonds, aes(clarity) )+ geom_bar(position="stack") 
ggplot(diamonds, aes(clarity)) + facet_grid(.~cut) + geom_bar(position="dodge")


###################################################
### code chunk number 9: groups parameter
###################################################
xyplot(price~carat, groups=cut)
xyplot(price~carat | cut + clarity)
xyplot(price~carat | cut , groups=clarity, auto.key=list(space="right"))


###################################################
### code chunk number 10: store and modify lattice object
###################################################
diamondgraph<-xyplot(price~carat | cut)
update(diamondgraph, aspect="fill", layout=c(1,5))
update(diamondgraph, panel=panel.barchart)
update(diamondgraph, col="tomato") 


###################################################
### code chunk number 11: shingles
###################################################
diamonds$shingle <- equal.count(price, number=5, overlap=0)
xyplot(carat~depth | diamonds$shingle)
xyplot(carat~depth | diamonds$shingle, strip=strip.custom(strip.levels=TRUE, strip.names=FALSE))


###################################################
### code chunk number 12: 3-D_scatterplots
###################################################
library(scatterplot3d)
scatterplot3d(price,carat,table)
cloud(price~carat*table)
cloud(price~carat*table | clarity)
cloud(price~carat*table | clarity, screen=list(z=-60,x=-60))


###################################################
### code chunk number 13: playwith (eval = FALSE)
###################################################
## install.packages("playwith",dependencies=TRUE)
## library(playwith)
## playwith(cloud(price~carat*table))


###################################################
### code chunk number 14: scatterplot_tweaks
###################################################
plot(price~carat, col="steelblue", pch=3, main="Diamond Data", xlab="weight of diamond in carats", 
	ylab="price of diamond in dollars", xlim=c(0,3))


###################################################
### code chunk number 15: scatterplot_tweaks_in_lattice
###################################################
xyplot(price~carat, col="steelblue", pch=3, main="Diamond Data", xlab="weight of diamond in carats", 
	ylab="price of diamond in dollars", xlim=c(0,3), scales=list(tick.number=10))


###################################################
### code chunk number 16: scatterplot_tweaks_in_ggplot2
###################################################
ggplot(diamonds, aes(carat,price)) + xlim(0,3) + geom_point(colour="steelblue", pch=3) + 
	labs(x="weight of diamond in carats", y="price of diamond in dollars", title="Diamond Data") 


###################################################
### code chunk number 17: PDF
###################################################
pdf(file="output.pdf")
qplot(price,carat)
barchart(table(clarity,cut),horizontal=FALSE, stack=FALSE)
dev.off()


###################################################
### code chunk number 18: regression_line
###################################################
plot(price~carat)
abline(lm(price~carat), col="red")


###################################################
### code chunk number 19: regression_lattice
###################################################
print(xyplot(price~carat, type=c("p","r")))


###################################################
### code chunk number 20: regression_ggplot2
###################################################
print(ggplot(diamonds, aes(carat, price)) + geom_point() + geom_smooth(method=lm))


###################################################
### code chunk number 21: plot_entire_dataset (eval = FALSE)
###################################################
## plot(diamonds)


###################################################
### code chunk number 22: splom (eval = FALSE)
###################################################
## splom(diamonds, groups=clarity)


###################################################
### code chunk number 23: hexbin
###################################################
library(hexbin)
plot(hexbin(price,carat))


###################################################
### code chunk number 24: show_settings
###################################################
show.settings()


###################################################
### code chunk number 25: colors (eval = FALSE)
###################################################
## colors()


###################################################
### code chunk number 26: modifying settings in lattice
###################################################
mytheme<-trellis.par.get("plot.line")
mytheme$col="tomato"
trellis.par.set("plot.line",mytheme) 
print(xyplot(price~carat, type=c("p","r")))


###################################################
### code chunk number 27: googleVis (eval = FALSE)
###################################################
## #install.packages("googleVis", dependencies=TRUE) 
## library(googleVis)
## Geo=gvisGeoMap(Population, locationvar="Country", numvar="Population", options=list(height=350, dataMode='regions'))
## plot(Geo)
## input=read.csv("http://www.rci.rutgers.edu/~rwomack/Rexamples/UNdata.csv",header=TRUE) 
## Map<- data.frame(input$Country.or.Area, input$Value) 
## names(Map)<- c("Country", "Age") 
## Geo=gvisGeoMap(Map, locationvar="Country", numvar="Age", options=list(height=350, dataMode='regions')) 
## plot(Geo)
## #motion charts 
## M <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year") 
## plot(M)


###################################################
### code chunk number 28: chloropleth map
###################################################
download.file("http://www.census.gov/popest/data/national/totals/2012/files/NST_EST2012_ALLDATA.csv", "census.csv")
statepopdata <- read.csv("census.csv")  
popnames = as.character(statepopdata$Name) 
pop2010 = statepopdata$CENSUS2010POP 
popdich = ifelse(pop2010 < 3000000, "red", "blue") 
library(maps) 
library(mapproj) 
data(state) 
mapnames = map("state", plot=FALSE)$names 
mapnames.state = ifelse(regexpr(":",mapnames) < 0, mapnames, substr(mapnames, 1, regexpr(":",mapnames)-1)) 
popnames.lower = tolower(popnames) 
cols= popdich[match(mapnames.state,popnames.lower)] 
map("state",fill=TRUE,col=cols,proj="albers",param=c(35,50)) 
title("48 States by population")


###################################################
### code chunk number 29: map
###################################################
library("lattice")
library("maps")
county.map <- map("county", plot = FALSE, fill = TRUE)
data(ancestry, package = "latticeExtra")
ancestry <- subset(ancestry, !duplicated(county))
rownames(ancestry) <- ancestry$county 
freq <- table(ancestry$top)
keep <- names(freq)[freq > 10] 
ancestry$mode <- with(ancestry, factor(ifelse(top %in% keep, top, "Other"))) 
modal.ancestry <- ancestry[county.map$names, "mode"] 
library("RColorBrewer") 
colors <- brewer.pal(n = nlevels(ancestry$mode), name = "Pastel1")
xyplot(y ~ x, county.map, aspect = "iso", scales = list(draw = FALSE), xlab = "", ylab = "", par.settings = list(axis.line = list(col = "transparent")), col = colors[modal.ancestry], border = NA, panel = panel.polygon, key = list(text = list(levels(modal.ancestry), adj = 1), rectangles = list(col = colors), x = 1, y = 0, corner = c(1, 0))) 


###################################################
### code chunk number 30: map2
###################################################
rad <- function(x) { pi * x / 180 } 
county.map$xx <- with(county.map, cos(rad(x)) * cos(rad(y)))
county.map$yy <- with(county.map, sin(rad(x)) * cos(rad(y))) 

county.map$zz <- with(county.map, sin(rad(y))) 
panel.3dpoly <- function (x, y, z, rot.mat = diag(4), distance, ...)
{
m <- ltransform3dto3d(rbind(x, y, z), rot.mat, distance)
panel.polygon(x = m[1, ], y = m[2, ], ...)
 }
aspect <- with(county.map, c(diff(range(yy, na.rm = TRUE)), diff(range(zz, na.rm = TRUE))) / diff(range(xx, na.rm = TRUE)))
cloud(zz ~ xx * yy, county.map, par.box = list(col = "grey"), aspect = aspect, panel.aspect = 0.6, lwd = 0.01, panel.3d.cloud = panel.3dpoly, col = colors[modal.ancestry], screen = list(z = 10, x = -30), key = list(text = list(levels(modal.ancestry), adj = 1), rectangles = list(col = colors), space = "top", columns = 4), scales = list(draw = FALSE), zoom = 1.1, xlab = "", ylab = "", zlab = "")


###################################################
### code chunk number 31: map3
###################################################
library("latticeExtra")
library("mapproj")
data(USCancerRates)
rng <- with(USCancerRates, range(rate.male, rate.female, finite = TRUE)) 
nbreaks <- 50 
breaks <- exp(do.breaks(log(rng), nbreaks)) 
mapplot(rownames(USCancerRates) ~ rate.male + rate.female, data = USCancerRates, breaks = breaks, map = map("county", plot = FALSE, fill = TRUE, projection = "tetra"), scales = list(draw = FALSE), xlab = "", main = "Average yearly deaths due to cancer per 100000") 


