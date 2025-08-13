rm(list = ls())
library(ggplot2)
library(dplyr) 


set.seed(123)  # For reproducibility
link="https://github.com/Magallanes-at-UTDT/dataViz_2025/raw/refs/heads/main/fragility_total_change2023_2006.csv"
fragility_data =read.csv(link)

bar1var=fragility_data %>%
    count(change_category, name = "count") %>%
    mutate(percent = sprintf("(%.1f%%)", count/sum(count)*100)) %>%
    ggplot(aes(x = change_category, y = count)) +
    geom_col(fill = "skyblue") +  # geom_col() is alias for geom_bar(stat="identity")
    geom_text(
        aes(label = paste(count, percent)),  # "Count (XX.X%)"
        vjust = -0.5,  # Position above bars
        size = 5.5
    ) +
    labs(x = NULL, y = NULL) +  # Removes axis titles
    theme(
        panel.grid = element_blank(),  # Remove all grid lines
        axis.line.x = element_line(),  # Keep only x-axis line
        axis.text.y = element_blank(), # Hide y-axis text
        axis.ticks.y = element_blank(), # Hide y-axis ticks
        panel.background = element_rect(fill = "white")  # Pure white background
    ) 

bar1var

saveRDS(bar1var, file = "bar1var.rds")

###
library(ggwordcloud)
cloud1var=ggplot(
    fragility_data,
    aes(
        label = country_plot, 
        size = NumericSize,
        color = change_level  # Color by group
    )
) +
    geom_text_wordcloud_area(          # Uses size to scale words
        eccentricity = 1,                # Roundness (1 = circle)
        shape = "square"                 # Try "diamond", "triangle", etc.
    ) +
    scale_size_area(max_size = 15) +   # Adjust max word size
    
    # scale_color_steps2(low = "firebrick", mid = "grey90", high = "steelblue",
    #               midpoint = 3) +
    scale_color_steps2(low = "darkorchid", mid = "grey90", high = "darkorange",
                       midpoint = 3)+
    theme_minimal() #+                  # Clean background
# labs(title = "Country Word Cloud (Colored by Group)") +
# theme(plot.title = element_text(hjust = 0.5, face = "bold"))
cloud1var

saveRDS(cloud1var, file = "cloud1var.rds")
