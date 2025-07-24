SELECT P.product_category_name_english AS Category,
               COUNT(DISTINCT P.order_id) AS Num_order,
               SUM(P.payment_value) AS Revenue
FROM   (
        SELECT *
        FROM   olist_products AS a
        JOIN   product_category_name_translation AS b
        ON     a.product_category_name = b.product_category_name
        JOIN   olist_order_items AS c
        ON     a.product_id = c.product_id
        JOIN   olist_orders AS d
        ON     c.order_id = d.order_id
        JOIN   olist_order_payments AS e
        ON     c.order_id = e.order_id
        ) AS P
WHERE  Category IS NOT NULL
AND    P.order_status == 'delivered'
AND    P.order_delivered_customer_date IS NOT NULL
GROUP BY Category
ORDER BY Revenue DESC
LIMIT  10

-- This query will return a table with the top 10 revenue categories in
-- English, the number of orders and their total revenue. The first column will 
-- be Category, that will contain the top 10 revenue categories; the second one 
-- will be Num_order, with the total amount of orders of each category; and the 
-- last one will be Revenue, with the total revenue of each category.