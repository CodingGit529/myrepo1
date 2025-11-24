/*Author: Marie Choualeu Tiaha*/
/* Answer 1 */ 
USE my_guitar_shop;
/* part 1 */
DROP TABLE IF EXISTS customers_copy;
DROP TABLE IF EXISTS orders_copy;
DROP TABLE IF EXISTS order_items_copy;

CREATE TABLE customers_copy LIKE customers;
CREATE TABLE orders_copy LIKE orders;
CREATE TABLE order_items_copy LIKE order_items;

INSERT INTO customers_copy SELECT * FROM customers;
INSERT INTO orders_copy SELECT * FROM orders;
INSERT INTO order_items_copy SELECT * FROM order_items;

/* part 2*/
INSERT INTO customers_copy (customer_id, email_address, password, first_name, last_name)
VALUES (9, 'xyzabc@gmail.com', '12345677654321', 'Unreal', 'Person');

/* part 3 */
INSERT INTO orders_copy (order_id, customer_id, order_date, ship_amount, tax_amount, ship_date,
                         ship_address_id, card_type, card_number, card_expires, billing_address_id)
VALUES (10, 9, '2020-12-01 23:10:42', 10.00, 0.00, NULL, 119, 'Visa',
        '1111111111111111', '05/22', 19);
        
/* part 4*/
INSERT INTO order_items_copy (item_id, order_id, product_id, item_price, discount_amount, quantity)
VALUES (16, 10, 1, 699.00, 209.70, 1);

/* part 5*/
INSERT INTO order_items_copy (item_id, order_id, product_id, item_price, discount_amount, quantity)
VALUES (17, 10, 10, 799.99, 120.00, 1);

/* part 6 */ 
SELECT * 
FROM customers_copy 
ORDER BY customer_id 
ASC;

SELECT * 
FROM orders_copy 
ORDER BY order_id 
ASC;

SELECT * 
FROM order_items_copy 
ORDER BY item_id 
ASC;

/* Answer 2 */
/* part 1 */
SET SQL_SAFE_UPDATES = 0;
UPDATE order_items_copy
SET product_id = 7,
    item_price = 799.99,
    discount_amount = 240.00
WHERE order_id = 10
  AND product_id = 10;
  
/* part 2 */
SELECT 
CONCAT(first_name,' ', last_name) AS customer_name, 
order_date, ship_date, product_name,
CONCAT('$', item_price) AS standard_price, 
CONCAT('$', discount_amount) as discount,
CONCAT('$',item_price - discount_amount) as actual_price 
FROM customers_copy 
INNER JOIN orders_copy ON customers_copy.customer_id = orders_copy.customer_id
INNER JOIN order_items_copy ON orders_copy.order_id = order_items_copy.order_id
INNER JOIN products ON order_items_copy.product_id = products.product_id
WHERE ship_date IS NULL
ORDER BY order_date DESC, last_name ASC;

/* Answer 3 */
DELETE FROM order_items_copy
WHERE order_id = 10;
DELETE FROM orders_copy
WHERE order_id = 10;

SELECT 
CONCAT(first_name,' ', last_name) AS customer_name, 
order_date, ship_date, product_name,
CONCAT('$', item_price) AS standard_price, 
CONCAT('$', discount_amount) as discount,
CONCAT('$',item_price - discount_amount) as actual_price 
FROM customers_copy 
INNER JOIN orders_copy ON customers_copy.customer_id = orders_copy.customer_id
INNER JOIN order_items_copy ON orders_copy.order_id = order_items_copy.order_id
INNER JOIN products ON order_items_copy.product_id = products.product_id
WHERE ship_date IS NULL
ORDER BY order_date DESC, last_name ASC;