#Create Database Retail Sales Analysis using Mysql
create database mysql_project;

#Conneting to Database
use mysql_project;

#Creating Table retail_sales
create table retail_sales(
transactions_id	int primary key,
sale_date date,
sale_time	time,
customer_id	int,
gender	varchar(15),
age	int,
category varchar(15),
quantiy	int,
price_per_unit	float,
cogs	float,
total_sale int
);

#View Table
select * from retail_sales;

#############Data Explorations##############

#How many sales we have?
select count(*) as Total_sales from  retail_sales;

#How many customers we have?
select count(distinct(customer_id)) as No_of_customers from retail_sales;

#How many category we have?
select distinct(category) from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


###############  QUARIES  ##############
#Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales 
where sale_date='2022-11-05';

#Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from retail_sales 
where category= 'Clothing' and quantiy>3 and  year(sale_date)=2022 and month(sale_date)=11;

#Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,
sum(total_sale) as Total_Sales_By_Category,
count(*) as total_orders 
from retail_sales 
group by category;

#Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category, 
avg(age) as Avg_age_Custm_used_Beauty 
from retail_sales 
where category="beauty";

#Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales 
where total_sale>1000;

#Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,
gender,
count(transactions_id) as Total_tans_by_Gender 
from retail_sales 
group by gender,category 
order by count(transactions_id) desc ;

#Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year(sale_date),
monthname(sale_date) as Month_Name, 
avg(total_sale) as Avg_sales from retail_sales 
group by sale_date
order by year(sale_date), avg(total_sale) desc;

#Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,
sum(total_sale) as Total_Sales 
from retail_sales 
group by customer_id 
order by sum(total_sale) desc limit 5;

#Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
count(distinct(customer_id)) as Count_Unique_Custm 
from retail_sales 
group by category;

#Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sales  as
(
select *,
case 
    when hour(sale_time)<=12 then "Morning"
    when (hour(sale_time)) between 12 and 17 then "Afternoon"
    else "Evening"
end as shift 
from retail_sales
)
select shift,count(*) from hourly_sales group by shift;

#############End of Project##############


