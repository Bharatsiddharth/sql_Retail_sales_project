use sql_Retail_sales_Analysis;

select * from retail_sales;

drop table if exists retail_sales;
create table retail_sales (
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)


select count(*) from retail_sales;

-- Data Cleaning
select * from retail_sales 
where transactions_id is null

--
select * from retail_sales 
where sale_date is null

--
select * from retail_sales
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_date is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null


	--
delete from retail_sales
where
		transactions_id is null
		or
		sale_date is null
		or
		sale_date is null
		or
		gender is null
		or
		category is null
		or
		quantiy is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null


-- Data Exploration


-- How many sales we have?
Select count(*)	as total_sale from retail_sales;


-- How many unique customer we have
Select count(distinct customer_id) as unqiue_customer from retail_sales


select distinct category from retail_sales;


-- Data Analysis & Business Key problems and Answers


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date='2022-11-05';



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2020

 select * 
 from retail_sales
 where 
	category = 'Clothing'
	AND 
	FORMAT(sale_date, 'yyyy-MM') = '2022-11'
	AND 
	quantiy >= 4


-- Q.3 Write a SQL to calculate the total sales (total_sales) for each category

select 
	category,
	sum(total_sale) as net_sale ,
	count(*) as total_orders
	from retail_sales
	group by category



-- Q.4 Write a SQL to find the average age of customers who purchased items from the 'Beauty' category.

select 
	category,
	AVG(age) as Avg_age 
	from retail_sales
	where category = 'Beauty'
	group by category;


-- Q.5 Write a SQL query to find all transactions where the total_sales is greater than 1000.

select * from retail_sales
where total_sale >= 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by,each gender in each category.

select category,gender, count(*) as total_trans from retail_sales
group by category,gender
order by 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month each year

select 
	sale_year,sale_month,avg_sale from
(
	SELECT 
    YEAR(sale_date) AS sale_year, 
    MONTH(sale_date) AS sale_month, 
    AVG(total_sale) AS avg_sale,
	Rank() OVER(partition by YEAR(sale_date) order by AVG(total_sale) desc) as rank
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
--Order by 1,3 desc;
) as t1
where rank = 1;



--Q.8 Write SQL query to find the top 5 customers based on the highest total sales

select * from retail_sales;

SELECT TOP 5 customer_id, SUM(total_sale) AS total
FROM retail_sales
GROUP BY customer_id
ORDER BY total DESC;


--Q.9 Write a SQL query to find the number of unique customers who purchased items for each category;

select category,count(distinct customer_id) as unique_customer from retail_sales
group by category;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, afternoon 12 & 17 ,Evening > 17)
WITH hourly_sale AS (
	SELECT *,
    CASE 
        WHEN DATEPART(HOUR, sale_date) < 12 THEN 'MORNING'
        WHEN DATEPART(HOUR, sale_date) BETWEEN 12 AND 17 THEN 'AFTERNOON'
        ELSE 'EVENING'
    END AS SHIFT
	FROM retail_sales
) 
SELECT 
	SHIFT,
	count(*) AS total_orders 
FROM hourly_sale 
GROUP BY SHIFT;



ALTER TABLE retail_sales
ALTER COLUMN sale_date DATETIME;


--EOP