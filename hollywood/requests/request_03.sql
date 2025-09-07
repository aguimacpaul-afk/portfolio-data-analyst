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
