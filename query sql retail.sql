--CREATE database called portfolio project

--
CREATE TABLE retail_sale 
		
			(transactions_id	INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,	
			customer_id	INT,
			gender	VARCHAR(20),
			age	INT,
			category VARCHAR(30),
			quantity INT,
			price_per_unit	FLOAT,
			cogs	FLOAT,
			total_sale FLOAT
			);
--DATA EXPLORATION 
SELECT *
FROM retail_sale;

SELECT COUNT(*)
FROM retail_sale;


--CHECKING FOR NULL
SELECT *
FROM retail_sale
WHERE transactions_id IS NULL;

--Checking for null values in all the rows
SELECT *
FROM retail_sale

WHERE transactions_id IS NULL
OR 
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR 
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;


--DATA CLEANING DELETING NULL VALUES

DELETE FROM retail_sale

WHERE transactions_id IS NULL
OR 
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR 
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;


--DATA ANALYSIS

--How many sales
SELECT count(*)as total_sale
FROM retail_sale;


--how many unique customers
SELECT COUNT(distinct customer_id)as number_of_customer
FROM retail_sale;

--write a query to retrieve all the columns for sale made on 2022-07-11
SELECT * FROM retail_sale
WHERE sale_date ='2022-07-11';

--how many transaction occurred 
SELECT COUNT(*) as num_of_transaction FROM retail_sale
WHERE sale_date ='2022-07-11';

--Retrieve all transanctions where the category is Clothing and the quantity sold is 
--greater than 3 and the month is Nov-2022

--checking for unique groups in category
SELECT DISTINCT(category)FROM retail_sale;

SELECT * 
FROM retail_sale
WHERE category = 'Clothing'
AND
TO_CHAR(sale_date, 'YYYY-MM') ='2022-11'
AND
quantity >=3;

--how many customers are male
SELECT COUNT(*) as Status FROM retail_sale
WHERE gender='Male';


--how many customers are female
SELECT COUNT(*) as Status FROM retail_sale
WHERE gender='Female';

--write a query to calculate the total sale for each category
SELECT category, sum(total_sale) as sale_total,
COUNT(*) as number_transactions
FROM retail_sale
GROUP BY category;


--Find the average age of customers who purchased category item 'Beauty'
SELECT ROUND(AVG(age),2) as  avg_age
FROM retail_sale
WHERE category ='Beauty';


--Find all transactions whose total_sale is 
--greater than 1000

SELECT * FROM retail_sale
WHERE total_sale >1000
ORDER BY total_sale DESC;


--find the total number of transactions made 
--by each gender and each category

SELECT category, gender, COUNT(*) as total_trans
FROM retail_sale
GROUP BY category, gender
ORDER BY 1; 


--Find the average sale for each month
--find the best selling month in each year


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

--Find the top five customers based on their total sales
SELECT customer_id, SUM(total_sale) as sum_sale
FROM retail_sale
GROUP BY customer_id
ORDER BY sum_sale DESC
Limit 5;


--find the number of unique customers who purchased items from each category
SELECT category, COUNT(DISTINCT customer_id) as number_of_customers
FROM retail_sale
GROUP BY category;

--create each shift and the number of orders
--(E.G morning ,12, Afternoon 12 and 17, Evening >17)


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

--END OF PROJECT



