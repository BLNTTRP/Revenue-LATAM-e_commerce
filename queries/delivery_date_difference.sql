SELECT
    c.customer_state AS State,
    CAST(AVG(julianday(STRFTIME('%Y-%m-%d', o.order_estimated_delivery_date)) - julianday(STRFTIME('%Y-%m-%d', o.order_delivered_customer_date))) AS INTEGER) AS Delivery_Difference
FROM
    olist_orders AS o
JOIN
    olist_customers AS c
ON
    o.customer_id = c.customer_id
WHERE
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY
    c.customer_state
ORDER BY
    Delivery_Difference;

-- This query will return a table with two columns; State, and
-- Delivery_Difference. The first one will have the letters that identify the
-- states, and the second one the average difference between the estimate
-- delivery date and the date when the items were actually delivered to the
-- customer.