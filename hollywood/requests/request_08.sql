/*
Para cada país, queremos saber qué categoría de películas generó más ingresos.
 */
--payment, remtal, inventory, film , film_category, category
create temp table revenue_per_category as 
select c.name as category, co.country, sum(p.amount) as total_money
from payment p
join rental r on p.rental_id = r.rental_id 
join inventory i on r.inventory_id = r.inventory_id  
join film_category fc on fc.film_id = i.film_id 
join category c on c.category_id =fc.category_id 
join customer cu on cu.customer_id = p.customer_id 
join address a on cu.address_id = a.address_id  
join city ci on ci.city_id = a.city_id 
join country co on co.country_id = ci.country_id 
group by c.name, co.country ;

SELECT country, category, total_money 
FROM (
    SELECT *, 
           dense_rank() OVER (PARTITION BY country ORDER BY total_money DESC) AS rnk
    FROM revenue_per_category
) t
WHERE rnk =1
ORDER BY country;
/*country                              |category|total_money|
-------------------------------------+--------+-----------+
Afghanistan                          |Sports  |  373404.66|
Algeria                              |Sports  |  2112768.0|
American Samoa                       |Sports  |   395377.7|
Angola                               |Sports  |  1188075.2|
Anguilla                             |Sports  |   587855.3|
Argentina                            |Sports  |  7913941.0|*/
