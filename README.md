A bot that extracts a table from a pdf file, processes the data and saves everything to a csv file. It runs every day around noon local time. Currently, it runs as backup in case data collection for <a href = "https://github.com/jlomako/hospital-occupancy-tracker">hospital-occupancy-tracker</a>
fails.

<br>

[![pdfscraper_py](https://github.com/jlomako/pdfscraper/actions/workflows/pdfscraper_py.yml/badge.svg)](https://github.com/jlomako/pdfscraper/actions/workflows/pdfscraper_py.yml)
<br><br>


### note to myself about some problems I ran into:
* loading R package "pdftools" resulted in errors -->
 <a href="https://github.com/r-lib/actions/issues/78#issuecomment-611733294">solution</a>: use runner "macos-10.15" and install XQuartz before pdftools is installed: Add <code>run: brew install xquartz --cask</code> to yml file<br>
* GH stopped supporting macos-10.15 this summer (2022), runs on macos-11 now
* ggplot stopped working and has been de-activated until I find a solution
* created new yml file that loads packages from renv.lock (still runs on macos-11, ubuntu not working)
* rewrote everything in python, bot runs on ubuntu now and is much faster
