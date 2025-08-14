rm(list = ls())
setwd("~/Documents/GITHUBs/UBA/DataViz/R_codes_forDashboard")
set.seed(123)  # For reproducibility

###
library(ggplot2)
library(ggrepel)

###
link1="https://github.com/magallanes-at-UBA/DataViz/raw/main/"
link2="fromPython/fragilityGrowthVariability_HumRts.csv"


volave =read.csv(paste0(link1,link2))

names(volave)

###
ggplot(data=volave) + geom_point(aes(x=fragility.Growth_HumanRights,y=fragility.Volatility_HumanRights))

###
ggplot(data=volave) + geom_point(aes(x=fragility.Growth_HumanRights,y=fragility.Volatility_HumanRights,color=region))

###
ggplot(data=volave) + geom_point(aes(x=fragility.Growth_HumanRights,y=fragility.Volatility_HumanRights)) + facet_wrap(~region)

###
table(volave$region)
americas=c('South America','Central America and the Caribbean','North America')

ggplot(data=volave[volave$region %in% americas,],aes(x=fragility.Growth_HumanRights,y=fragility.Volatility_HumanRights)) +
    geom_text(aes(label=country,color=region)) + theme(legend.position = "bottom")

###
ggplot(data=volave[volave$region %in% americas,],aes(x=fragility.Growth_HumanRights,y=fragility.Volatility_HumanRights)) +
    geom_text(aes(label=country),size=2) + facet_grid(region~.)

####
bivar_americas=ggplot(data=volave[volave$region %in% americas,],aes(x=fragility.Growth_HumanRights,y=fragility.Volatility_HumanRights)) + theme_light()+
    geom_label_repel(aes(label=country,color=region)) + theme(legend.position = "bottom") +
    geom_vline(xintercept = 0, color='grey') + scale_y_log10()
bivar_americas

###
farlands=c('South America','East and Southeast Asia')
bivar_farlands=ggplot(data=volave[volave$region %in% farlands,],aes(x=fragility.Growth_HumanRights,y=fragility.Volatility_HumanRights)) + theme_light()+
    geom_label_repel(aes(label=country,color=region,size=2),max.overlaps=20) + theme(legend.position = "bottom") +
    geom_vline(xintercept = 0, color='grey') + scale_y_log10()

bivar_farlands

####
saveRDS(bivar_americas,"dashboards/bivar_americas.rds")
saveRDS(bivar_farlands,"dashboards/bivar_farlands.rds")
