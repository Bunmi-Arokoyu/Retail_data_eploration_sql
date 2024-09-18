# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail sales data exploration using SQL Analysis  
**Database**: `PORTFOLIO PROJECT`

This project showcases my SQL skills and techniques to explore, clean, and analyze retail sales data as a data analyst. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `PORTFOLIO PROJECT `.
- **Table Creation**: A table named `retail_sale` was created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE PORTFOLIO PROJECT;

CREATE TABLE retail_sale
(
     gender VARCHAR(15),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:


1. **who are the top 5 customers based on the highest total sales.**
```sql
SELECT customer_id, SUM(total_sale) as sum_sale
FROM retail_sale
GROUP BY customer_id
ORDER BY sum_sale DESC
Limit 5;
```

2. **Count the number of unique customers**:
```sql
SELECT COUNT(distinct customer_id)as number_of_customer
FROM retail_sale;
```

3. **Count the number of sales made on '2022-07-11**:
```sql
SELECT COUNT(*) as num_of_transaction
FROM retail_sale
WHERE sale_date ='2022-07-11';
```

4. **Retrieve all transactions where the category is 'Beauty' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
SELECT * 
FROM retail_sale
WHERE category = 'Beauty'
AND
TO_CHAR(sale_date, 'YYYY-MM') ='2022-11'
AND
quantity >=3;
```

5. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

6. **How many unique groups are in category**:
```sql
SELECT DISTINCT(category)
FROM retail_sale;
```

7. **What is the average age of customers who purchased items from the 'Clothing' category.**:
```sql
SELECT ROUND(AVG(age),2) as  avg_age
FROM retail_sale
WHERE category ='Clothing';
```

8. **calculate the total sale for each category.**:
```sql
SELECT category, sum(total_sale) as sale_total,
COUNT(*) as number_transactions
FROM retail_sale
GROUP BY category;
```

9. **List all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sale
WHERE total_sale >1000
ORDER BY total_sale DESC;
```

10. **find the total number of transactions made by each gender and for each category.**
```sql
SELECT category, gender, COUNT(*) as total_trans
FROM retail_sale
GROUP BY category, gender
ORDER BY category;
```


11. **Find the number of unique customers who purchased items from each category.**
```sql
SELECT category, COUNT(DISTINCT customer_id) as number_of_customers
FROM retail_sale
GROUP BY category;
```

12. **Group the time of order into 3 and count the number of orders made (i.e Morning ,12, Afternoon 12 and 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time)BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sale
)
SELECT 	
	shift,
	COUNT(*) as total_order
From hourly_sale
GROUP BY shift;
```

13. **What is the average sale for each month , find the best selling month in each year**:
```sql
SELECT* FROM
(
	SELECT 
		EXTRACT(YEAR FROM sale_date) as sale_year,
		EXTRACT(MONTH FROM sale_date) as sale_month,
		AVG(total_sale) as avg_total,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM retail_sale
	GROUP BY 1,2
) as t1
WHERE rank =1;
--ORDER BY 1,3 DESC;
```
## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Conclusion
The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

### End of Project


