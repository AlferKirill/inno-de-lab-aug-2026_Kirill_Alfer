select 
first_name,
last_name,
amount
from Customers
join Orders on Orders.customer_id = Customers.customer_id
where orders.amount = (select MAX(amount) from Orders)