SELECT
  strftime('%m', order_purchase_timestamp) AS month_no,
  substr('JanFebMarAprMayJunJulAugSepOctNovDec',
         1 + 3*(strftime('%m', order_purchase_timestamp)-1), 3) AS month,
  ROUND(AVG(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2016'
                 THEN julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)
                 END), 2) AS Year2016_real_time,
  ROUND(AVG(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2017'
                 THEN julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)
                 END), 2) AS Year2017_real_time,
  ROUND(AVG(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2018'
                 THEN julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)
                 END), 2) AS Year2018_real_time,

  ROUND(AVG(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2016'
                 THEN julianday(order_estimated_delivery_date) - julianday(order_purchase_timestamp)
                 END), 2) AS Year2016_estimated_time,
  ROUND(AVG(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2017'
                 THEN julianday(order_estimated_delivery_date) - julianday(order_purchase_timestamp)
                 END), 2) AS Year2017_estimated_time,
  ROUND(AVG(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2018'
                 THEN julianday(order_estimated_delivery_date) - julianday(order_purchase_timestamp)
                 END), 2) AS Year2018_estimated_time

FROM olist_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
GROUP BY month_no, month
ORDER BY month_no;

-- This query will return a table with the differences between the real
-- and estimated delivery times by month and year. It will have different 
-- columns: month_no, with the month numbers going from 01 to 12; month, with 
-- the 3 first letters of each month (e.g. Jan, Feb); Year2016_real_time, with 
-- the average delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_real_time, with the average delivery time per month of 2017 (NaN if 
-- it doesn't exist); Year2018_real_time, with the average delivery time per 
-- month of 2018 (NaN if it doesn't exist); Year2016_estimated_time, with the 
-- average estimated delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_estimated_time, with the average estimated delivery time per month 
-- of 2017 (NaN if it doesn't exist) and Year2018_estimated_time, with the 
-- average estimated delivery time per month of 2018 (NaN if it doesn't exist).

