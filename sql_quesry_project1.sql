use sql_project_p1;
----1
drop table if exists retail_sales; 
create table retail_sales(
transactions_id	int PRIMARY KEY,
sale_date DATE,
sale_time	TIME,
customer_id	INT,
gender	VARCHAR(10),
age	 INT,
category	VARCHAR(15),
quantiy	INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale FLOAT
	
)

--2
SELECT * FROM retail_sales;
SELECT DISTINCT customer_id FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;
---3
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
---4
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

---5

select * from retail_sales
where
sale_date = '2022-11-05';
---6
select * from retail_sales
where
category = 'Clothing'
and
to_char(sale_date,'YYYY-MM') = '2022-11'
AND
QUANTIY >= 4;
---7
SELECT CATEGORY, SUM(TOTAL_SALE) AS net_sales,count(*) as total_orders
FROM RETAIL_SALES
group by 1;
---8
select ROUND(avg(age)) as avg_age
from retail_sales
where category = 'beauty';
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1
----9
SELECT *
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2) as t1
WHERE rank = 1;
----10

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
----11
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY 1

