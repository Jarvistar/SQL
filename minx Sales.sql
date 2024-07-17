select count (*) 
from sales_order;

---query to return the total no of orders
Select count(order_number) 
from sales_order;

--query to return the total revenue generated
SELECT SUM(unit_price * order_quantity)
AS revenue
FROM sales_order;

---query to return the distinct no of Products in the order table
SELECT COUNT (DISTINCT product_id) 
FROM Sales_order;



--query to return the most recent order date
SELECT MAX (order_date)
AS most_recent_order_date
FROM Sales_order;

--query to return the earliest order date
SELECT MIN (order_date)
AS earliest_order_date
FROM Sales_order;

--query to return the overall average price of all products
SELECT ROUND(AVG (unit_price),2)
AS Average_price
FROM sales_order;

--query to return total orders, total revenue, total quantity, total customers
SELECT COUNT(order_number) AS total_orders,
SUM(unit_price * order_quantity) AS total_revenue,
SUM(order_quantity) AS total_quantity,
COunt(Distinct customer_id) AS total_customers
FROM sales_order;

--query to return total number of orders handled by each salesteam
SELECT Salesteam_id, 
COUNT(order_number)
AS total_orders
FROM sales_order
GROUP BY salesteam_id;


--- SELECT > FROM > WHERE > GROUP BY > HAVING > ORDER BY


--checking for duplicates in the sales order table
SELECT order_number,
COUNT(order_number) AS count
FROM sales_order
GROUP BY order_number
HAVING COUNT(order_number) > 1;

select * from sales_order;


--query to return the total units/quantity ordered for each product
SELECT product_id,
SUM(order_quantity) AS total_quantity
FROM sales_order
GROUP BY product_id;


--query to return the total units/quantity ordered for each product by customer
SELECT product_id,customer_id,
SUM(order_quantity) AS total_quantity
FROM sales_order
GROUP BY product_id,customer_id
ORDER BY customer_id;

--query to return the total number of states in each of the regions
select * from region;

SELECT region, COUNT(state) AS total_number_of_states
	FROM region
GROUP BY region;

/* query to return the order number, customer id, product id, and quantity columns,
but we want the result to be ordered by the latest order number first*/

SELECT order_number, customer_id, product_id, order_quantity
FROM sales_order
ORDER BY order_number DESC;


--- query to  return all columns in the customer table, with the result ordered by the customer

SELECT * from customer;

SELECT * from customer
ORDER BY customer_name ASC;


--query to return total number of orders handled by each salesteam order by their sales_numer(highest first)
SELECT Salesteam_id, 
COUNT(order_number) AS total_orders
FROM sales_order
GROUP BY salesteam_id
ORDER BY total_orders DESC;

SELECT * FROM public.sales_team;

SELECT name, 
COUNT(order_number) AS total_orders
FROM sales_order
GROUP BY name
ORDER BY total_orders DESC;

/*query to return the order number, customer id, product id, quantity, and revenue columns, 
but we would want the result to be ordered by the highest revenue first*/

SELECT order_number, customer_id,product_id,order_quantity,
SUM(unit_price *order_quantity) AS revenue
FROM sales_order
GROUP BY order_number, customer_id,product_id,order_quantity
ORDER BY revenue DESC;


--query to return the top 5 most ordered products
SELECT product_id,
COUNT(order_number) AS total_order
FROM sales_order
GROUP BY product_id
ORDER BY  total_order DESC
LIMIT 5;

--query to return least/bottom 5  ordered products
SELECT product_id,
COUNT(order_number) AS total_order
FROM sales_order
GROUP BY product_id
ORDER BY  total_order ASC
LIMIT 5;

---query to return the id of the salesperson who handled the most orders
SELECT salesteam_id,
COUNT(order_number) AS total_order
FROM sales_order
GROUP BY salesteam_id
ORDER BY total_order DESC
LIMIT 1;


--Date Formatting in SQL
--1 Query to return only the year values from the order date column

SELECT order_date, TO_CHAR(order_date, 'YY') AS "order year"
FROM sales_order;

--2 Query to return only the month values from the order date column
SELECT order_date, TO_CHAR(order_date, 'Mon') AS "order month"
FROM sales_order;

SELECT order_date, TO_CHAR(order_date, 'Month') AS "order month"
FROM sales_order;


--3 Query to return month with highest revenue
SELECT TO_CHAR(order_date, 'Month') AS order_month,
SUM(UNIT_price * order_quantity) AS revenue
FROM sales_order
GROUP BY order_month
ORDER BY revenue DESC
LIMIT 1;


--4 query to return revenue generated per month

SELECT TO_CHAR(order_date, 'Month') AS order_month,
SUM(UNIT_price * order_quantity) AS revenue
FROM sales_order
GROUP BY order_month
ORDER BY revenue DESC;

--5 query to return total number of orders by day of the week
SELECT TO_CHAR(order_date, 'Day') AS weekday,
COUNT(order_number) AS total_orders
FROM sales_order
GROUP BY weekday;

--6 query to return the order summary by month and day of the week
SELECT TO_CHAR (order_date, 'Month') AS order_month,
TO_CHAR (order_date, 'Day') AS order_day,
COUNT (order_number) AS total_orders,
SUM(unit_price * order_quantity) AS Revenue
FROM sales_order
GROUP BY order_month,order_day
ORDER BY order_day;



--HOW TO UPDATE A TABLE IN SQL
--1. query to create a revenue column in the sales order table

ALTER TABLE sales_order ADD COLUMN revenue DECIMAL;

UPDATE sales_order
SET revenue = unit_price * order_quantity * discount_applied;

SELECT * from sales_order;


--2. query to change the sales channel from in_store to retail
UPDATE sales_order
SET sales_channel = 'Retail'
WHERE sales_channel = 'In-Store';

SELECT DISTINCT(sales_channel)
FROM sales_order;


--3. query to set discount of product with id 22 to 15%(0.15)

UPDATE sales_order
SET discount_applied = 0.15
WHERE product_id =22;

SELECT product_id, discount_applied
FROM sales_order
WHERE product_id = 22;

--4 query to reduce the unit price of some products by 350 if the unit cost is greater than 1000

UPDATE sales_order
SET unit_price = unit_price - 350
WHERE unit_cost > 1000;

SELECT product_id, unit_cost, unit_price
FROM sales_order
ORDER BY product_id, unit_price DESC;

--NESTED QUERIES (SUB QUERIES)
---1. query to get the total amount spent by a particular customer, but we only know their name

SELECT customer_id, SUM(revenue) AS total_amount_spent
FROM sales_order
WHERE customer_id = (SELECT customer_id
FROM customer
WHERE customer_name = 'Eminence Corp');



---SATURDAY CLASS
--- FILTERING USING WHERE CLAUSE
--  query to return only orders from customer with customer id 22
SELECT * FROM sales_order
WHERE customer_id = 22;

-- query to return the total number or orders made via the Wholesale sales channel
SELECT COUNT (order_number) AS total_orders
FROM sales_order
WHERE sales_channel = 'Wholesale';


-- query to return all orders except those via the In-Store sales channel
SELECT * FROM sales_order
WHERE sales_channel !='In-Store'

--query to return orders having above 5 in quantity
SELECT *
FROM sales_order
WHERE order_quantity > 5;


--query to return the total number of orders having their quantities less than or equal to 4
SELECT COUNT (order_number) AS total_orders
FROM sales_order
WHERE order_quantity<=4;

--query to return the total revenue generated only if the revenue from orders is greater than 5000
SELECT (unit_price * order_quantity) AS revenue
FROM sales_order
WHERE revenue > 5000;

SELECT SUM (unit_price * order_quantity) AS revenue
FROM sales_order
WHERE (unit_price * order_quantity) > 5000;

--LOGICAL OPERATORS
---query to return orders via the Distributor sales channel with discount above 3%

SELECT *
FROM sales_order
WHERE sales_channel = 'Distributor' AND discount_applied > 0.03;

---query to return only orders with product id 12 and order date is 31st May, 2018

SELECT *
FROM sales_order
WHERE product_id = 12 AND order_date = '2018-05-31';

--query to return stores that are either in Alabama or the City Type is Town

SELECT *
FROM location
WHERE state = 'Alabama' OR type ='Town';

-- query to return orders from three customers with id 13, 17 and 20

SELECT *
FROM sales_order
WHERE customer_id IN (13,17,20);

---query to return orders from all sales channel excluding Wholesale, In-Store, and Online

SELECT *
FROM sales_order
WHERE sales_channel NOT IN ('Wholesale','Retail','Online');

SELECT *
FROM sales_order


--query to return orders having products with unit price between 500 and 1000

SELECT *
FROM sales_order
WHERE unit_price BETWEEN 500 AND 1000;

--query to return orders made in the Month of June 2018

SELECT *
FROM sales_order
WHERE order_date BETWEEN '2018-06-01' AND '2018-06-30';

--query to return the id of a customer whose name is Eminence Corp

SELECT customer_id AS Cutomer_number
FROM customer
WHERE customer_name LIKE 'Eminence Corp';

---query to return customers having Group in their name

SELECT *
FROM customer
WHERE customer_name LIKE '%Group';

---query to return the information of cities that begin with letter A

SELECT *
FROM Location
WHERE city_name LIKE 'A%';


-- query to return the information of cities that end with the letter e

SELECT *
FROM Location
WHERE city_name LIKE '%e';


--query to return the information of cities having the letters en anywhere in their name

SELECT *
FROM Location
WHERE city_name LIKE '%en%';

SELECT *
FROM Location
WHERE city_name ILIKE '%en%';

--query to return the information of 5-letters word cities

SELECT *
FROM Location
WHERE city_name LIKE '_____';

SELECT *
FROM Location
WHERE city_name LIKE '____';

--query to return the information of cities having 7 letters beginning with C

SELECT *
FROM Location
WHERE city_name LIKE 'C______';


SELECT *
FROM Location
WHERE city_name LIKE 'C__c%';


SELECT *
FROM sales_order;


-- add a year,month,weekday column to sales order table

ALTER TABLE sales_order ADD COLUMN order_year VARCHAR(4);
ALTER TABLE sales_order ADD COLUMN order_month VARCHAR;
ALTER TABLE sales_order ADD COLUMN weekday VARCHAR;

SELECT order_year,order_month,weekday
FROM sales_order;

ALTER TABLE sales_order RENAME COLUMN weekday week_day VARCHAR;


UPDATE sales_order
SET order_year = TO_CHAR(order_date, 'yyyy');

UPDATE sales_order
SET order_month = TO_CHAR(order_date, 'Mon');

UPDATE sales_order
SET weekday = TO_CHAR(order_date, 'Dy');


-- JOINS IN SQL
-- query to return order details of customers who ordered via the Distributor sales channel

SELECT *
FROM sales_order
INNER JOIN customer 
ON sales_order.customer_id = customer.customer_id
WHERE sales_channel = 'Distributor';

SELECT *
FROM sales_order
INNER JOIN customer 
ON sales_order.customer_id = customer.customer_id
WHERE sales_channel ILIKE 'distributor';

SELECT customer_name,order_number,product_id,order_quantity,discount_applied,unit_price,revenue
FROM sales_order
INNER JOIN customer
ON sales_order.customer_id = customer.customer_id
WHERE sales_channel ILIKE 'distributor';

SELECT customer_name,so.customer_id,order_number,product_id,order_quantity,discount_applied,unit_price,revenue
FROM sales_order so
INNER JOIN customer c
ON so.customer_id = c.customer_id
WHERE sales_channel ILIKE 'distributor';



-- query to return the total number of orders from each city

SELECT l.store_id,city_name,COUNT(order_number) AS total_orders
FROM sales_order so
INNER JOIN location l
ON so.store_id = l.store_id	
GROUP BY l.store_id, city_name;

SELECT l.store_id,city_name,COUNT(order_number) AS total_orders
FROM sales_order so
INNER JOIN location l
ON so.store_id = l.store_id	
GROUP BY l.store_id, city_name
ORDER BY total_orders DESC;

SELECT city_name,COUNT(order_number) AS total_orders
FROM sales_order so
INNER JOIN location l
ON so.store_id = l.store_id	
GROUP BY  city_name
ORDER BY total_orders DESC;

-- query to return the total number of stores in each region

SELECT region, COUNT(store_id) AS total_stores
FROM location l
INNER JOIN region r	
ON l.state_code = r.state_code
GROUP BY region;

/*query to return order details of customers who ordered via the Distributor sales channel,
including the name of products ordered, and city of store where order took place */

SELECT c.customer_name,so.order_number,p.product_name,l.city_name,so.order_quantity,so.discount_applied,so.unit_price,so.revenue
FROM sales_order so
INNER JOIN customer c
ON so.customer_id = c.customer_id
INNER JOIN product p
ON so.product_id = p.product_id
INNER JOIN location l
ON so.store_id = l.store_id
WHERE sales_channel ILIKE 'distributor'


--query to return the top 10 customers by total spending (revenue)
	
SELECT c.customer_name, SUM(revenue) AS total_spending
FROM customer c
LEFT JOIN SALES_ORDER so
ON c.customer_id = so.customer_id	
GROUP BY customer_name
ORDER BY total_spending DESC
LIMIT 10;


-- query to return the least/bottom 10 products by quantity ordered

SELECT product_name, SUM(order_quantity) AS quantity_ordered
FROM sales_order so
RIGHT JOIN PRODUCT p
ON so.product_id = p.product_id
GROUP BY product_name
ORDER BY quantity_ordered ASC
LIMIT 10;

--CASE WHEN
--query to categorize the price of products into high, medium and low

SELECT p.product_name, so.unit_price,
CASE WHEN so.unit_price >= 1500 THEN 'High'
	WHEN so.unit_price >= 500 THEN 'Medium'
	ELSE 'Low'
	END AS price_category
FROM sales_order so
INNER JOIN product p	
ON so.product_id = p.product_id;


--query to count the number of orders in each price category
SELECT unit_price,
CASE WHEN unit_price >= 1500
THEN 1
END AS High
FROM sales_order;

SELECT 
COUNT(CASE WHEN unit_price >=1500 THEN 'High' END) AS High,
COUNT(CASE WHEN unit_price >=500 AND unit_price <1500 THEN 'Medium' END) AS Medium,
COUNT(CASE WHEN unit_price < 500 THEN 'Low' END) AS Low
FROM sales_order;

SELECT COUNT(order_number), COUNT(distinct customer_id)
FROM sales_order;


SELECT * FROM product;

SELECT p.product_id,product_name,SUM(revenue)	
FROM product p
LEFT JOIN sales_order so	
ON p.product_id = so.product_id
GROUP BY p.product_id,product_name;

SELECT p.product_id,product_name,SUM(revenue)	
FROM product p
INNER JOIN sales_order so	
ON p.product_id = so.product_id
GROUP BY p.product_id,product_name;

SELECT p.product_id,product_name,SUM(revenue)	
FROM product p
RIGHT JOIN sales_order so	
ON p.product_id = so.product_id
GROUP BY p.product_id,product_name;


--COMMON TABLE EXPRESSION CTE IN SQL
--query to know the number of orders in each price category

WITH BOLAJI AS
	
(SELECT order_number,unit_price,	
CASE WHEN unit_price >= 1500 THEN 'High'
WHEN unit_price >= 500 THEN 'Medium'
ELSE 'Low'
END AS price_category
FROM sales_order)

SELECT price_category, COUNT (order_number) AS total_orders
FROM BOLAJI
GROUP BY price_category
ORDER BY total_orders DESC;


---VIEWS
---query to create a view for orders made in August

SELECT count(*) AS August_Total_Orders
FROM sales_order
WHERE order_date BETWEEN '2018-08-01' AND '2018-08-31';

CREATE VIEW August_Orders AS 
SELECT * 
FROM sales_order
WHERE order_date BETWEEN '2018-08-01' AND '2018-08-31';


select *
FROM august_orders;


--query to create a view for the top 10 most ordered products

CREATE VIEW Top_Ten_most_ordered_products 
AS
SELECT p.product_name, COUNT(order_number) AS total_orders
FROM sales_order so
INNER JOIN product p
ON so.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC
LIMIT 10;


SELECT *
FROM Top_Ten_most_ordered_products ;


--- create a procedure to add new products to the product table

/*CREATE OR REPLACE PROCEDURE procedure_name
LANGUAGE plpgsql
AS $$
BEGIN
QUERY
END;
$$*/


CREATE OR REPLACE PROCEDURE insert_new_product (new_id INT, new_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO product(product_id, product_name)
VALUES (new_id, new_name);
END;
$$


CALL insert_new_product (48, 'dodo');

SELECT *
FROM product;


--create a procedure that updates the unit price of an order based on its order number

CREATE OR REPLACE PROCEDURE updare_unit_price (new_unit_price DECIMAL, order_num VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN

UPDATE sales_order
SET unit_price = new_unit_price
WHERE order_number = order_num;

END;
$$


SELECT * FROM sales_order;


CALL updare_unit_price (1000, 'SO - 000107');


