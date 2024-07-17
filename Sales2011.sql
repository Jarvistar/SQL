--- creating the 2011 sales table
CREATE TABLE Sales2011(
	order_id VARCHAR,
	Order_date DATE,
	ship_date DATE,
	ship_mode VARCHAR,
	customer_name VARCHAR,
	segement VARCHAR,
	STATE VARCHAR,
	COUNTRY VARCHAR,
	Product_id VARCHAR,
	Category VARCHAR,
	Sub_category VARCHAR,
	Product_name VARCHAR,
	Sales INT,
	Quantity INT,
	Discount DECIMAL,
	Shipping_cost DECIMAL);

SELECT * FROM SALES2011;

---making order id the primary key of the table

ALTER TABLE Sales2011 ADD CONSTRAINT sales_pky PRIMARY KEY (order_id);

--DELETING THE PRIMARY KEY CONSTRAINT
ALTER TABLE Sales2011
DROP CONSTRAINT sales_pky;


---importing the sales data into table

COPY Sales2011 FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\2011Sales.csv' DELIMITER ',' CSV HEADER;


------query to return the total number of orders
SELECT COUNT (*) FROM Sales2011;

SELECT * FROM SALES2011;
--QUERY TO RETURN THE TOTAL NUMBER OF CUSTOMERS
SELECT COUNT (DISTINCT  customer_name) FROM Sales2011;

--write a query to return total revenue generated from sales

SELECT SUM (SALES) FROM SALES2011;

--QUERY TO RETURN MAXIMUM SHIPPING COST
SELECT MAX(Shipping_cost) FROM Sales2011;


--query to return tht total number of orders from the consumer segement
SELECT COUNT(ORDER_ID)
FROM Sales2011
WHERE Segement  = 'Consumer';
