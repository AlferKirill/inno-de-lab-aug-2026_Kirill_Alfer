select 
item,
COUNT(*) as orders_count,
AVG(amount) as avg_amount
from Orders
group by item