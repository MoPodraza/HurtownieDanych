use lab1;

--zad1
with temp as (
SELECT od.order_id, 
	   SUM(p.price) price_sum
	FROM [lab1].[dbo].[order_details] od
	JOIN pizzas p on p.pizza_id=od.pizza_id
	JOIN orders o on o.order_id=od.order_id
	WHERE o.date='2015-02-18'
	GROUP BY od.order_id, o.date
)

SELECT AVG(price_sum) average_price
FROM temp;

--zad2
with temp as (
SELECT od.order_id, 
	   string_agg(pt.ingredients,',') ingredients
	FROM order_details od 
	JOIN orders o ON od.order_id = o.order_id
	JOIN pizzas p ON od.pizza_id = p.pizza_id 
	JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
	WHERE o.date LIKE '2015-03-%'
	GROUP BY od.order_id
)

SELECT COUNT(order_id)
FROM temp 
WHERE ingredients NOT LIKE '%Pineapple%';

--zad3
SELECT TOP 10 od.order_id, 
	   sum(p.price * od.quantity) order_price
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
WHERE o.date like '%-02-%'
GROUP BY od.order_id
ORDER BY order_price desc

SELECT TOP 10 od.order_id, 
	   sum(p.price * od.quantity) order_price, 
	   rank() over(ORDER BY SUM(p.price * od.quantity) desc) ranking
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
WHERE o.date LIKE '%-02-%'
GROUP BY od.order_id;

--zad4
with order_prices as (
SELECT od.order_id, 
	   SUM(p.price * od.quantity) order_amount, 
	   date, 
	   month(o.date) date_month 
	FROM order_details od
	JOIN orders o ON od.order_id = o.order_id
	JOIN pizzas p ON od.pizza_id = p.pizza_id
	GROUP BY od.order_id, date
),

average_order_price as (
SELECT AVG(order_amount) average_month_order, 
	  date_month month
	FROM order_prices 
	GROUP BY date_month
)

SELECT od.order_id, 
       od.order_amount, 
	   average_month_order, 
	   date
FROM order_prices od
JOIN average_order_price ON od.date_month = average_order_price.month;

--zad5
SELECT COUNT(order_id) order_count, 
	   date, 
	   DATEPART(hh, time) order_hour 
FROM orders o
WHERE o.date = '2015-01-01' 
GROUP BY DATEPART(hh, time), date;

--zad6
SELECT SUM(od.quantity) amount_sold, 
	   pt.category, 
	   pt.name from order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE o.date LIKE '2015-01-%'
GROUP By pt.name, pt.category

--zad7
SELECT COUNT(od.quantity), 
	  size
FROM pizzas p 
JOIN order_details od ON p.pizza_id = od.pizza_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.date BETWEEN '2015-02-01' AND '2015-03-31'
GROUP BY p.size