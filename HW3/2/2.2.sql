SELECT	  
    c.last_name,
    c.first_name,
    s.status
    from Customers c
    join Shippings s on s.customer = c.customer_id