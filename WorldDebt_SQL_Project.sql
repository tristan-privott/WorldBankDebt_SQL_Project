--View all data in the table
SELECT *
FROM World_Bank_Debt_Project.dbo.international_debt$


--Total number of countries represented in the database
--Counted both country code and name to make sure there were no discrepencies in the data
SELECT COUNT(DISTINCT country_name) AS distinct_countries, COUNT(DISTINCT country_code) as distinct_country_codes
FROM World_Bank_Debt_Project.dbo.international_debt$


--Total number of debt indicators
SELECT COUNT(DISTINCT indicator_code) AS distinct_debt_indicators
FROM World_Bank_Debt_Project.dbo.international_debt$
ORDER BY distinct_debt_indicators


--Unique debt indicators
SELECT DISTINCT indicator_code AS distinct_debt_indicators, indicator_name as distinct_debt_names
FROM World_Bank_Debt_Project.dbo.international_debt$
ORDER BY distinct_debt_indicators


--Most common debt indicator ranked from greatest to least
SELECT indicator_code, 
	COUNT(indicator_code) AS indicator_count, 
	DENSE_RANK() OVER(ORDER BY COUNT(indicator_code) DESC) as ranking
FROM World_Bank_Debt_Project.dbo.international_debt$
GROUP BY indicator_code
ORDER BY indicator_count DESC


--Convert debt to US currency to the nearest whole number
SELECT *, FORMAT(debt, 'C0') AS 'dollar_debt'	
--the 'C0' rounds the dollar amount to the nearest whole number in US dollars
FROM World_Bank_Debt_Project.dbo.international_debt$
ORDER BY debt DESC


--Min and max debt for each indicator code
SELECT DISTINCT indicator_code AS distinct_debt_indicators, 
	FORMAT(MIN(debt), 'C0') as min_debt, 
	FORMAT(MAX(debt), 'C0') as max_debt
FROM World_Bank_Debt_Project.dbo.international_debt$
GROUP BY indicator_code
ORDER BY indicator_code


--Total debt per country
SELECT country_name, 
    FORMAT(SUM(debt), 'C0') AS total_debt
FROM World_Bank_Debt_Project.dbo.international_debt$
GROUP BY country_name
ORDER BY SUM(debt) DESC


--What is the total debt owed to the World Bank between all countries?
SELECT FORMAT(SUM(debt), 'C0') AS 'world_debt_sum'
FROM World_Bank_Debt_Project.dbo.international_debt$


--List all of the debts each country owes by indicator type from greatest to least.
SELECT country_code, indicator_name, 
	FORMAT(debt, 'C0') AS 'dollar_debt'
FROM World_Bank_Debt_Project.dbo.international_debt$
WHERE country_code = 'AFG'
--substitute with any country code to see its debt breakdown
ORDER BY debt DESC