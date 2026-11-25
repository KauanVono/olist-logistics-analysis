-- View: one review score per order (average when an order has more than one review)
CREATE OR REPLACE VIEW vw_order_reviews AS
SELECT
    order_id,
    AVG(review_score) AS review_score
FROM order_reviews
GROUP BY order_id;


SELECT * FROM vw_order_reviews LIMIT 10;