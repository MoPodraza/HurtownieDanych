--Zad1
--Stowrzenie wymiaru daty
CREATE TABLE dbo.DimDate (
	 [DateKey] int NOT NULL,
	 [Date] DATE NOT NULL,
	 [Day] TINYINT NOT NULL,
	 [WeekOfYear] TINYINT NOT NULL,
	 [Month] TINYINT NOT NULL,
	 [Quarter] TINYINT NOT NULL,
	 [Year] INT NOT NULL
 )
DECLARE @CurrentDate DATE = '2005-01-01'
DECLARE @EndDate DATE = DATEADD(DAY, -1, DATEADD(YEAR, 10, @CurrentDate));
WHILE @CurrentDate < @EndDate
BEGIN
 INSERT INTO [dbo].[DimDate] (
 [DateKey],
 [Date],
 [Day],
 [WeekOfYear],
 [Month],
 [Quarter],
 [Year]
 )
 SELECT DateKey = YEAR(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 +
DAY(@CurrentDate),
 DATE = @CurrentDate,
 Day = DAY(@CurrentDate),
 [WeekofYear] = DATEPART(wk, @CurrentDate),
 [Month] = MONTH(@CurrentDate),
 [Quarter] = DATEPART(q, @CurrentDate),
 [Year] = YEAR(@CurrentDate)
 SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END



--Zad2
--Pozycja dostawcy w rankingu iloœci dostarczonych zamówieñ w danym roku 
WITH ranking AS (
	SELECT carrier_key, 
		YEAR(date) AS year,
		COUNT(carrier_key) AS order_count,
		RANK() OVER (PARTITION BY YEAR(date) ORDER BY COUNT(carrier_key) DESC) AS ranking
	FROM [dbo].[FactSales_table]
	GROUP BY ROLLUP(carrier_key, YEAR(date))
)

SELECT year, carrier_name, order_count, ranking
FROM ranking r
JOIN DimCarrier c
ON r.carrier_key = c.carrier_key
WHERE r.year IS NOT NULL;


-- Klient z najwiêksza wartoœci¹ zamówienia w danym stanie 

WITH temp AS (
	SELECT customer_key, SUM(amount) AS orders_amount
	FROM [dbo].[FactSales_table]
	GROUP BY customer_key
)

SELECT * FROM (
	SELECT first_name, 
		   last_name, 
		   state, 
		   orders_amount,
		   DENSE_RANK() OVER (PARTITION BY state ORDER BY orders_amount desc) order_rank
	FROM temp t
	JOIN [dbo].[DimCustomer] c
	ON t.customer_key = c.customer_key
) w 
WHERE order_rank = 1;

--Suma sprzeda¿y dla ka¿dego dnia z œredni¹ krocz¹c¹ dla danego dnia oraz trzech poprzednich
WITH temp AS(
	SELECT sum(amount) AS orders_amount, cast(date as date) as date
	FROM [dbo].[FactSales_table]
	GROUP BY cast(date as date)
)
SELECT orders_amount, 
	   date,
	   AVG(orders_amount) OVER (ORDER BY date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS srednia_kroczaca
FROM temp
ORDER BY date;

