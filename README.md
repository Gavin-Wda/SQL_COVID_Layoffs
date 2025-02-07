SQL COVID Layoffs Practice Project 

This practice project in Microsoft SQL Server reviews COVID layoffs between March of 2020 and March of 2023. It is broken into two parts. The first is data cleaning within SQL and the second is exploratory data analysis using SQL. 

Cleaning 

To start, I reviewed the data in the table and created a copy to retain the original data. From there I went about making the data suitable for EDA. I removed duplicate rows using a partition within a CTE, used CONVERT to apply the data type of ‘date’ to the date column, removed leading spaces and trailing periods using the TRIM function, and updated entries in the Industry column regarding Crypto to be uniform. Having these issues addressed, I had to fill in missing entries in the Industry column as some entries of the same company would be missing that information. This was done using an Update statement and a Join of the same table. I then removed entries that were missing both the total_laid_off and the percentage_laid_off values as they were not useful for analysis. 

EDA

In exploring the data, I began by looking into a lot of different queries with no true goal in mind. I wanted to get a better sense of the data and what it contained. These general insights ranged from total layoffs by company, country, industry to max values of total_laid_off/percentage_laid_off to entries where the company went under (percentage_laid_off = 1). Following this, I reviewed layoff volume over time. I looked at it by year and then by month. The latter required converting the date to a character data type, followed by a substring to isolate the year/month. In addition, I wanted to see the rolling total of layoffs, so I placed the query in a CTE and summed the values over the Months column. Lastly, I looked into layoffs by the companies with respect to time. In doing so I ranked the companies (top five of each year) by total_laid_off per year using another CTE with two queries. 

Note: This practice project is not a complete exploration of the data. It is as described, practice. However, it is ongoing and currently unfinished. 
