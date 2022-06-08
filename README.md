# pdfscraper
pdfscraper that extracts pdf and saves data to csv 

[![pdfscraper](https://github.com/jlomako/pdfscraper/actions/workflows/main.yml/badge.svg)](https://github.com/jlomako/pdfscraper/actions/workflows/main.yml)

<b>note to myself about some problems I ran into:</b><br>
* loading R package "pdftools" resulted in errors -->
 <a href="https://github.com/r-lib/actions/issues/78#issuecomment-611733294">solution</a>: use runner "macos-10.15" and install XQuartz before pdftools is installed: Add <code>run: brew install xquartz --cask</code> to yml file<br>
