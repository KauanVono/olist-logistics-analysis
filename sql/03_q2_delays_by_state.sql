-- Q2: Which states concentrate the most delays?
-- Scope: Jan 2017 to Aug 2018; states with fewer than 100 orders are excluded

SELECT
	customer_state,
    COUNT(*) AS delivered_orders,
    SUM(CASE WHEN delay_days > 0 THEN 1 ELSE 0 END) AS late_orders,
    ROUND(SUM(CASE WHEN delay_days > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) late_pct,
    ROUND(AVG(CASE WHEN delay_days > 0 THEN delay_days END), 1) AS avg_delay_days
FROM vw_deliveries
WHERE order_purchase_timestamp >= '2017-01-01'
AND order_purchase_timestamp < '2018-09-01'

GROUP BY customer_state
HAVING COUNT(*) >= 100
ORDER BY late_pct DESC;