import pandas as pd
import pdfplumber

# extract table
with pdfplumber.open('Rap_Quotid_SituatUrgence1.pdf') as pdf:
  # extract only page 6 (montreal)
  page = pdf.pages[6].extract_table()

# transform to df
df = pd.DataFrame(page[4:25])

# remove all \n in strings and replace N/D with NA
df[0] = df[0].str.replace('\n', ' ')
df = df.replace('N/D', 'NA')

# replace string in last row Total (06) Montréal with Total Montréal
df.iloc[20,0] = 'Total Montréal'

# write df to table_all.csv
df.to_csv("data/table_all.csv", header=True, na_rep='NA', index=False)

# select first and last 7 columns = taux d'occupation % 7 derniers jours
df = pd.concat([df.iloc[:,0],df.iloc[:,-7::]],axis=1)

# replace column names by dates
for i in range(0,7):
  day = pd.Timestamp.today() - pd.Timedelta(days=i)
  # print(day.strftime('%Y-%m-%d'))
  j = 44-i
  # rename columns
  df.rename(columns={j: day.strftime('%Y-%m-%d')}, inplace=True)

# melt table into new column 'Date' (value_vars) and vales to 'value', column 0 (id_vars) is kept as is
df = pd.melt(df, id_vars = [df.columns[0]], value_vars = df.columns[1:], var_name = 'Date', value_name='value')

# reshape with date as index and hospital names as columns
df = df.pivot(index='Date', columns=df.columns[0], values='value')

# write df to table_all.csv
df.to_csv("data/last7days.csv", header=True, na_rep='NA')

# write today's occupation to file
row = df.iloc[[6]]
# row.columns
row = row.reindex(columns=["Institut universitaire de santé mentale de Montréal","Hôpital Maisonneuve-Rosemont","Hôpital Santa Cabrini","Hôpital Fleury","Hôpital du Sacré-Coeur de Montréal","Hôpital Jean-Talon","Pavillon Albert-Prévost","Centre hospitalier de l'université de Montréal","Hôpital Royal Victoria","Hôpital général de Montréal","Hôpital de Montréal pour enfants","Campus Lachine","Hôpital général juif Sir Mortimer B. Davis","Hôpital de Verdun","Hôpital Notre-Dame","Centre hospitalier de St. Mary","Hôpital de La Salle","Hôpital général du Lakeshore","Institut de Cardiologie de Montréal","CHU Sainte-Justine","Total Montréal"])

# write row to file - append
row.to_csv("data/daily_data.csv", header=False, mode="a",  na_rep='NA')
