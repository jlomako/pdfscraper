# gets content from pdf, extracts data to saves to csv file
# gets Occupancy rates in Montreal emergency rooms

# packages:
library(tidyverse)
library(pdftools)

# get file directly
url <- "https://www.msss.gouv.qc.ca/professionnels/statistiques/documents/urgences/Rap_Quotid_SituatUrgence1.pdf"

# use local copy for now:
# url <- "pdf/Rap_Quotid_SituatUrgence1.pdf"

# read pdf
text_pdf <- pdf_text(url) 

# read page 7 of pdf file (montreal)
text_pdf <- text_pdf[[7]] 

# get rows from pdf
by_row_pdf <- str_split(text_pdf, pattern = "\n")

# get date and time
update <- by_row_pdf[[1]][4]
update1 <- by_row_pdf[[1]][53]

# OBS! last line contains number! replace number in row 42: 
by_row_pdf[[1]][42] <- str_replace(by_row_pdf[[1]][42], "\\(06\\) ", "")

# extract line by line 14:42
rows <- by_row_pdf[[1]][14:42]
df <- data.frame(matrix(ncol = 45, nrow = 0)) # create empty data frame with 45 columns 
row_counter = 1 # row counter = needed for writing rows to data frame 
for (j in 1:length(rows)) {
  x <- rows[j]
  # if line start with m/M or d/D: name = ""
  if (str_detect(x, "^m") || str_detect(x, "^M")  || str_detect(x, "^d") || str_detect(x, "^D")) { 
    name = "" 
    # else if line shorter than 50 characters: name = x
  } else if (nchar(x) < 50) {
    name <- x
    # else start string processing (= getting name and numbers)
  } else {
    y <- str_extract_all(x, boundary("word"))[[1]] # separate strings into single word elements
    for (i in 1:length(y)){ # concatenate list elements to one string
      name <- paste(name, y[i])
      # print(name)
    }
    name <- name
    name <- str_trim(name, side = "left") # remove white space on left side
    nice_string <- str_replace_all(name, "N D", "99999") # replace missings "N D" with 99999
    # split at first whitespace \\s followed by "(?=" number [0-9]: 
    name <- str_split(nice_string, "\\s(?=[0-9])", 2)[[1]][1] # get hospital name
    numbers <- str_split(nice_string, "\\s(?=[0-9])", 2)[[1]][2] # get numbers
    numbers <- str_replace_all(numbers, "99999", "NA") # replace 9999 with NA
    numbers <- str_replace_all(numbers, " ", ",") # replace whitespace with comma
    # write row with name and 44 numbers to data frame
    df[row_counter,] <- data.frame(name, str_split_fixed(numbers, pattern = ",", 44)) 
    # set variables for next loop
    row_counter <- row_counter + 1
    name = ""
  }
}

write.csv(df, file = "data/test.csv", row.names = FALSE)

# to do: rename/ reshape columns etc
