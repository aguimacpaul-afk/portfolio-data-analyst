/*“Necesito un reporte de cuántos clientes activos hay en cada ciudad, ordenado de mayor a menor.”*/

select ci.city, count(c.customer_id ) as active_user_counts
from customer c join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
where c.activebool = true
group by ci.city
order by active_user_counts desc limit 5;
/*city    |active_user_counts|
--------+------------------+
Aurora  |                 2|
London  |                 2|
Tokat   |                 1|
Mukateve|                 1|
Atlixco |                 1|*/

