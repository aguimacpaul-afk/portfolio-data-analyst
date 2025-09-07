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

/*“Quiero un listado de todas las películas junto con su categoría correspondiente.”*/

select f.title, c.name as category from film f
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
order by category, f.title limit 5;

/*title             |category|
------------------+--------+
AMADEUS HOLY      |Action  |
AMADEUS HOLY      |Action  |
AMERICAN CIRCUS   |Action  |
AMERICAN CIRCUS   |Action  |
ANTITRUST TOMATOES|Action  |*/

/*“Haz un ranking de los actores con más películas.”*/
select a.first_name ||' '|| a.last_name as actor_name, count(f.film_id ) as film_count from actor a
join film_actor fa on fa.actor_id = a.actor_id 
join film f on f.film_id = fa.film_id 
group by actor_name  
order by film_count desc, actor_name limit 5 ;
 /*
 actor_name    |film_count|
--------------+----------+
SUSAN DAVIS   |        54|
GINA DEGENERES|        42|
WALTER TORN   |        41|
MARY KEITEL   |        40|
MATTHEW CARREY|        39|*/

/*“Identifica clientes que no han realizado un alquiler en los últimos 6 meses.”*/

WITH cutoff AS (
    SELECT (max(r.rental_date)::date - INTERVAL '6 months')::date AS cutoff_date
    from rental r 
)
SELECT c.customer_id, c.first_name, c.email, c.last_name,cutoff_date,
       (SELECT MAX(r.rental_date)
        FROM rental r
        WHERE r.customer_id = c.customer_id) AS last_rental_date
FROM customer c, cutoff co
WHERE NOT EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.customer_id = c.customer_id
      AND r.rental_date::date > co.cutoff_date
);
--No existen registros con esas condiciones

/*Necesitamos saber en qué países tenemos más ingresos por alquiler.
Devuelve un ranking (posición, país, ingresos totales).*/
-- payment , customer , store , addres , city , country

SELECT co.country, SUM(p.amount) AS total_amount
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
GROUP BY co.country
order by total_amount desc;
/*country                              |total_amount|
-------------------------------------+------------+
India                                |   13261.038|
China                                |   11605.885|
United States                        |    8220.858|
Japan                                |    6943.629|
Mexico                               |    6614.213|
Brazil                               |    6401.159|*/

/*Queremos conocer a los 10 actores que más han participado en películas alquiladas.*/
--actor_id ,  film_actor_id , film_id, inventory_id, inventory_id

select a.first_name, a.last_name, count(distinct f.film_id ) as count from actor a 
join film_actor fa on fa.actor_id = a.actor_id 
join film f on fa.film_id = f.film_id 
join inventory i on i.film_id = f.film_id 
join rental r on r.inventory_id = i.inventory_id 
group by a.first_name , a.last_name 
order by count desc
/*first_name |last_name   |count|
-----------+------------+-----+
SUSAN      |DAVIS       |   53|
GINA       |DEGENERES   |   42|
MARY       |KEITEL      |   40|
WALTER     |TORN        |   39|
MATTHEW    |CARREY      |   37|
SANDRA     |KILMER      |   36|*/


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

/*Queremos saber los 3 clientes que más alquileres hicieron en cada país.*/
-- customer, rental
-- customer, address, city, country
drop table if exists countrys_top;
create temp table countrys_top as
select c.customer_id, c.first_name ||' '||c.last_name as customer_name, count(r.rental_id) as rental_rate,
co.country
from customer c 
join rental r on r.customer_id =c.customer_id
join address a on c.address_id = a.address_id 
join city ci on ci.city_id = a.city_id 
join country co on co.country_id = ci.country_id  
group by c.customer_id, customer_name, co.country   ;

select  country, customer_id, customer_name, rental_rate from 
(select *, dense_rank() over (partition by country order by rental_rate desc) as rnk
from countrys_top)t
where rnk<4
order by country, rental_rate desc; 
/*country                              |customer_id|customer_name        |rental_rate|
-------------------------------------+-----------+---------------------+-----------+
Afghanistan                          |        218|VERA MCCOY           |         36|
Algeria                              |        176|JUNE CARROLL         |         74|
Algeria                              |        441|MARIO CHEATHAM       |         56|*/

/*Queremos identificar las 5 películas más rentadas en cada país y cuánto dinero generaron en total.*/
--country, film_title, total_rentals, total_money.
--rental , payment

drop table if exists rentals_top;
create temp table rentals_top as
select co.country, f.title, count(r.rental_id ) as total_rental, sum(p.amount) as total_money
from film f
join inventory i on f.film_id = i.film_id  
join rental r on r.inventory_id = i.inventory_id 
join payment p on p.rental_id = r.rental_id 
join customer cu on cu.customer_id = p.customer_id 
join address a on a.address_id = cu.address_id 
join city ci on ci.city_id = a.city_id 
join country co on ci.country_id = co.country_id 
group by co.country, f.title
order by co.country

select country, title, total_rental, total_money from(
select *, dense_rank() over (partition by country order by total_money desc)
as rnk from rentals_top)t
where rnk <6
order by country , total_money desc;
