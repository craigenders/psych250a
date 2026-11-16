# KNIT THE DATA BLITZ EXAMPLES ----

# knits every .Rmd file in the folder that contains this script, and nothing else
# the HTML files are written to the same folder

# rmarkdown renders R Markdown files
library(rmarkdown)

# rstudioapi finds the folder that contains this script when it is run from RStudio
library(rstudioapi)

# FIND THE FOLDER ----

# use the folder of this script when run in RStudio, otherwise the current working directory
script_dir <- tryCatch(dirname(getActiveDocumentContext()$path), error = function(e) getwd())

# print the folder to confirm the location
script_dir

# KNIT EACH FILE ----

# list only the .Rmd files in this folder (not in subfolders)
rmd_files <- list.files(script_dir, pattern = "\\.Rmd$", full.names = TRUE, recursive = FALSE)

# print the files that will be knit
basename(rmd_files)

# knit each file in a fresh environment so objects from one file cannot affect another
for (f in rmd_files) {
  render(f, output_format = "html_document", output_file = xfun::with_ext(basename(f), "html"), output_dir = script_dir, envir = new.env(), quiet = TRUE)
  message("Knit: ", basename(f))
}
