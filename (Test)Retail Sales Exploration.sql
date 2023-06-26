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

--- 3) What is the average amount of items per transaction each year?

SELECT YEAR(Order_Date) as Year,
	SUM(Quantity)/COUNT(DISTINCT OrderID) as Avg_Basket_Size
FROM Orders
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date);

--- 4) How is the total sales distributed by category?

SELECT Category,
	SUM(Sales) as Sales
FROM Orders
GROUP BY Category
ORDER BY SUM(Sales) DESC;

--- 5) How many order returns were there per year?

SELECT YEAR(orders.order_date) as Year,
	COUNT(DISTINCT Orders.OrderID) as Total_returns
FROM Orders
INNER JOIN shipping ON Orders.OrderID=shipping.OrderID
WHERE shipping.Returned = 'Yes'
GROUP BY YEAR(orders.order_date)
ORDER BY YEAR(Order_Date);


--- 5) Which category has the highest return rate?
		--- (Total Returns / Items Sold) * 100 ---
--- Temp test

--- 6) What are the top selling products?

SELECT TOP 10 Sub_Category,
	SUM(Sales) AS Sales
FROM Orders
GROUP BY Sub_Category
ORDER BY SUM(Sales) DESC;

--- 7) What is the year-over-year growth (YOY) for total sales?

SELECT YEAR(Order_Date) as Year,
	SUM(Sales) as Sales,
	SUM(SALES) - LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date)) as Yearly_Growth
FROM Orders
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date);



--- 8) What is the monthly sales and orders for each year?
--- November and December appear to have the most sales and orders each year

SELECT YEAR(Order_Date) as Year,
	MONTH(Order_Date) as Month,
	SUM(Sales) as Sales,
	COUNT(DISTINCT OrderID) as Orders
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY YEAR(Order_Date), MONTH(Order_Date);

--- 8b) Which products are sold the most during this period?

SELECT Sub_Category,
	SUM(Quantity) as Items_sold
FROM Orders
WHERE MONTH(Order_Date) IN (11, 12)
GROUP BY Sub_Category
ORDER BY 2 DESC;

--- 9) What is the customer segmentation based on sales?

SELECT Segment,
	SUM(Sales) as Sales
FROM Orders
GROUP BY Segment
ORDER BY SUM(Sales) DESC;

--- 10) How are sales distributed among each region?

SELECT Region,
	SUM(Sales) as Sales
FROM Orders
GROUP BY Region
ORDER BY SUM(Sales) DESC;
