SELECT 
    o.order_id,
    c.customer_id,
    o.item,
    o.amount,
    c.first_name,
    c.last_name,
    SUM(o.amount) OVER (PARTITION BY o.customer_id) AS total_by_customer
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id;