data <- readRDS("/homes/mkumar/practice/report_test_files/sortmerna.txt.rds")
data2 <- list()
key <-c("M_D_KF_010", "M_D_PF_009a", "$M_D_PF_011a")
value <- c(1234, 1235, 1236)
data2[key] <- value
data2$M_D_KF_010
library("hash")
install.packages("hash")

data3 <- hash(keys = key, values = value)
data4<-saveRDS(data3, "trial.rds")
data5<-readRDS("trial.rds")
data5

#now make start value here only
result1<- list()
key1 <- c("M_D_KF_010", "M_D_PF_009a", "$M_D_PF_011a")
value1<-c(2190380, 6915480, 1609960)
result1[key1] <- value1
saveRDS(result1, "startvalue.rds")

check<- readRDS("/homes/mkumar/practice/work/56/2c21a9ad63eb3ab3f23d929dd22425/summary_log.txt.rds")
check

check2 <- readRDS("/homes/mkumar/practice/output_dir/summary1.txt.rds")
check2$VG.txt.rds$M_D_KF_010

library("htmlwidgets")
library("htmltools")

html_content <- htmltools::tagList(pre(paste(capture.output(print(check)), collapse = "\n")))

htmltools::save_html(html_content, file = "test1234.html")
check$file_name
check$data$M_D_KF_010


#htmlwidgets::saveWidget(check, file = "test1234.html")

results_df <- data.frame(File = names(check), Value = unlist(check))
print(results_df)

df <- as.data.frame(do.call(rbind, lapply(check, as.data.frame)))

library(xtable)
    html_output <- xtable::xtable(check)
    print(html_output, type = 'html', file = 'output.html')


#######################################################################
# Step 1: Read the file line by line
file_path <- "/homes/mkumar/practice/output_dir/summary1.txt"
lines <- readLines(file_path)

# Step 2: Initialize variables to store file names and data
file_names <- c()
data_list <- list()

# Step 3: Loop through each line to extract key-value pairs
current_file <- ""
for (line in lines) {
    # Check if line contains a filename
    if (grepl(".rds", line)) {
        current_file <- sub(":.*", "", line)
        file_names <- c(file_names, current_file)
        data_list[[current_file]] <- data.frame(Sample = character(), Value = numeric(), stringsAsFactors = FALSE)
    } else if (current_file != "") {
        # Extract sample name and value from the line
        key_value <- strsplit(line, ":\\s*")[[1]]
        sample <- key_value[1]
        value <- as.numeric(key_value[2])
        # Append the data to the respective list
        data_list[[current_file]] <- rbind(data_list[[current_file]], data.frame(Sample = sample, Value = value, stringsAsFactors = FALSE))
    }
}

# Step 4: Combine all data into one data frame (optional, if you want all in one)
combined_df <- do.call(rbind, lapply(names(data_list), function(name) {
    df <- data_list[[name]]
    df$File <- name
    return(df)
}))

# Step 5: Display the combined data frame
print(combined_df)
ahaha <- write.csv(combined_df)
write.csv(combined_df, file = "plot.csv")
aha <- read.csv("plot.csv")
install.packages("plotly")
library(plotly)

fig <- plot_ly(data = ahaha, x = ~q, y = ~Petal.Length, color = ~Species)

fig