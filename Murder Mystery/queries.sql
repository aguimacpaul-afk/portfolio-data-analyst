/*Clientes fitness activos
Encuentra todos los miembros de get_fit_now_member que hayan hecho más de 10 check-ins 
en get_fit_now_check_in.*/
/*id - membership_id*/
select m.id as member_id, m.name, count(n.check_in_date) as total_checkins
from get_fit_now_member m
join get_fit_now_check_in n on m.id = n.membership_id
group by m.id, m.name
having count(n.check_in_date) >10
order by total_checkins desc Limit 5;
/*
member_id|name          |total_checkins|
---------+--------------+--------------+
XTE42    |Sarita Bartosh|            30|
X1IYH    |Tu Lipkovitch |            30|
C84S4    |Mervin Eacret |            30|
C581L    |Monty Torrico |            30|
S702J    |Ladawn Boards |            30|*/

/*Personas con ingresos altos
De la tabla income, selecciona las personas con ingresos por encima del percentil 90. 
Cruza los datos con person para mostrar sus nombres y dirección.
ssn
**/
with p90 as (
	select 
		PERCENTILE_CONT(0.9) within group (order by i.annual_income) as cutoff
		from income i
)
select p.name, p.address_number, p.address_street_name, i.annual_income from person p 
join income i on p.ssn = i.ssn 
CROSS JOIN p90
WHERE i.annual_income > p90.cutoff;
/*
name               |address_number|address_street_name|annual_income|
-------------------+--------------+-------------------+-------------+
Sandy Braim        |          1844|Gigi Blvd          |        88500|
Candra Laguardia   |          2839|Trevelyan Ave      |        88800|
Dominique Kelcourse|          1592|South Baybrook Blvd|        89300|
Alysha Laba        |          1036|Pala Ave           |       324300|
Rogelio Trullinger |          1462|Sherando Way       |        88300|*/

/*Eventos más concurridos
Usa la tabla facebook_event_checkin para encontrar los 3 eventos con mayor número de asistentes distintos.
(Pista: COUNT(DISTINCT ...) + ORDER BY LIMIT)*/

select event_name, count(distinct person_id) as num_asistentes
from facebook_event_checkin fec 
group by event_name 
order by num_asistentes desc
/*
event_name                     |num_asistentes|
-------------------------------+--------------+
¶                              |           278|
                -- Mark Twain¶ |           139|
                -- Oscar Wilde¶|           103|
SQL Symphony Concert           |            89|
We wish you a Hare Krishna¶    |            67|*/
/*
Personas con múltiples licencias
Detecta personas en drivers_license que tengan más de una licencia registrada.
(Pista: GROUP BY person_id HAVING COUNT(*) > 1)*/
select id, count(distinct p.license_id ) from person p  
group by p.id  
having count(distinct p.license_id)  > 1
/*
	id|count|
--+-----+
*/

/*Cruce sospechoso
Combina crime_scene_report con person para listar a las personas que vivan en la misma calle
donde ocurrió un crimen.
(Pista: LIKE en la dirección + JOIN)*/

select p.name , p.address_number, p.address_street_name, csr.date, csr.type, csr.city    
from person p join crime_scene_report csr 
on p.address_street_name like '%'||csr.city||'%'
/*
name            |address_number|address_street_name    |date    |type     |city      |
----------------+--------------+-----------------------+--------+---------+----------+
Cory Rodriquz   |          2024|Montgomery Rd          |20170202|smuggling|Montgomery|
Cory Rodriquz   |          2024|Montgomery Rd          |20170203|smuggling|Montgomery|
Cory Rodriquz   |          2024|Montgomery Rd          |20170205|robbery  |Montgomery|
Cory Rodriquz   |          2024|Montgomery Rd          |20170403|fraud    |Montgomery|
Charity Bleicher|          2550|Thomas Jefferson Circle|20170207|arson    |Jefferson |*/

/*
Ranking de ingresos por ciudad
Haz un ranking de las personas por nivel de ingreso dentro de cada ciudad.
(Pista: RANK() OVER (PARTITION BY city ORDER BY income DESC))
*/
SELECT 
    c.city,
    p.name,
    i.annual_income,
    RANK() OVER (
        PARTITION BY c.city
        ORDER BY i.annual_income DESC
    ) AS ranking
FROM 
    person p
JOIN 
    income i 
    ON p.ssn = i.ssn
JOIN 
    crime_scene_report c
    ON p.address_street_name LIKE '%' || c.city || '%'
ORDER BY 
    ranking;
/*
city  |name           |annual_income|ranking|
------+---------------+-------------+-------+
Akron |Dean Threlkeld |        53800|      1|
Akron |Dean Threlkeld |        53800|      1|
Akron |Dean Threlkeld |        53800|      1|
Albany|Dwight Mcvinney|        12800|      1|
Akron |Dean Threlkeld |        53800|      1|*/
/*Entrevistas relacionadas con un crimen
Une interview con crime_scene_report para encontrar entrevistas de personas relacionadas con 
un crimen ocurrido en la misma fecha.*/

select * from interview i ;
select * from crime_scene_report csr ;
select * from person p;


select i.transcript, csr.date, csr.type, csr.description, p.name  from interview i 
join person p on i.person_id = p.id
JOIN crime_scene_report csr
    ON p.address_street_name LIKE '%' || csr.description || '%'; 
/*
transcript|date|type|description|name|
----------+----+----+-----------+----+*/



