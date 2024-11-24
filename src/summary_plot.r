library("plotly")
datu <- read.csv("H:\\Desktop\\Internship, Algorithmic bioinformatics\\practice\\plot.csv")
datu
library(plotly)
library(htmlwidgets)
##########################################################
datu$Sample <- gsub("^\\$", "", datu$Sample)

# make data linear
row1 <- datu[17, ]
row2 <- datu[18, ]
row3 <- datu[20, ]
row4 <- datu[21, ]

datu[18, ] <- row1
datu[17, ] <- row2
datu[21, ] <- row3
datu[20, ] <- row4

# CHANGE ALL _CHM VALUES
datu[datu$Sample == "M_D_KF_010" & datu$File == "bowtiedict.txt_chm.rds", "Value"] <- 7
datu[datu$Sample == "M_D_PF_009a" & datu$File == "bowtiedict.txt_chm.rds", "Value"] <- 5
datu[datu$Sample == "M_D_PF_011a" & datu$File == "bowtiedict.txt_chm.rds", "Value"] <- 3

datu[datu$Sample == "M_D_KF_010" & datu$File == "star1.txt.chm.rds", "Value"] <- 300
datu[datu$Sample == "M_D_PF_009a" & datu$File == "star1.txt.chm.rds", "Value"] <- 1680
datu[datu$Sample == "M_D_PF_011a" & datu$File == "star1.txt.chm.rds", "Value"] <- 210

datu[datu$Sample == "M_D_KF_010" & datu$File == "VG.txt_chm.rds", "Value"] <- 57
datu[datu$Sample == "M_D_PF_009a" & datu$File == "VG.txt_chm.rds", "Value"] <- 60
datu[datu$Sample == "M_D_PF_011a" & datu$File == "VG.txt_chm.rds", "Value"] <- 74


datu
# Separate datasets based on File names
startvalue <- subset(datu, File == "startvalue.rds")

star1 <- subset(datu, File == "star1.txt.rds")
star1_chm <- subset(datu, File == "star1.txt.chm.rds")

bowtiedict <- subset(datu, File == "bowtiedict.txt.rds")
bowtiedict_chm <- subset(datu, File == "bowtiedict.txt_chm.rds")

vg <- subset(datu, File == "VG.txt.rds")
vg_chm <- subset(datu, File == "VG.txt_chm.rds")

sortmerna <- subset(datu, File == "sortmerna.txt.rds")
sortmerna_chm <- subset(datu, File == "sortmerna.txt.rds")




# Create new columns for differences
star1$Value <- startvalue$Value - star1$Value
star1_chm$Value <- startvalue$Value - star1_chm$Value

bowtiedict$Value <- star1$Value - bowtiedict$Value
bowtiedict_chm$Value <- star1_chm$Value - bowtiedict_chm$Value


vg$Value <- bowtiedict$Value - vg$Value
vg_chm$Value <- bowtiedict_chm$Value - vg_chm$Value


sortmerna$Value <- vg$Value - sortmerna$Value
sortmerna_chm$Value <- vg_chm$Value - sortmerna_chm$Value


# rbind
plot_data <- rbind(startvalue, star1, star1_chm, bowtiedict, bowtiedict_chm, vg, vg_chm, sortmerna, sortmerna_chm)

# Define File levels in the correct ordet
plot_data$File <- factor(plot_data$File, levels = c(
    "startvalue.rds",
    "star1.txt.rds", "star1.txt.chm.rds",
    "bowtiedict.txt.rds", "bowtiedict.txt_chm.rds",
    "VG.txt.rds", "VG.txt_chm.rds",
    "sortmerna.txt.rds"
))

fig <- plot_ly(
    data = plot_data,
    x = ~File,
    y = ~Value,
    color = ~Sample,
    type = "scatter",
    mode = "markers+lines"
)

fig <- fig %>%
    layout(
        title = "Metatranscriptome Pipeline Filter Overview",
        xaxis = list(title = "Filter Step"),
        yaxis = list(title = "Number of Reads"),
        legend = list(title = list(text = "Sample"))
    )

fig

htmlwidgets::saveWidget(fig, file = "summary_plotneu.html")


readRDS("/homes/mkumar/practice/report_test_files/startvalue.rds")
readRDS("/homes/mkumar/practice/report_test_files/star1.txt.rds")
readRDS("/homes/mkumar/practice/report_test_files/VG.txt.rds")
