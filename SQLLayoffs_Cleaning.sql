-- Reviewing Table Contents

Select *
From world_layoffs..layoffs_raw

-- Making a copy of the raw data

Select *
	Into layoffs
	From layoffs_raw

-- Remove duplicates 

With duplicate_cte As 
(
Select *,
	ROW_NUMBER() OVER (
	Partition by company,
				 location,
	             industry, 
				 total_laid_off, 
				 percentage_laid_off,
				 date,
				 stage,
				 country,
				 funds_raised_millions
				 Order by 
					company
					) As row_num
From layoffs
)
--Select *
--From duplicate_cte
--Where row_num > 1

Delete
From duplicate_cte
Where row_num > 1

-- Cleaning data entries for consistency

Select company, TRIM(company)
From world_layoffs..layoffs

UPDATE world_layoffs..layoffs
Set company = TRIM(company)

Select DISTINCT industry
From world_layoffs..layoffs
Order by 1

Select *
From world_layoffs..layoffs
Where industry Like 'Crypto%'

UPDATE world_layoffs..layoffs
Set industry = 'Crypto'
Where industry Like 'Crypto%'

Select DISTINCT country
From world_layoffs..layoffs
Order by 1

Select DISTINCT country, TRIM(TRAILING '.' FROM country)
From world_layoffs..layoffs
Order by 1

UPDATE world_layoffs..layoffs
Set country = TRIM(TRAILING '.' FROM country)
Where country Like 'United States%'

Select date, CONVERT(date, date)
From world_layoffs..layoffs

Alter Table world_layoffs..layoffs
Add NewDate Date;

Update world_layoffs..layoffs
Set NewDate = CONVERT(date, date)

-- Addressing null/blank values

Select *
From world_layoffs..layoffs
Where total_laid_off Is Null

Select *
From world_layoffs..layoffs
Where industry Is Null

Select *
From world_layoffs..layoffs l1
Join world_layoffs..layoffs l2
	On l1.company = l2.company
Where l1.industry Is Null
And l2.industry Is Not Null

UPDATE l1
Set l1.industry = l2.industry
From world_layoffs..layoffs l1
Join world_layoffs..layoffs l2
	On l1.company = l2.company
Where l1.industry Is Null
And l2.industry Is Not Null

-- Removing unnecessary rows/columns 

Select *
From world_layoffs..layoffs
Where total_laid_off Is Null
And percentage_laid_off Is Null

Delete 
From world_layoffs..layoffs
Where total_laid_off Is Null
And percentage_laid_off Is Null

Select * 
From world_layoffs..layoffs

Alter Table world_layoffs..layoffs
Drop Column date