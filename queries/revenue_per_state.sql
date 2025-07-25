SELECT
    c.customer_state AS customer_state,
    SUM(p.payment_value) AS Revenue
FROM
    olist_orders o
INNER JOIN
    olist_order_payments p ON o.order_id = p.order_id
INNER JOIN
    olist_customers c ON o.customer_id = c.customer_id
WHERE
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY
    c.customer_state
ORDER BY
    Revenue DESC
LIMIT 10;

-- This query will return a table with two columns; customer_state, and
-- Revenue. The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
