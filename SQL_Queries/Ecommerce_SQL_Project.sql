
-- DATABASE CREATION
CREATE DATABASE ecommerce_project;
USE ecommerce_project;
SELECT DATABASE();

-- Table Creation
CREATE TABLE Customers (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Segment VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Region VARCHAR(50)
);
SHOW TABLES;
DESC Customers;
SELECT COUNT(*) FROM Customers;
DROP TABLE Orders;
CREATE TABLE Orders (
    ROW_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(200),
    Sales DECIMAL(10,2),
    Profit DECIMAL(10,2)
   
);
SHOW TABLES;
DESC Orders;
SHOW CREATE TABLE Orders;

-- Data Import
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(

Order_ID,
@Order_Date,
Customer_ID,
Category,
Sub_Category,
Product_Name,
Sales,
Profit
)
SET Order_Date = STR_TO_DATE(@Order_Date,'%d-%m-%Y');
SELECT COUNT(*) FROM Orders;
-- BASIC SQL QUERIES
-- View all Orders
SELECT * FROM Orders;
-- View all Customers
SELECT * FROM Customers;
-- Total Orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;
-- Total Customers
SELECT COUNT(*) AS Total_Customers
FROM Customers;
-- Distinct Categories
SELECT DISTINCT Category
FROM Orders;
-- Distinct Regions
SELECT DISTINCT Region
FROM Customers;
-- Total Sales
SELECT SUM(Sales) AS Total_Sales
FROM Orders;
-- Total Profit
SELECT SUM(Profit) AS Total_Profit
FROM Orders;
-- Average Sales
SELECT AVG(Sales) AS Average_Sales
FROM Orders;
-- Highest Sale
SELECT MAX(Sales) AS Highest_Sale
FROM Orders;
-- Lowest Sale
SELECT MIN(Sales) AS Lowest_Sale
FROM Orders;
-- FILTERING & SORTING QUERIES
-- Orders with sales greater than 1000
SELECT * 
FROM Orders WHERE Sales > 1000;
-- Orders with profit greater than 500
SELECT * 
FROM Orders WHERE Profit > 500;
-- Furniture orders
SELECT *
FROM Orders
WHERE Category = 'Furniture';
-- Technology Orders
SELECT *
FROM Orders
WHERE Category = 'Technology';
-- Sort by Highest Sales
SELECT *
FROM Orders
ORDER BY Sales DESC;
-- Sort by Highest Profit
SELECT *
FROM Orders
ORDER BY Profit DESC;
-- Top 10 Highest Sales Orders
SELECT *
FROM Orders
ORDER BY Sales DESC
LIMIT 10;
-- Top 10 Highest Profit Orders
SELECT *
FROM Orders
ORDER BY Profit DESC
LIMIT 10;
-- Loss-Making Orders
SELECT *
FROM Orders
WHERE Profit < 0;
--  GROUP BY & AGGREGATE QUERIES
-- Total Sales by Category
SELECT Category,
       SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Category;
-- Total Profit by Category
SELECT Category,
       SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Category;
-- Number of Orders by Category
SELECT Category,
       COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Category;
-- Sales by Sub-Category
SELECT Sub_Category,
       SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;
-- Profit by Sub-Category
SELECT Sub_Category,
       SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Sub_Category
ORDER BY Total_Profit DESC;
-- Sales by Region
SELECT c.Region,
       SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Region
ORDER BY Total_Sales DESC;
-- Profit by Region
SELECT c.Region,
       SUM(o.Profit) AS Total_Profit
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Region
ORDER BY Total_Profit DESC;
-- Top 10 Customers by Sales
SELECT c.Customer_Name,
       SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;
-- Top 10 Customers by Profit
SELECT c.Customer_Name,
       SUM(o.Profit) AS Total_Profit
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;
-- Categories with Sales Greater Than 50000 
SELECT Category,
       SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Category
HAVING SUM(Sales) > 50000;
-- Products with Sales Above Average 
SELECT Product_Name,
       Sales
FROM Orders
WHERE Sales >
(
    SELECT AVG(Sales)
    FROM Orders
);
-- Customer Who Spent the Most
SELECT c.Customer_Name,
       SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Sales DESC
LIMIT 1;
-- ADVANCED SQL QUERIES
-- Categorize Orders Using CASE
SELECT Order_ID,
       Sales,
       CASE
           WHEN Sales >= 1000 THEN 'High Sales'
           WHEN Sales >= 500 THEN 'Medium Sales'
           ELSE 'Low Sales'
       END AS Sales_Category
FROM Orders;
-- Top 5 Products by Profit
SELECT Product_Name,
       SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 5;
-- Products with Negative Profit
SELECT Product_Name,
       SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Product_Name
HAVING SUM(Profit) < 0;
-- Create a Sales Summary View
CREATE OR REPLACE VIEW Sales_Summary AS
SELECT Category,
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Category;

SELECT * FROM Sales_Summary;
-- Rank Products by Sales (Window Function)
SELECT Product_Name,
       SUM(Sales) AS Total_Sales,
       RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM Orders
GROUP BY Product_Name;
-- Running Total of Sales
SELECT
Order_Date,
Order_ID,
Sales,
SUM(Sales) OVER(
ORDER BY Order_Date, Order_ID
) AS Running_Total
FROM Orders;
-- BUSINESS ANALYSIS QUERIES
-- Average Profit by Category
SELECT Category,
       AVG(Profit) AS Average_Profit
FROM Orders
GROUP BY Category;
-- Monthly Sales Report
SELECT YEAR(Order_Date) AS Year,
       MONTH(Order_Date) AS Month,
       SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY YEAR(Order_Date),
         MONTH(Order_Date)
ORDER BY Year,
         Month;
-- Top 5 Cities by Sales
SELECT c.City,
       SUM(o.Sales) AS Total_Sales
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.City
ORDER BY Total_Sales DESC
LIMIT 5;
-- Top 5 States by Profit
SELECT c.State,
       SUM(o.Profit) AS Total_Profit
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.State
ORDER BY Total_Profit DESC
LIMIT 5;
-- Customers with More Than 10 Orders
SELECT c.Customer_Name,
       COUNT(o.Order_ID) AS Total_Orders
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
HAVING COUNT(o.Order_ID) > 10
ORDER BY Total_Orders DESC;
-- Most Frequently Purchased Products
SELECT Product_Name,
       COUNT(*) AS Times_Purchased
FROM Orders
GROUP BY Product_Name
ORDER BY Times_Purchased DESC
LIMIT 10;
-- Highest Profit Product in Each Category
SELECT Category,
       Product_Name,
       Total_Profit
FROM
(
    SELECT Category,
           Product_Name,
           SUM(Profit) AS Total_Profit,
           ROW_NUMBER() OVER
           (
               PARTITION BY Category
               ORDER BY SUM(Profit) DESC
           ) AS rn
    FROM Orders
    GROUP BY Category, Product_Name
) AS Ranked_Products
WHERE rn = 1;
-- Percentage Contribution of Each Category
SELECT Category,
ROUND((SUM(Sales) /
      (SELECT SUM(Sales) FROM Orders))*100,2)
AS Sales_Percentage
FROM Orders
GROUP BY Category;
-- Monthly Profit Trend
SELECT YEAR(Order_Date) AS Year,
MONTH(Order_Date) AS Month,
SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY YEAR(Order_Date),
MONTH(Order_Date)
ORDER BY Year, Month;
-- Average Sales by Region
SELECT c.Region,
AVG(o.Sales) AS Average_Sales
FROM Orders o
JOIN Customers c
ON o.Customer_ID=c.Customer_ID
GROUP BY c.Region;
-- Customer Lifetime Value
SELECT c.Customer_Name,
SUM(o.Sales) AS Lifetime_Value
FROM Orders o
JOIN Customers c
ON o.Customer_ID=c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Lifetime_Value DESC;
-- BUSINESS SUMMARY
-- Overall Business Summary 
SELECT 
COUNT(DISTINCT Customer_ID) AS Total_Customers, 
COUNT(Order_ID) AS Total_Orders, 
SUM(Sales) AS Total_Sales,
 SUM(Profit) AS Total_Profit, 
 AVG(Sales) AS Average_Order_Value 
 FROM Orders;
 -- KEY PERFORMANCE INDICATOR (KPI)
-- KPI 5 – Profit Margin (%)
SELECT
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM Orders;