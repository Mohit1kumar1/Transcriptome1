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
        
        
        # Extract the first value
        for (line in data) {
            value1 <- as.numeric(line)
            results[[id]] <- value1
            break  # Exit loop once found
        }
    }
}


saveRDS(results, file = paste0(output_file, ".rds"))


writeLines(sapply(names(results), function(name) {
    paste(name, results[[name]], sep = ": ")
}), output_file)

cat("Results written to:", output_file, "\n")