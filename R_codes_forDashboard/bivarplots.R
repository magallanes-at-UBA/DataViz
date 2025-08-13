rm(list = ls())
setwd("~/Documents/GITHUBs/UBA/DataViz/R_codes_forDashboard")
set.seed(123)  # For reproducibility

###
library(ggplot2)
library(ggrepel)

###
link1="https://github.com/magallanes-at-UBA/DataViz/raw/main/"
link2="fromPython/fragilityVariabilityGrowth_2023_2006.csv"

vargrth =read.csv(paste0(link1,link2))

###
ggplot(data=vargrth) + geom_point(aes(x=p3_human_rights_growth,y=p3_human_rights_variability))

###
ggplot(data=vargrth) + geom_point(aes(x=p3_human_rights_growth,y=p3_human_rights_variability,color=region))

###
ggplot(data=vargrth) + geom_point(aes(x=p3_human_rights_growth,y=p3_human_rights_variability)) + facet_wrap(~region)

###
table(vargrth$region)
americas=c('South America','Central America and the Caribbean','North America')

ggplot(data=vargrth[vargrth$region %in% americas,],aes(x=p3_human_rights_growth,y=p3_human_rights_variability)) +
    geom_text(aes(label=country,color=region)) + theme(legend.position = "bottom")

###
ggplot(data=vargrth[vargrth$region %in% americas,],aes(x=p3_human_rights_growth,y=p3_human_rights_variability)) +
    geom_text(aes(label=country),size=2) + facet_grid(region~.)

####
bivar_americas=ggplot(data=vargrth[vargrth$region %in% americas,],aes(x=p3_human_rights_growth,y=p3_human_rights_variability)) + theme_light()+
    geom_label_repel(aes(label=country,color=region)) + theme(legend.position = "bottom") +
    geom_vline(xintercept = 0, color='grey') + scale_y_log10()
bivar_americas

###
farlands=c('South America','East and Southeast Asia')
bivar_farlands=ggplot(data=vargrth[vargrth$region %in% farlands,],aes(x=p3_human_rights_growth,y=p3_human_rights_variability)) + theme_light()+
    geom_label_repel(aes(label=country,color=region,size=2),max.overlaps=20) + theme(legend.position = "bottom") +
    geom_vline(xintercept = 0, color='grey') + scale_y_log10()

bivar_farlands

####
saveRDS(bivar_americas,"dashboards/bivar_americas.rds")
saveRDS(bivar_farlands,"dashboards/bivar_farlands.rds")
