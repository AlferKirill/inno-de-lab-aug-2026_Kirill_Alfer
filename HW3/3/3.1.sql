select 
country, 
COUNT(*) as customer_count 
from Customers
group by country