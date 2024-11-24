#install.packages("evaluate")
#install.packages("knitr")
#install.packages("rmarkdown")
#install.packages("htmlwidgets", dependencies=T)
#install.packages("plotly")
#install.packages("dplyr")

#library(plotly) ## can't use plotly, CRAN is not added, cant use sudo
#library(dplyr)

#install.packages("ggplot2")
#library(ggplot2)

###############################################################
args <- commandArgs(trailingOnly = TRUE)

num_ids <- (length(args)-1)/2
ids <- args[1:num_ids]
input_files <- args[(num_ids+1):(length(args)-1)]
output_file <- args[length(args)]

cat("Processing input files:", input_files, "\n")
cat("Processing IDs:", ids, "\n")




results <- list()

for (i in seq_along(input_files)) {
    file <- input_files[i]
    id <- ids[i]


    if (file.exists(file)) {
        # Read the file content
        data <- readLines(file)
        
        value1 <- NA  
        value2 <- NA  
        
        # Extract the first value
        for (line in data) {
            if (grepl("Number of reads mapped to multiple loci", line)) {
                parts1 <- unlist(strsplit(line, "\t"))
                if (length(parts1) == 2) {
                    value1 <- as.numeric(parts1[2])
                    break  # Exit loop once found
                }
            }
        }

        # Extract the second value
        for (line in data) {
            if (grepl("Uniquely mapped reads number", line)) {
                parts2 <- unlist(strsplit(line, "\t"))
                if (length(parts2) == 2) {
                    value2 <- as.numeric(parts2[2])
                    break  
                }
            }
        }
        
        # Only add to results if both values were found for multiple file practrice
        if (!is.na(value1) && !is.na(value2)) {
            value3 <- value1 + value2
            results[[(id)]] <- value3
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




#results_df <- data.frame(File = names(results1), Value = unlist(results1))
#print(results_df)

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



