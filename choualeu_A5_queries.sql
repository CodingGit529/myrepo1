/* Author: Marie Choualeu Tiaha */
/* Answer 1 */

USE om;
SELECT 
    CONCAT(customer_last_name, ', ', customer_first_name) AS "customer_name",  
    COUNT(DISTINCT orders.order_id) AS "number_of_orders", 
    SUM(order_qty) AS "total_items_purchased", 
    CONCAT('$', MAX(unit_price)) AS "max_item_cost",
    CONCAT('$', SUM(order_qty * unit_price)) AS "total_spent", 
    CONCAT('$', ROUND(SUM(order_qty * unit_price) / COUNT(DISTINCT orders.order_id), 2)) AS "avg_spent_per_order"
FROM customers 
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN items
ON order_details.item_id = items.item_id

GROUP BY customers.customer_id,  customer_first_name, customer_last_name
HAVING 
   SUM(order_qty * unit_price) >= 50
ORDER BY customer_name ASC;

/* Answer 2 */
SELECT 
    CONCAT(customer_last_name, ', ', customer_first_name) AS "customer_name", 
    COUNT(DISTINCT items.item_id) AS "item_purchased", 
    CONCAT('$', ROUND(AVG(unit_price), 2)) AS "avg_unit_price",
    CONCAT('$', MAX(unit_price)) AS "max_unit_price"
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN items
ON order_details.item_id = items.item_id

GROUP BY customers.customer_id,  customer_first_name, customer_last_name
HAVING 
   COUNT(DISTINCT items.item_id) >= 5 
   AND ROUND(AVG(unit_price), 2) > 15
ORDER BY avg_unit_price DESC;

    
    