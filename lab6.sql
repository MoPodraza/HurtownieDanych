USE AdventureWorksDW2019;

--Zad1
WITH sales_amount AS (
	SELECT SUM(SalesAmount) AS DailySalesAmount, OrderDate
	FROM dbo.FactInternetSales
	GROUP BY OrderDate
)

SELECT DailySalesAmount, OrderDate, 
AVG(DailySalesAmount) OVER
	(ORDER BY OrderDate ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS moving_average
FROM sales_amount
ORDER BY OrderDate


--Zad2
SELECT month_of_year,
	[0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]
FROM 
	(SELECT SalesTerritoryKey, SalesAmount, month([OrderDate]) as month_of_year
	FROM FactInternetSales
	WHERE year(OrderDate) = 2011
) AS MainTable
PIVOT (
 SUM(SalesAmount) FOR SalesTerritoryKey IN ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10])
) AS PivotTable
ORDER BY month_of_year;


--Zad3
SELECT OrganizationKey, DepartmentGroupKey, SUM(Amount) AS amount 
FROM FactFinance
GROUP BY ROLLUP(OrganizationKey, DepartmentGroupKey)
ORDER BY OrganizationKey


--Zad4
SELECT OrganizationKey, DepartmentGroupKey, SUM(Amount) AS amount 
FROM FactFinance
GROUP BY CUBE(OrganizationKey, DepartmentGroupKey)
ORDER BY OrganizationKey


--Zad5
--procentowa ranga sumarycznej sprzeda¿y danej organizacji w 2012
SELECT t1.amount, t1.OrganizationKey, t1.percent_rank, t2.OrganizationName 
FROM
	(SELECT SUM(Amount) AS amount, 
			OrganizationKey,
			PERCENT_RANK() OVER (ORDER BY SUM(Amount)) AS percent_rank
	FROM FactFinance
	WHERE YEAR(Date) = 2012
	GROUP BY OrganizationKey) t1 
JOIN
	(SELECT OrganizationKey, OrganizationName 
	FROM DimOrganization) t2
ON t1.OrganizationKey = t2.OrganizationKey


--Zad6
SELECT t1.amount, t1.OrganizationKey, t1.percent_rank, t1.std_dev, t2.OrganizationName 
FROM
	(SELECT SUM(Amount) AS amount, 
			OrganizationKey,
			PERCENT_RANK() OVER (ORDER BY SUM(Amount)) AS percent_rank,
			STDEV(SUM(Amount)) OVER (ORDER BY SUM(Amount)) AS std_dev
	FROM FactFinance
	WHERE YEAR(Date) = 2012
	GROUP BY OrganizationKey) t1 
JOIN
	(SELECT OrganizationKey, OrganizationName 
	FROM DimOrganization) t2
ON t1.OrganizationKey = t2.OrganizationKey
