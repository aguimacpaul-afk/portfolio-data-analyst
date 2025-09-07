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

