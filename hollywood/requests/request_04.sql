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
