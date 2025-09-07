/*
Necesitamos identificar clientes “VIP”, definidos como:
	Han realizado al menos 30 alquileres en total.
	han gastado más de 200 en pagos.*/
select c.customer_id,  c.first_name ||' '|| c.last_name  as customer, count(r.customer_id ) as rents,
sum(p.amount) as total_payment
from customer c 
join rental r on c.customer_id = r.customer_id 
join payment p on c.customer_id = p.customer_id 
group by c.customer_id, customer, p.amount
having count(r.customer_id ) >= 300 and sum(p.amount) > 200
order by rents desc;
/*customer_id|customer          |rents|total_payment|
-----------+------------------+-----+-------------+
        148|ELEANOR HUNT      | 2208|    11018.237|
        236|MARCIA DEAN       | 2016|    6027.9795|
        526|KARL SEAL         | 1980|     9880.464|
        526|KARL SEAL         | 1980|     5920.331|
         91|LOIS BUTLER       | 1960|     9780.659|*/
