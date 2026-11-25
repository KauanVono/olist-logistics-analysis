-- Q1: On-time delivery rate by month
-- Scope: Jan 2017 to Aug 2018 (months outside this range have too few orders to be meaningful)

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS delivered_orders,
    SUM(delivered_on_time) AS on_time_orders,
    ROUND(SUM(delivered_on_time) * 100.0 / COUNT(*), 2) AS on_time_pct
FROM vw_deliveries
WHERE order_purchase_timestamp >= '2017-01-01'
AND order_purchase_timestamp < '2018-09-01'
GROUP BY order_month
ORDER BY order_month;

-- Q1: Overall on-time rate for the same period
SELECT
    COUNT(*) AS delivered_orders,
    ROUND(SUM(delivered_on_time) * 100.0 / COUNT(*), 2) AS overall_on_time_pct
FROM vw_deliveries
WHERE order_purchase_timestamp >= '2017-01-01'
  AND order_purchase_timestamp <  '2018-09-01';