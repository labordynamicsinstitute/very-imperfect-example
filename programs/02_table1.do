/* This file creates Table 1 in the paper.  */
/* Author: Lars Vilhuber */

/* paths */
global dtam  "C:\Users\Lars\Desktop\pumsak.dta"  /* Stata PUMS merged data */
global results "C:\Users\Lars\Desktop\text"        // Write tables to the LaTeX directory

clear
use  $dtam, clear  /* load merged data */
save "US Census 2000", replace

  /* table with appropriate weights */
  tab specific_ak [fweight=pweight_num]
  /* output the table to latex */
  label define spec 0  "Not identified" 1 "Identified with one of the four tribes"
  label value specific_ak spec
  latab specific_ak [fweight=pweight_num],  tf("$results/freq_specific_ak") replace dec(2)

rm "US Census 2000.dta"