# E-Commerce Sales & Customer Insights Using SQL

## Project Overview

This project analyzes an E-Commerce Sales dataset using MySQL to generate valuable business insights related to sales performance, customer purchasing behavior, product profitability, and regional performance. The project demonstrates practical SQL skills by applying various SQL concepts to solve real-world business problems and support data-driven decision-making.

---

## Objectives

- Analyze overall sales performance.
- Identify top-performing customers.
- Evaluate product profitability.
- Compare sales and profit across different regions.
- Analyze monthly sales trends.
- Generate key business KPIs using SQL.
- Support business decision-making through data analysis.

---

## Technologies Used

- MySQL 8.0
- SQL
- MySQL Workbench
- CSV Dataset (Sample Superstore)

---

## Dataset Description

The project uses the Sample Superstore dataset, which was divided into two normalized tables to reduce data redundancy.

### Orders Table

| Column Name | Description |
|-------------|-------------|
| Order_ID | Unique order identifier |
| Order_Date | Date when the order was placed |
| Customer_ID | Customer identifier |
| Category | Product category |
| Sub_Category | Product sub-category |
| Product_Name | Product name |
| Sales | Sales amount |
| Profit | Profit earned |

### Customers Table

| Column Name | Description |
|-------------|-------------|
| Customer_ID | Unique customer identifier |
| Customer_Name | Customer name |
| Segment | Customer segment |
| City | Customer city |
| State | Customer state |
| Region | Customer region |

### Dataset Summary

- Total Orders: **9,994**
- Total Customers: **793**
- Product Categories: **3**
- Regions: **4**

---

## SQL Concepts Used

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions (SUM, AVG, COUNT, MIN, MAX)
- DISTINCT
- LIMIT
- INNER JOIN
- Subqueries
- CASE Statement
- Views
- Window Functions
- ROW_NUMBER()
- RANK()

---

## Key Performance Indicators (KPIs)

| KPI | Value |
|------|------:|
| Total Customers | 793 |
| Total Orders | 9,994 |
| Total Sales | 2,297,201.07 |
| Total Profit | 286,338.16 |
| Average Order Value | 229.86 |
| Profit Margin | 12.46% |

---

## Business Insights

- Technology generated the highest sales (836,154.10) and the highest profit (145,455.66).
- Phones were the best-selling sub-category based on total sales.
- Furniture generated high sales but comparatively lower profit.
- The West region generated the highest overall sales.
- Sean Miller was the highest-value customer based on total sales.
- New York City generated the highest revenue among all cities.
- Several products generated negative profit, indicating potential pricing or discount issues.
- Monthly sales analysis showed seasonal fluctuations.
- The business achieved an overall profit margin of 12.46%.
- SQL analysis helped identify key business trends and performance indicators.

---

## SQL Features Demonstrated

- Data Filtering
- Data Aggregation
- Sorting
- Grouping
- INNER JOIN Operations
- Aggregate Functions
- Subqueries
- CASE Statements
- Views
- Window Functions
- Ranking Functions
- KPI Calculations

---

## Project Outcome

This project successfully transformed raw e-commerce sales data into meaningful business insights using SQL. It demonstrates practical experience in database design, data analysis, KPI generation, customer analysis, sales reporting, and business intelligence. The project showcases strong SQL fundamentals and is suitable for Data Analyst, Business Analyst, and SQL Developer portfolio projects.