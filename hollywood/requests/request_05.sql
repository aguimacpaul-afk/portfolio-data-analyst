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
