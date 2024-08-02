------------------------------------------------------------------------- KPIs ---------------------------------------------------------------------------------------

-- 1. Total Revenue: The sum of the total price of all pizza orders.
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

-- 2. Average order value: the average amount spent per order, calculated by dividing the total revenue by the total number of orders.

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_order_value
FROM pizza_sales

-- 3. Total pizza sold; the sum of the quantities of all pizza sold.
SELECT SUM(quantity) AS Total_pizza_sold
FROM pizza_sales

-- 4. Total order; we have to take a count of the whole oders made.

SELECT COUNT(DISTINCT order_id) as Total_order
FROM pizza_sales

-- 5. Average Pizza per order; The average number of pizza sold per order, calculated by diving the total number of pizzas sold by orders.
SELECT CAST(CAST(SUM(quantity) AS decimal(10, 2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS DECIMAL(10, 2)) AS Avg_pizzas_per_order
FROM pizza_sales

---------------------------------------------------------------------------- PROBLEM STATEMENT----------------------------------------------------------------------
-- CHARTS REQUIREMENT

-- 1. Daily trend for Total Orders: create a bar chart that displays the daily trend of total orders throughout the day. this chart will help us identify any patterns or fluctuations in order volumes on a daily basis.

SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- 2. Monthly Trend for Total Orders

SELECT DATENAME(MONTH, order_date) AS Month_name, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC

-- 3. Percentage of Sales by pizza category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS Percentage_sale
FROM pizza_sales
GROUP BY pizza_category
ORDER BY SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)

-- 4. percentage of sales by pizza size.
SELECT pizza_size, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS Percentage_sale
FROM pizza_sales
GROUP BY pizza_size
ORDER BY SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)

-- 5. Total Pizza Sold By pizza category.
SELECT pizza_category, SUM(total_price) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category

-- 6. Top 5 best sellers by revenue, total quantity and total orders
SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue, SUM(quantity) AS total_quantity, COUNT(DISTINCT order_id) total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC


--7. Bottom 5 best sellers by revenue, total quantity and total orders

SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue, SUM(quantity) AS total_quantity, COUNT(DISTINCT order_id) total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue 