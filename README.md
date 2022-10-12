# pdfscraper
* pdfscraper that extracts table from pdf and saves data to csv 
* runs every day around 1pm local time 
* currently runs as backup in case data collection for
<a href = "https://jlomako.shinyapps.io/occupancy_app/">hospital tracker</a>
fails
<br><br>

[![pdfscraper](https://github.com/jlomako/pdfscraper/actions/workflows/main.yml/badge.svg)](https://github.com/jlomako/pdfscraper/actions/workflows/main.yml)
<br><br>


### note to myself about some problems I ran into:
* loading R package "pdftools" resulted in errors -->
 <a href="https://github.com/r-lib/actions/issues/78#issuecomment-611733294">solution</a>: use runner "macos-10.15" and install XQuartz before pdftools is installed: Add <code>run: brew install xquartz --cask</code> to yml file<br>
* GH stopped supporting macos-10.15 this summer (2022), runs on macos-11 now
* ggplot stopped working and has been de-activated until i find a solution
* created new yml file with v2, yml needs renv.lock file in directory to load packages (still runs on macos-11, ubuntu not working)
* ggplot2 should work again
