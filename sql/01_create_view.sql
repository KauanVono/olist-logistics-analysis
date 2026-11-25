CREATE OR REPLACE VIEW vw_deliveries AS
SELECT
    o.order_id,
    c.customer_state,
    o.order_purchase_timestamp,
    DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) AS actual_delivery_days,
    DATEDIFF(o.order_estimated_delivery_date, o.order_purchase_timestamp) AS promised_delivery_days,
    DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS delay_days,  -- > 0 = late
    CASE WHEN DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) <= 0
         THEN 1 ELSE 0 END AS delivered_on_time
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;