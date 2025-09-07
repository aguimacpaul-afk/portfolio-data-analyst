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
