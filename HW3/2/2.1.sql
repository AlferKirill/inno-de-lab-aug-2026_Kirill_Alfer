SELECT 
    c.first_name,  
    c.last_name,
    o.item,
    o.amount
    FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
