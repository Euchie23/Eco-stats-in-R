library(readr)
library(dplyr)
library (iNEXT)
library(ggplot2)
library(scales)
reef_0 <- read_csv("Documents/NTU Third Semester/Eco stats in Rproj/reef_fish.csv",show_col_types = FALSE)
reef_0 <- as.data.frame(reef_0)
reef_1 <- reef_0[,c('Realm','Taxon','Total')]



reef_2<-reef_1 %>%
  group_by(Taxon,Realm) %>%
dplyr::summarise(Total = sum(Total))



# Question: We want to know if there is any significant difference, in species total abundance, between the different realms.


reef_3 <-reef_2%>%
  group_by(Taxon, Realm) %>%
  mutate(row =row_number()) %>%
  tidyr::pivot_wider(names_from = Realm, values_from = Total) %>%
  select(-row) %>%
  replace(is.na(.), 0) %>%
  as.data.frame()

#realm.n <- as.numeric(as.factor(reef_3[ ,c(1-12)]))



# Question: We want to know if there is any significant difference, in species total abundance, between the different realms.
#real.man <- manova(cbind(Total, Taxon) ~ Realm, data = reef_1)
#summary(res.man)


reef_fish <- reef_3[,-1]
rownames(reef_fish) <- reef_3[,1] 


# calculating Hill numbers (q = 0, 1, 2) for the 11 assemblages (realms) 
m <- c(1, 25000, 50000, 100000, 150000, 200000, 250000)


# to return basic data information including the reference sample size (n), observed species richness (S.obs), sample coverage estimate for the reference sample (SC), and the first ten frequency counts (f1‐f10)
rf.raref<-iNEXT(reef_fish,q=c(0,1,2), datatype="abundance", size=m)

# Plotting the rarefaction curves

# calculating the diversity estimates for the minimum among all doubled reference sample sizes. 
rf.indi0 <- estimateD (reef_fish, data = 'abundance', base = 'size', level = NULL)
rf.indi <- rf.indi0[rf.indi0$Order.q == '0',]  # choose species richness (q = 0); the other values refer to Shannon and Simpson diversity (q = 1 and q = 2, respectively)

# Plotting the rarefaction curves
#par (mfrow = c(1,3))
plot (rf.raref, type = 1)

plot (rf.raref, type = 1)

plot (rf.raref, type = 1)

ggiNEXT(rf.raref,type = 1, facet.var="Assemblage")+ theme_grey(base_size = 10)+ theme(legend.position = "right")+ scale_x_continuous(labels = label_number(suffix = " k", scale = 1e-3))

# calculating the diversity estimates for the minimum among the coverage values for samples extrapolated to double the size of the reference sample. 
rf.cove0 <- estimateD (reef_fish, data = 'abundance', base = 'coverage', level = NULL)
rf.cove <- rf.cove0[rf.cove0$Order.q == '0',]
plot (rf.raref, type = 2)

plot (rf.raref, type = 3)
