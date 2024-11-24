args <- commandArgs(trailingOnly = TRUE)

input_files <- args[1:length(args) - 1]
output_file <- args[length(args)]

combine <- list()

for (input in input_files) {
    data <- readRDS(input)

    file_name <- basename(input)

    # Adjust the data processing to avoid NA coercion errors
    file_data <- sapply(names(data), function(name) {
        value <- data[[name]]
        if (is.numeric(value)) {
            paste(name, value, sep = ": ")
        } else {
            paste(name, as.character(value), sep = ": ")
        }
    })

    combine[[file_name]] <- file_data
}

# Combine the data into a data frame
df <- do.call(rbind, lapply(names(combine), function(file) {
    data <- combine[[file]]
    # Convert to data frame for easier manipulation
    data.frame(
        File = file,
        Sample = names(data),
        Value = sapply(data, function(x) sub(".*: ", "", x)) # Extract value from "name: value"
    )
}))

# Save the combined data as a CSV file
write.csv(df, file = paste0(output_file, ".csv"), row.names = FALSE)

# Also save as RDS and HTML if necessary
saveRDS(df, file = paste0(output_file, ".rds"))

library("htmltools")
html_content <- htmltools::tagList(pre(paste(capture.output(print(df)), collapse = "\n")))
save_html(html_content, file = paste0(output_file, ".html"))



# main <- writeLines(sapply(names(combine), function(name) {
#    paste(name, paste(combine[[name]], collapse = "\n"), sep = "\n")
# }), output_file)

# yup <- saveRDS(combine, file = paste0(output_file, ".rds"))


## ploting file is different(summary_plot.r) as plotly didnt got installed
