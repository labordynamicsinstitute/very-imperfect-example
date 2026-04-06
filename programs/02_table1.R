## This file creates Table 1 in the paper.
## Author: Ariel Ortiz-Bobea

## paths
data_path    <- "C:/Users/Ariel/Desktop/pumsak.dta"
results_path <- "C:/Users/Ariel/Desktop/text"

df <- read_dta(data_path)

## table with appropriate weights
df$specific_ak_lab <- factor(
  df$specific_ak,
  levels = c(0, 1),
  labels = c("Not identified",
             "Identified with one of the four tribes")
)

df_valid <- df[!is.na(df$pweight_num), ]

freq <- tapply(as.integer(df_valid$pweight_num), df_valid$specific_ak_lab, sum)
pct  <- prop.table(freq) * 100

table1 <- data.frame(
  Category  = names(freq),
  Frequency = as.integer(freq),
  Percent   = round(pct, 2)
)

print(table1, row.names = FALSE)

## output the table to latex
xtab <- xtable(
  table1,
  caption  = "Frequency of tribal identification, 2000 Census PUMS (Alaska)",
  label    = "tab:freq_specific_ak",
  digits   = c(0, 0, 0, 2)
)

print(xtab,
      file              = file.path(results_path, "freq_specific_ak.tex"),
      include.rownames  = FALSE,
      booktabs          = TRUE,
      caption.placement = "top")
