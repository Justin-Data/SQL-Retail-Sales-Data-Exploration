/*

Retail Sales Data Exploration

Utilized Aggregate Functions, Joins, Window Functions

*/

SELECT *
FROM Orders;



--- 1) What is the total sales, orders and items sold per year?

SELECT YEAR(Order_Date) as Year,
	SUM(Sales) as Sales,
	COUNT(DISTINCT OrderID) as Orders,
	SUM(Quantity) as Items_Sold
FROM Orders
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date);



--- 2) What is the average transaction value per year?

SELECT YEAR(Order_Date) as Year,
	SUM(Sales)/COUNT(DISTINCT OrderID) as Avg_Transaction_Value
FROM Orders
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date);



--- 3) How does the average units per transaction (UPT) vary based on the month?

SELECT MONTH(Order_Date) as Month,
	SUM(Quantity)/COUNT(DISTINCT OrderID) as Avg_Basket_Size
FROM Orders
GROUP BY MONTH(Order_Date)
ORDER BY MONTH(Order_Date);



--- 4) How many order returns were there each year?

SELECT YEAR(orders.order_date) as Year,
	COUNT(DISTINCT Orders.OrderID) as Total_returns
FROM Orders
INNER JOIN shipping
	ON Orders.OrderID=shipping.OrderID
WHERE shipping.Returned = 'Yes'
GROUP BY YEAR(orders.order_date)
ORDER BY YEAR(Order_Date);



--- 5) What is the year-over-year growth (YOY) for total sales?

SELECT YEAR(Order_Date) as Year,
	SUM(Sales) as Sales,
	SUM(SALES) - LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date)) as Yearly_Growth
FROM Orders
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date);



--- 6) What is the monthly sales and orders for each each year?
--- November and December appear to have the most sales and orders each year

SELECT YEAR(Order_Date) as Year,
	MONTH(Order_Date) as Month,
	SUM(Sales) as Sales,
	COUNT(DISTINCT OrderID) as Orders
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY YEAR(Order_Date), MONTH(Order_Date);



--- 6b) Which type of products were sold the most during this period (November & December)?

SELECT Category,
	SUM(Quantity) as Items_sold
FROM Orders
WHERE MONTH(Order_Date) IN (11, 12)
GROUP BY Category
ORDER BY 2 DESC;



--- 7) What are the top 10 selling products?

SELECT TOP 10 Sub_Category,
	SUM(Quantity) AS Items_Sold
FROM Orders
GROUP BY Sub_Category
ORDER BY SUM(Quantity) DESC;



--- 8) Which category performed the best in regards to sales for 2017?

SELECT Category,
	SUM(Sales) as Sales
FROM Orders
WHERE YEAR(Order_Date) = 2017
GROUP BY Category
ORDER BY SUM(Sales) DESC;



--- 9) How is the total items sold distributed across the customer base?

SELECT Segment,
	SUM(Quantity) as Items_Sold
FROM Orders
GROUP BY Segment
ORDER BY SUM(Quantity) DESC;



--- 10) What is the total sales per region?

SELECT Region,
	SUM(Sales) as Sales
FROM Orders
GROUP BY Region
ORDER BY SUM(Sales) DESC;



--- 11) What is the breakdown of sales and orders by state

SELECT State,
	SUM(SALES) as Sales,
	COUNT(DISTINCT OrderID) as Orders,
	SUM(Quantity) as Items_Sold
FROM orders
GROUP BY State
ORDER BY 2 DESC;