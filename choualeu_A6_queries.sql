/*Author: Marie Choualeu Tiaha*/
/* Answer 1 */ 

USE my_guitar_shop;
SELECT
    t.State,
    t.Customer,
    t.Order_ID,
    t.Order_Total
FROM (
    SELECT
        a.state AS State,
        CONCAT(c.last_name, ', ', c.first_name) AS Customer,
        o.order_id AS Order_ID,
        SUM(
            (oi.quantity * oi.item_price)
            - oi.discount_amount
            + o.ship_amount
            + o.tax_amount
        ) AS Order_Total
    FROM customers c
    JOIN addresses a USING (customer_id)
    JOIN orders o USING (customer_id)
    JOIN order_items oi USING (order_id)
    WHERE a.state IN ('CA', 'CO', 'OR')
    GROUP BY a.state, c.customer_id, o.order_id
) AS t
WHERE t.Order_Total > 400
ORDER BY t.State, t.Customer;

/* Answer 2 */
SELECT
    CONCAT(c.last_name, ', ', c.first_name) AS Customer,
    o.order_id,
    DATEDIFF(o.ship_date, o.order_date) AS shipping_days
FROM customers c
JOIN orders o
  ON c.customer_id = o.customer_id
WHERE o.ship_date IS NOT NULL
  AND o.order_id = (
        SELECT 
             MAX(o2.order_id)
        FROM orders o2
        WHERE o2.customer_id = o.customer_id
          AND o2.ship_date IS NOT NULL
          AND DATEDIFF(o2.ship_date, o2.order_date) = (
                SELECT 
                     MAX(DATEDIFF(o3.ship_date, o3.order_date))
                FROM orders o3
                WHERE o3.customer_id = o.customer_id
                  AND o3.ship_date IS NOT NULL
          )
  )
ORDER BY
    shipping_days DESC,
    Customer;


/* Answer 3 */
CREATE OR REPLACE VIEW longest_shipping_days AS
SELECT
    CONCAT(c.last_name, ', ', c.first_name) AS Customer,
    o.order_id,
    DATEDIFF(o.ship_date, o.order_date) AS max_shipping_days
FROM customers c
JOIN orders o
  ON c.customer_id = o.customer_id
WHERE o.ship_date IS NOT NULL
  AND DATEDIFF(o.ship_date, o.order_date) = (
        SELECT MAX(DATEDIFF(o2.ship_date, o2.order_date))
        FROM orders o2
        WHERE o2.customer_id = o.customer_id
          AND o2.ship_date IS NOT NULL
     )
  AND o.order_id = (
        SELECT MAX(o3.order_id)
        FROM orders o3
        WHERE o3.customer_id = o.customer_id
          AND o3.ship_date IS NOT NULL
          AND DATEDIFF(o3.ship_date, o3.order_date) =
              DATEDIFF(o.ship_date, o.order_date)
     );
SELECT
    Customer,
    order_id,
    max_shipping_days
FROM longest_shipping_days
WHERE max_shipping_days > 1
ORDER BY Customer;