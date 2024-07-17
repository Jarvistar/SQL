-- 1 Customer Table

Select * from "Customer";

-- Importing data into customer Table
COPY public."Customer"
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\customer.csv'
DELIMITER ',' CSV HEADER;

-- 2 Category Table
CREATE TABLE category(
category_id INT,
name VARCHAR,	
last_update timestamp);

Select * from category;

-- Importing data into category Table
COPY category
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\category.csv'
DELIMITER ',' CSV HEADER;

--making category id the primary key
ALTER TABLE category
ADD CONSTRAINT category_Pkey 
PRIMARY KEY (category_id);


-- 3 City Table
CREATE TABLE city(
city_id INT PRIMARY KEY,
 city VARCHAR,
country_id INT,
last_update TIMESTAMP);

SELECT * from city;

-- importing data into city table

COPY city
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\city.csv'
DELIMITER ',' CSV HEADER;

-- 4 Country Table

CREATE TABLE country(
country_id INT PRIMARY KEY,
country VARCHAR,
last_update timestamp);

Select * from Country;

--importing data into the country table

COPY country
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\country.csv'
DELIMITER ',' CSV HEADER;


--5 Actor Table
CREATE TABLE Actor (
actor_id INT PRIMARY KEY,
first_name VARCHAR,
last_name VARCHAR,
last_update TIMESTAMP);

SELECT * FROM ACTOR;

--importing data into the actor table

COPY ACTOR
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\actor.csv'
DELIMITER ',' CSV HEADER;

--6-- FILM TABLE
CREATE TABLE FILM(
film_id INT PRIMARY KEY,
title VARCHAR,
description VARCHAR,
release_year DATE,
language_id INT,
rental_duration INT,
rental_rate DECIMAL,
length INT,
replacement_cost DECIMAL,
rating VARCHAR,
last_update TIMESTAMP,
special_features VARCHAR,
fulltext VARCHAR);

SELECT * from Film;

ALTER TABLE FILM ALTER COLUMN release_year SET DATA TYPE VARCHAR USING release_year::VARCHAR;

--importing data into the film table

COPY film
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\film.csv'
DELIMITER ',' CSV HEADER;

--7 FILM ACTOR TABLE
CREATE TABLE film_actor(
actor_id INT,
film_id	INT,
last_update TIMESTAMP,
FOREIGN KEY (actor_id) REFERENCES actor (actor_id),
FOREIGN KEY (film_id) REFERENCES film (film_id));

select * from film_actor
	
--importing data into the film_actor table

COPY film_actor
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\film_actor.csv'
DELIMITER ',' CSV HEADER;

--8-- film_category TABLE

CREATE TABLE film_category(
film_id INT,
category_id INT,
last_update TIMESTAMP,
FOREIGN KEY (category_id) REFERENCES category (category_id),
FOREIGN KEY (film_id) REFERENCES film (film_id));	

select * from film_category;

--importing data into the film_category table

COPY film_category
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\film_category.csv'
DELIMITER ',' CSV HEADER;


--9-- INVENTORY TABLE
create table inventory(
inventory_id INT PRIMARY KEY,
film_id	INT,
store_id INT,
last_update TIMESTAMP);

SELECT * FROM inventory;

COPY inventory
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\inventory.csv'
DELIMITER ',' CSV HEADER;

--10-- LANGUAGE TABLE
create table language(
language_id INT PRIMARY KEY,
name VARCHAR,
last_update TIMESTAMP);

SELECT * FROM language;

COPY language
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\language.csv'
DELIMITER ',' CSV HEADER;

--11-- PAYMENT TABLE
CREATE TABLE payment(
payment_id INT PRIMARY KEY,
customer_id INT,
staff_id INT,
rental_id INT,
amount DECIMAL,
payment_date TIMESTAMP);

SELECT * FROM payment;

COPY payment
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\payment.csv'
DELIMITER ',' CSV HEADER;

--12-- RENTAL TABLE
CREATE TABLE RENTAL(
rental_id INT PRIMARY KEY,
rental_date TIMESTAMP,
inventory_id INT,
customer_id	INT,
return_date	VARCHAR,
staff_id INT,
last_update TIMESTAMP,
FOREIGN KEY (customer_id) REFERENCES public."Customer" (customer_id),
FOREIGN KEY (inventory_id) references inventory (inventory_id)
);

SELECT * from Rental;

COPY rental
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\rental.csv'
DELIMITER ',' CSV HEADER;


--13-- STAFF TABLE
create table Staff(
staff_id INT PRIMARY KEY,
first_name VARCHAR,
last_name VARCHAR,
address_id INT,
email	VARCHAR UNIQUE,
store_id INT,
active	VARCHAR,
username VARCHAR,
password VARCHAR,
last_update VARCHAR,
picture VARCHAR);

SELECT * FROM staff;

COPY staff
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\staff.csv'
DELIMITER ',' CSV HEADER ;

--14-- STORE TABLE
CREATE TABLE STORE (
store_id INT PRIMARY KEY,
manager_staff_id INT,
address_id INT,
last_update TIMESTAMP);

SELECT * FROM STORE;

COPY STORE
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\stORE.csv'
DELIMITER ',' CSV HEADER ;

--15-- ADDRESS TABLE
Create Table Address(
address_id INT PRIMARY KEY,
address VARCHAR,
address2 VARCHAR,
district VARCHAR,
city_id	INT,
postal_code INT,
phone INT,
last_update TIMESTAMP);

ALTER TABLE address ALTER COLUMN postal_code SET DATA TYPE VARCHAR USING postal_code::VARCHAR;
ALTER TABLE address ALTER COLUMN phone SET DATA TYPE VARCHAR USING phone::VARCHAR;

COPY address
FROM 'C:\Users\lap\OneDrive\Desktop\Amdor\SQL\dvdrental\address.csv'
DELIMITER ',' CSV HEADER ;

SELECT * FROM ADDRESS;
