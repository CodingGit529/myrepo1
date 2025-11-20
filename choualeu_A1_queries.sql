/*Author: Marie Choualeu Tiaha*/
/*Q1*/
USE om;
/* Using CONCAT to help join each variables together to form Name, Phone, and Address*/
SELECT
   CONCAT(customer_last_name, ', ', customer_first_name) AS "Customer Name",  
   CONCAT('Contact #:' , customer_phone) AS "Customer Phone", 
   CONCAT(customer_address, ', ', customer_city, ', ', customer_state, ' ', customer_zip) AS "Customer Address"
FROM customers
/* helps in finding customer whose last name starts with B through E*/
WHERE customer_last_name >= 'B'  
  AND customer_last_name < 'F'
ORDER BY customer_last_name;

USE om; 
/*Q2*/
/*This chooses these three columns from order then seperates it from the given dates*/
SELECT order_id, order_date, shipped_date
FROM orders
WHERE order_date >= '2022-07-11' AND order_date <= '2022-08-02'
ORDER BY order_date;