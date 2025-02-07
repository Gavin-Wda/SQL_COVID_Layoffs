-- Exploratory Data Analysis 

-- General Insights 

Select *
From world_layoffs..layoffs

Select MAX(total_laid_off), MAX(percentage_laid_off)
From world_layoffs..layoffs

Select *
From world_layoffs..layoffs
Where percentage_laid_off = 1
Order by total_laid_off Desc

Select company, SUM(total_laid_off)
From world_layoffs..layoffs
Group by company
Order by 2 Desc

Select industry, SUM(total_laid_off)
From world_layoffs..layoffs
Group by industry
Order by 2 Desc

Select country, SUM(total_laid_off)
From world_layoffs..layoffs
Group by country
Order by 2 Desc

-- Reviewing layoffs by date 

Select MIN(NewDate), MAX(NewDate)
From world_layoffs..layoffs

Select YEAR(NewDate), SUM(total_laid_off)
From world_layoffs..layoffs
Group by YEAR(NewDate)
Order by 2 Desc

Select SUBSTRING(CONVERT(varchar(255), NewDate), 1, 7) As Months, SUM(total_laid_off) As laid_off
From world_layoffs..layoffs
Where NewDate Is Not Null
Group by SUBSTRING(CONVERT(varchar(255), NewDate), 1, 7)
Order by 1 Asc

With Rolling_Total As
(
Select SUBSTRING(CONVERT(varchar(255), NewDate), 1, 7) As Months, SUM(total_laid_off) As laid_off
From world_layoffs..layoffs
Where NewDate Is Not Null
Group by SUBSTRING(CONVERT(varchar(255), NewDate), 1, 7)
--Order by 1 Asc
)
Select Months, laid_off, SUM(laid_off) Over (Order by Months) As rolling_total
From Rolling_Total

-- Exploring layoffs by Company by date (Ranked)

Select company, YEAR(NewDate), SUM(total_laid_off)
From world_layoffs..layoffs
Group by company, NewDate
Order by 3 Desc

With Company_Year (Company, years, laid_off) As
(
Select company, YEAR(NewDate), SUM(total_laid_off)
From world_layoffs..layoffs
Group by company, YEAR(NewDate)
), Company_Year_Rank As
(
Select *, 
DENSE_RANK() Over (Partition by years Order by laid_off Desc) As ranking
From Company_Year
Where years Is Not Null
)
Select *
From Company_Year_Rank
Where ranking <= 5