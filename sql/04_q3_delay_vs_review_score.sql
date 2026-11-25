-- Q3: Does delivery delay lower the customer review score?
-- Scope: Jan 2017 to Aug 2018
-- Decision: some orders have more than one review, so we average the score per order first

WITH reviews_per_order AS (
    SELECT order_id, AVG(review_score) AS review_score
    FROM order_reviews
    GROUP BY order_id
)
SELECT
    CASE
        WHEN d.delay_days <= 0 THEN '1. On time'
        WHEN d.delay_days BETWEEN 1 AND 3 THEN '2. 1-3 days late'
        WHEN d.delay_days BETWEEN 4 AND 7 THEN '3. 4-7 days late'
        ELSE '4. 8+ days late'
    END AS delay_band,
    COUNT(*) AS orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM vw_deliveries d
JOIN reviews_per_order r ON r.order_id = d.order_id
WHERE d.order_purchase_timestamp >= '2017-01-01'
  AND d.order_purchase_timestamp <  '2018-09-01'
GROUP BY delay_band
ORDER BY delay_band;