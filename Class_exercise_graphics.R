
#Loading library



# Preparing data set
rairuoho <- read.table ('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/rairuoho.txt', header = TRUE)


#Ex 4.1
# Grapth showing the relationship between the length of the plant at day3 and the length at day7
ratio<-rairuoho$day3/rairuoho$day7  # ratio between the length of petal and the width of ratio * 20 Sepal
colrairuoho<-as.numeric(as.factor(colnames(rairuoho[c(1,5)])))
plot(day7 ~ day3, dat = rairuoho,
     xlab = 'Length at day 3 (cm)', 
     ylab = 'Length at day 7 (cm)', 
     xlim = c(60,130),
     main = 'Relationship between length of plant at day 3 and day 7',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5,
     pch = 19, las=1, cex= 1, 
     col = levels(as.factor(scales::alpha ((colrairuoho), 0.4))))


legend(x="topright", pch= 19, cex=1.0, legend= c("Day3","Day7"), col=levels(as.factor(scales::alpha(colrairuoho, 0.4))))

# preparing histogram
hist(rairuoho$day7, xlab = "Length at day 7", main = NA)

#preparing density plot
dens <- density(rairuoho$day7, bw = 3)
plot(dens, main = "Density distribution of the length at day 7")

#preparing qqnorm
qqnorm(rairuoho$day7)
qqline(rairuoho$day7)


# preparing boxplot
rairuoho_treat<- as.factor(rairuoho$treatment)
boxplot(rairuoho$day7 ~ rairuoho_treat, xlab = 'Treatment', ylab = 'Length at day 7')

# preparing pairs
pairs(rairuoho[1:6], pch=19, col = scales::alpha(colrairuoho, 0.4))

#Tuning scatterplot
pdf (file = 'scatterplot_R10H44002.pdf', width = 6, height = 6,)

colrairuoho<-as.numeric(as.factor(colnames(rairuoho[c(1,5)])))
par(bg="#FCE8C5", mar=c(4,4,4,4), pch = 19, las=1, cex=1.2, cex.main=1.2, cex.axis=1,cex.lab=1)
y.rng <- range( c(rairuoho$day7, rairuoho$day7) , na.rm = TRUE) 
x.rng <- range( c(rairuoho$day3, rairuoho$day3) , na.rm = TRUE) 

plot(day7 ~ day3, dat = rairuoho,
     xlab = 'Length at day 3 (cm)', 
     ylab = 'Length at day 7 (cm)', 
     xlim = x.rng,
     ylim = y.rng,
     main = 'Relationship between length of plant at \n day 3 and day 7',
     cex.axis=1.0, cex.lab=1.5, cex.main=1,
     pch = 19, las=1, cex= 1, 
     col = levels(as.factor(scales::alpha ((colrairuoho), 0.4))))
    dev.off()