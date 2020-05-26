library(ggplot2)
library(RobPer)
library(lomb)

setwd("/home/wattie/git_rep/time-analisis")

#data = read.table("../optical/optical.dat",header = FALSE)
#data = read.csv("../radio/mrk421.csv",header = FALSE, comment.char = "#")
#data = read.table("../x-rays/curve.dat",header = FALSE, comment.char = "#", check.names = FALSE, nrows = 160329)
#data = read.columns("../x-rays/curve.dat",header = FALSE, comment.char = "#",col.names = c("V1") nrows = 160329)
data = read.table("../gamma/mrk421.dat",header = FALSE, comment.char = "#", check.names = FALSE)



head(data)

#x-rays
#cols = paste("V", c(1,4,5), sep="")
#data <-data[, cols]


##gamma-rays

data$V2 <- data$V2*10000000
data$V3 <- data$V3*10000000



#data$V2

#newdata


#head(newdata)




#head(data$V3)

#typeof(data)

#t<-data$V1
#x<-data$V2

#data <-!is.na(data)

#t
#x
#data

#maximo_t <- max(t)
#minimo_t <- min(t)

#minimo_x <- min(x)
#maximo_x <- max(x)
#promedio <- mean(x, na.rm = TRUE)

#maximo_t
#minimo_t

#maximo_x
#minimo_x

#DataFrame
#mydataframe <- data.frame(t,x)

#mydataframe


#mydata_1$newDate <- (mydata_1$t - minimo_t+86400)/86400
#mydata_1$newDate <- (mydata_1$t)

#newdata <- data.frame(mydata_1$newDate,x)

#newdata
#names(data)[1] <- "mjd"
#names(data)[2] <- "flux"
#names(data)[3] <- "err"

#names(mydataframe)

#Curva de Luz

#plot(newdata, main="LC",xlab="MJD", ylab="flux")
#plot(data, main="LC",xlab="mjd", ylab="flux")

lapso <-400  #Es la resta del valor en MJD: (final - iicial)/10. Tal vez hay que transformarlos.
#lapso <- 1/PP_konv$freq
#lapso

#########################
####TAU
############################################################
#Cálculo RP

rp_t<- RobPer(data,model="sine", regression="tau", weighting = FALSE, var1=FALSE, periods = 1:lapso)

rp_t

#save data RP
#out_rp <- data.frame(rp_t)

#colnames(rp_t)

max(rp_t)

write.csv(rp_t, '../gamma/R/data/gamma_rpt_mrk421.csv', row.names = FALSE)


lomb <- lsp(rp_t, from = 10, to =400, type = "period",
            ofac = 1, alpha = 0.01, plot = FALSE)
lomb



saveRDS(lomb, file = "../gamma/R/data/gamma_lombValues_mrk421.rds")
#readRDS(file="../x-rays/R/data/x-rays_lombValues_mrk421.rds") 

rp_t

#lomb2 <- lsp(mydata_1, from = 30, to =40, type = "period",
#           ofac = 1, alpha = 0.01, plot = TRUE)

df_lomb <- data.frame(lomb[c("scanned","power")])

df_lomb

max(df_lomb)

#write.csv(df_lomb, '../optical/optical_lomb_mrk421.csv', row.names = FALSE)
write.csv(df_lomb, '../gamma/R/data/gamma_lomb_mrk421.csv', row.names = FALSE)


randlomb <- randlsp(repeats=100, data, from = 2, to = 400,
                    type = "period", ofac = 1, alpha = 0.1,
                    plot = FALSE)

df_rand <- data.frame(randlomb[c("scanned","power")])
write.csv(df_rand, '../gamma/R/data/gamma_rand_mrk421.csv', row.names = FALSE)

saveRDS(lomb, file = "../gamma/R/data/gamma_randlombValues_mrk421.rds")
readRDS(file="../gamma/R/data/gamma_lombValues_mrk421.rds") 

#########################################






#ValoresBeta

hist(rp_t, breaks = 50, freq = FALSE, xlim = c(0,0.08), col = "gray", main = "Histograma Tau", xlab = "Periodogram")

betavalues <- betaCvMfit(rp_t)
crit.val <- qbeta((0.95)^(1/lapso), shape1 = betavalues[1],shape2 = betavalues[2])
betafun <- function(x)dbeta(x, shape1 = betavalues[1], shape2 = betavalues[2])
curve(betafun, add = TRUE, lwd = 2)
abline(v = crit.val, lwd = 2)

par.mom <- betaCvMfit(rp_t, rob = FALSE, CvM = FALSE)
myf.mom <- function(x)  dbeta(x, shape1 = par.mom[1], shape2 = par.mom[2])
curve(myf.mom, add = TRUE, lwd = 2, lty = 2)
crit.mom <- qbeta((0.95)^(1/lapso), shape1 = par.mom[1], shape2 = par.mom[2])
abline(v = crit.mom, lwd = 2, lty =2)


par.rob <- betaCvMfit(rp_t, rob = TRUE, CvM = FALSE)
myf.rob <-function(x)dbeta(x, shape1 = par.rob[1], shape2 = par.rob[2])
curve(myf.rob, add = TRUE, lwd = 2, lty = 3)
crit.rob <- qbeta((0.95^(1/lapso)), shape1 =par.rob[1], shape2 = par.rob[2])
abline(v = crit.rob, lwd = 2, lty = 3)
legend("topright", lty = 1:3, legend = c("CvM", "Moments", "Robust moments"), bg = "white", lwd = 2)

box()

plot(rp_t, xlab = "Trial period", ylab = "periodogram", main= "Tau", type = "l")
abline(h = crit.val, lwd = 2)
abline(h = crit.mom, lwd = 2)
abline(h = crit.rob, lwd = 2)

############################################################






##HUBER
############################################################
#Cálculo RP

rp_h<- RobPer(newdata,model="sine", regression="huber", weighting = FALSE,var1=FALSE,periods = 1:lapso)

#salida <- data.frame(periods, rp)

#save data RP

#rp_data <- data.frame(salida[c("periods","rp")])
#write.csv(rp_data, '~/oj287/optico/aavso_rp.csv', row.names = FALSE)

#ValoresBeta

hist(rp_h, breaks = 50, freq = FALSE, xlim = c(0,0.05), col = "gray", main = "Histograma Huber", xlab = "Periodogram")

betavalues <- betaCvMfit(rp_h)
crit.val <- qbeta((0.95)^(1/lapso), shape1 = betavalues[1],shape2 = betavalues[2])
betafun <- function(x)dbeta(x, shape1 = betavalues[1], shape2 = betavalues[2])
curve(betafun, add = TRUE, lwd = 2)
abline(v = crit.val, lwd = 2)

par.mom <- betaCvMfit(rp_h, rob = FALSE, CvM = FALSE)
myf.mom <- function(x)  dbeta(x, shape1 = par.mom[1], shape2 = par.mom[2])
curve(myf.mom, add = TRUE, lwd = 2, lty = 2)
crit.mom <- qbeta((0.95)^(1/lapso), shape1 = par.mom[1], shape2 = par.mom[2])
abline(v = crit.mom, lwd = 2, lty =2)


par.rob <- betaCvMfit(rp_h, rob = TRUE, CvM = FALSE)
myf.rob <-function(x)dbeta(x, shape1 = par.rob[1], shape2 = par.rob[2])
curve(myf.rob, add = TRUE, lwd = 2, lty = 3)
crit.rob <- qbeta((0.95^(1/lapso)), shape1 =par.rob[1], shape2 = par.rob[2])
abline(v = crit.rob, lwd = 2, lty = 3)
legend("topright", lty = 1:3, legend = c("CvM", "Moments", "Robust moments"), bg = "white", lwd = 2)

box()

plot(rp_h, xlab = "Trial period", ylab = "periodogram", main= "Huber", type = "l")
abline(h = crit.val, lwd = 2)
abline(h = crit.mom, lwd = 2)
abline(h = crit.rob, lwd = 2)

############################################################
##L2
############################################################
rp_l2<- RobPer(newdata,model="sine", regression="L2", weighting = FALSE,var1=FALSE,periods = 1:lapso)

#ValoresBeta

hist(rp_l2, breaks = 50, freq = FALSE, xlim = c(0,0.06), col = "gray", main = "Histograma L2", xlab = "Periodogram")

betavalues <- betaCvMfit(rp_l2)
crit.val <- qbeta((0.95)^(1/lapso), shape1 = betavalues[1],shape2 = betavalues[2])
betafun <- function(x)dbeta(x, shape1 = betavalues[1], shape2 = betavalues[2])
curve(betafun, add = TRUE, lwd = 2)
abline(v = crit.val, lwd = 2)

par.mom <- betaCvMfit(rp_l2, rob = FALSE, CvM = FALSE)
myf.mom <- function(x)  dbeta(x, shape1 = par.mom[1], shape2 = par.mom[2])
curve(myf.mom, add = TRUE, lwd = 2, lty = 2)
crit.mom <- qbeta((0.95)^(1/lapso), shape1 = par.mom[1], shape2 = par.mom[2])
abline(v = crit.mom, lwd = 2, lty =2)


par.rob <- betaCvMfit(rp_l2, rob = TRUE, CvM = FALSE)
myf.rob <-function(x)dbeta(x, shape1 = par.rob[1], shape2 = par.rob[2])
curve(myf.rob, add = TRUE, lwd = 2, lty = 3)
crit.rob <- qbeta((0.95^(1/lapso)), shape1 =par.rob[1], shape2 = par.rob[2])
abline(v = crit.rob, lwd = 2, lty = 3)
legend("topright", lty = 1:3, legend = c("CvM", "Moments", "Robust moments"), bg = "white", lwd = 2)

box()

plot(rp_l2, xlab = "Trial period", ylab = "periodogram", main= "L2", type = "l")
abline(h = crit.val, lwd = 2)
abline(h = crit.mom, lwd = 2)
abline(h = crit.rob, lwd = 2)
#text(450, rp[40], "hola", pos = 3)


############################################################
#####FIN
##################


#fasefolding
plot(newdata$new_data%%47, newdata$x, main="Phase Diagram (time modulo 51)",
     xlab="Observation time modulo 51", ylab="Periodic Fluctuation")

fold_x <-newdata$new_data%%47
y <- data$flux

#fold_y <-newdata$x

folding <- data.frame(fold_x,y)

folding

#write.csv(folding, '~/frb/2018_2019_r1/data/5dias/prueba_sh/pordia/frb_fold47.csv', row.names = FALSE)

plot(folding, main="Phase Diagram (time modulo 51)",
     xlab="Observation time modulo 51", ylab="Periodic Fluctuation")

