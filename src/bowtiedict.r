#install.packages("evaluate")
#install.packages("knitr")
#install.packages("rmarkdown")
#install.packages("htmlwidgets")
#install.packages("plotly")
#install.packages("dplyr")

#library(plotly) ## can't use plotly, CRAN is not added, cant use sudo
#library(dplyr)

#install.packages("ggplot2") ##some problem with CRAN
#library(ggplot2)

###############################################################
args <- commandArgs(trailingOnly = TRUE)

num_ids <- (length(args) - 1) / 2
ids <- args[1:num_ids]
input_files <- args[(num_ids + 1):(length(args) - 1)]
output_file <- args[length(args)]


results <- list()

for (i in seq_along(input_files)) {
    file <-input_files[i]
    id <- ids[i]

    if (file.exists(file)) {
        # Read the file content
        data <- readLines(file)
        
        value1 <- NA  
        value2 <- NA
        value3 <- NA
        value4 <- NA
        value5 <- NA
        
        # Extract the first value
        for (line in data) {
            if (grepl("aligned concordantly exactly 1 time", line)) {
                parts1 <- unlist(strsplit(line, " "))
                if (length(parts1) >= 2) {
                    value1 <- as.numeric(parts1[5])
                    break  # Exit loop once found
                }
            }
        }

        # Extract the second value
        for (line in data) {
            if (grepl("aligned concordantly >1 times", line)) {
                parts2 <- unlist(strsplit(line, " "))
                if (length(parts2) >= 2) {
                    value2 <- as.numeric(parts2[5])
                    break  
                }
            }
        }
        
        # Extract the third value
        for (line in data) {
            if (grepl("aligned discordantly 1 time", line)) {
                parts3 <- unlist(strsplit(line, " "))
                if (length(parts3) >= 2) {
                    value3 <- as.numeric(parts3[7])
                    break  
                }
            }
        }
      
        # Extract the forth value
        for (line in data) {
            if (grepl("aligned exactly 1 time", line)) {
                parts4 <- unlist(strsplit(line, " "))
                if (length(parts4) >= 2) {
                    value4 <- as.numeric(parts4[13])
                    break  
                }
            }
        }

        # Extract the fifth value
        for (line in data) {
            if (grepl("aligned >1 times", line)) {
                parts5 <- unlist(strsplit(line, " "))
                if (length(parts5) >= 2) {
                    value5 <- as.numeric(parts5[9])
                    break  
                }
            }
        }

        # Only add to results if both values were found for multiple file practrice
        if (!is.na(value1) && !is.na(value2)&& !is.na(value3)&& !is.na(value4)&& !is.na(value5)) {
            value6 <- value1 + value2 + value3 + value4 + value5
            results[[(id)]] <- value6
        } else {
            cat("Could not extract both values from:", file, "\n")
        }
        
    } else {
        cat("File does not exist:", file, "\n")
    }
}


saveRDS(results, file = paste0(output_file, ".rds"))


writeLines(sapply(names(results), function(name) {
    paste(name, results[[name]], sep = ": ")
}), output_file)

cat("Results written to:", output_file, "\n")

results1 <- readRDS("/homes/mkumar/practice/work/36/17e2622eb600f321fc651a2c6608ce/bowtiedict.txt.rds")

results_df <- data.frame(File = names(results1), Value = unlist(results1))
print(results_df)

##plot donut
#plot <- plot_ly(results_df, 
 #                labels = ~File, 
  ##              type = 'pie', 
    #             hole = 0.4) %>%
  #layout(title = 'Values from Log Files',
   #      annotations = list(
    #       list(text = 'Value', 
     #           x = 0.5, 
      #          y = 0.5, 
       ##        showarrow = FALSE
   #      #  )
    #     )) %>%
  #config(displayModeBar = FALSE)  

#htmlwidgets::saveWidget(plot, file = "donut_plot.html")

#ggplot(results_df, aes(x = File, y = Value)) +
#  geom_bar(stat = "identity", fill = "skyblue") +
 # theme_minimal()+
  #labs(title = "Values from Log Files", x = "File", y = "Value") +
 # theme(axis.text.x = element_text(angle = 45, hjust = 1))

#ggsave("/homes/mkumar/practice/src/reslutsbowtie.png")}


