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
Algeria                              |        441|MARIO CHEATHAM       |         56|
Algeria                              |         69|JUDY GRAY            |         50|
American Samoa                       |        320|ANTHONY SCHWAB       |         40|
Angola                               |        383|MARTIN BALES         |         54|
Angola                               |        528|CLAUDE HERZOG        |         50|
Anguilla                             |        381|BOBBY BOUDREAU       |         70|
Argentina                            |         89|JULIA FLORES         |         64|
Argentina                            |        405|LEONARD SCHOFIELD    |         64|
Argentina                            |        560|JORDAN ARCHULETA     |         60|
Argentina                            |        107|FLORENCE WOODS       |         60|
Argentina                            |        322|JASON MORRISSEY      |         56|
Armenia                              |         41|STEPHANIE MITCHELL   |         50|
Austria                              |        173|AUDREY RAY           |         58|
Austria                              |        266|NORA HERRERA         |         56|
Austria                              |        159|JILL HAWKINS         |         42|
Azerbaijan                           |        334|RAYMOND MCWHORTER    |         60|
Azerbaijan                           |        333|ANDREW PURDY         |         54|
Bahrain                              |        590|SETH HANNON          |         50|
Bangladesh                           |         21|MICHELLE CLARK       |         70|
Bangladesh                           |        329|FRANK WAGGONER       |         64|
Bangladesh                           |        332|STEPHEN QUALLS       |         56|
Belarus                              |        144|CLARA SHAW           |         84|
Belarus                              |        527|CORY MEEHAN          |         48|
Bolivia                              |        455|JON WILES            |         48|
Bolivia                              |        431|JOEL FRANCISCO       |         46|
Brazil                               |        178|MARION SNYDER        |         78|
Brazil                               |        354|JUSTIN NGO           |         72|
Brazil                               |        314|GEORGE LINTON        |         66|
Brunei                               |         91|LOIS BUTLER          |         70|
Bulgaria                             |        215|JESSIE BANKS         |         52|
Bulgaria                             |        540|TYRONE ASHER         |         48|
Cambodia                             |        228|ALLISON STANLEY      |         54|
Cambodia                             |        516|ELMER NOE            |         52|
Cameroon                             |        361|LAWRENCE LAWTON      |         62|
Cameroon                             |        352|ALBERT CROUSE        |         46|
Canada                               |        410|CURTIS IRBY          |         76|
Canada                               |        436|TROY QUIGLEY         |         60|
Canada                               |        463|DARRELL POWER        |         50|
Chad                                 |        535|JAVIER ELROD         |         64|
Chile                                |        515|ANDRE RAPP           |         56|
Chile                                |         45|JANET PHILLIPS       |         54|
Chile                                |        464|JEROME KENYON        |         32|
China                                |        197|SUE PETERS           |         80|
China                                |        267|MARGIE WADE          |         72|
China                                |        211|STACEY MONTGOMERY    |         68|
China                                |        241|HEIDI LARSON         |         68|
China                                |        168|REGINA BERRY         |         68|
China                                |        138|HAZEL WARREN         |         68|
China                                |        129|CARRIE PORTER        |         68|
Colombia                             |        120|SYLVIA ORTIZ         |         64|
Colombia                             |         87|WANDA PATTERSON      |         60|
Colombia                             |        460|LEON BOSTIC          |         50|
Colombia                             |        235|JACKIE LYNCH         |         50|
Congo, The Democratic Republic of the|        387|JESSE SCHILLING      |         52|
Congo, The Democratic Republic of the|        375|AARON SELBY          |         48|
Czech Republic                       |        265|JENNIE TERRY         |         58|
Dominican Republic                   |        418|JEFF EAST            |         60|
Dominican Republic                   |        258|MYRTLE FLEMING       |         48|
Dominican Republic                   |        437|RANDALL NEUMANN      |         46|
Ecuador                              |        494|RAMON CHOATE         |         62|
Ecuador                              |        589|TRACY HERRMANN       |         56|
Ecuador                              |        262|PATSY DAVIDSON       |         56|
Egypt                                |        119|SHERRY MARSHALL      |         68|
Egypt                                |        559|EVERETT BANDA        |         56|
Egypt                                |        491|RICK MATTOX          |         54|
Estonia                              |        444|MARCUS HIDALGO       |         60|
Ethiopia                             |        392|SEAN DOUGLASS        |         46|
Faroe Islands                        |        317|EDWARD BAUGH         |         56|
Finland                              |        298|ERIKA PENA           |         52|
France                               |         35|VIRGINIA GREEN       |         64|
France                               |        104|RITA GRAHAM          |         48|
France                               |        402|LUIS YANEZ           |         40|
France                               |        162|LAUREN HUDSON        |         40|
French Guiana                        |         65|ROSE HOWARD          |         44|
French Polynesia                     |         56|GLORIA COOK          |         60|
French Polynesia                     |         43|CHRISTINE ROBERTS    |         48|
Gambia                               |        584|SALVADOR TEEL        |         60|
Germany                              |        196|ALMA AUSTIN          |         70|
Germany                              |        114|GRACE ELLIS          |         66|
Germany                              |        251|VICKIE BREWER        |         62|
Greece                               |        596|ENRIQUE FORSYTHE     |         56|
Greece                               |          3|LINDA WILLIAMS       |         52|
Greenland                            |        207|GERTRUDE CASTILLO    |         68|
Holy See (Vatican City State)        |         26|JESSICA HALL         |         68|
Hong Kong                            |        289|VIOLET RODRIQUEZ     |         60|
Hungary                              |        592|TERRANCE ROUSH       |         58|
India                                |        468|TIM CARY             |         78|
India                                |        274|NAOMI JENNINGS       |         70|
India                                |        403|MIKE WAY             |         70|
India                                |        502|BRETT CORNWELL       |         68|
Indonesia                            |        506|LESLIE SEWARD        |         70|
Indonesia                            |        239|MINNIE ROMERO        |         68|
Indonesia                            |        473|JORGE OLIVARES       |         68|
Indonesia                            |        372|STEVE MACKENZIE      |         68|
Indonesia                            |        500|REGINALD KINDER      |         56|
Iran                                 |        459|TOMMY COLLAZO        |         76|
Iran                                 |        368|HARRY ARCE           |         70|
Iran                                 |        279|DIANNE SHELTON       |         62|
Iraq                                 |        579|DARYL LARUE          |         54|
Israel                               |        102|CRYSTAL FORD         |         66|
Israel                               |        161|GERALDINE PERKINS    |         60|
Israel                               |        478|LEWIS LYMAN          |         38|
Italy                                |        439|ALEXANDER FENNELL    |         72|
Italy                                |        309|CHRISTOPHER GRECO    |         62|
Italy                                |        499|MARC OUTLAW          |         60|
Japan                                |         29|ANGELA HERNANDEZ     |         72|
Japan                                |        147|JOANNE ROBERTSON     |         68|
Japan                                |        503|ANGEL BARCLAY        |         64|
Japan                                |        141|DEBBIE REYES         |         64|
Japan                                |          1|MARY SMITH           |         64|
Kazakstan                            |        573|BYRON BOX            |         58|
Kazakstan                            |         76|IRENE PRICE          |         46|
Kenya                                |        363|ROY WHITING          |         58|
Kenya                                |        193|KATIE ELLIOTT        |         50|
Kuwait                               |        234|CLAUDIA FULLER       |         52|
Latvia                               |        347|RYAN SALISBURY       |         60|
Latvia                               |         23|SARAH LEWIS          |         60|
Liechtenstein                        |         57|EVELYN MORGAN        |         56|
Lithuania                            |        557|FELIX GAFFNEY        |         48|
Madagascar                           |         81|ANDREA HENDERSON     |         44|
Malawi                               |        166|LYNN PAYNE           |         56|
Malaysia                             |        306|CHARLES KOWALSKI     |         64|
Malaysia                             |         58|JEAN BELL            |         54|
Malaysia                             |        171|DOLORES WAGNER       |         52|
Mexico                               |        273|PRISCILLA LOWE       |         70|
Mexico                               |        451|JIM REA              |         66|
Mexico                               |         84|SARA PERRY           |         66|
Mexico                               |        454|ALEX GRESHAM         |         66|
Mexico                               |        323|MATTHEW MAHAN        |         62|
Moldova                              |         38|MARTHA GONZALEZ      |         68|
Morocco                              |         40|AMANDA CARTER        |         54|
Morocco                              |         22|LAURA RODRIGUEZ      |         44|
Morocco                              |        543|LANCE PEMBERTON      |         44|
Mozambique                           |        257|MARSHA DOUGLAS       |         74|
Mozambique                           |        433|DON BONE             |         50|
Mozambique                           |         97|ANNIE RUSSELL        |         36|
Myanmar                              |        256|MABEL HOLLAND        |         60|
Myanmar                              |          4|BARBARA JONES        |         44|
Nauru                                |        513|DUANE TUBBS          |         62|
Nepal                                |        321|KEVIN SCHULER        |         44|
Netherlands                          |        137|RHONDA KENNEDY       |         78|
Netherlands                          |        474|DUSTIN GILLETTE      |         52|
Netherlands                          |        415|GLENN PULLEN         |         46|
Netherlands                          |        184|VIVIAN RUIZ          |         46|
Netherlands                          |        341|PETER MENARD         |         46|
New Zealand                          |          8|SUSAN WILSON         |         48|
Nigeria                              |        198|ELSIE KELLEY         |         74|
Nigeria                              |        277|OLGA JIMENEZ         |         64|
Nigeria                              |        103|GLADYS HAMILTON      |         62|
North Korea                          |        157|DARLENE ROSE         |         62|
Oman                                 |        498|GENE SANBORN         |         54|
Oman                                 |          9|MARGARET MOORE       |         46|
Pakistan                             |        416|JEFFERY PINSON       |         62|
Pakistan                             |         20|SHARON ROBINSON      |         60|
Pakistan                             |         25|DEBORAH WALKER       |         58|
Paraguay                             |        345|CARL ARTIS           |         46|
Paraguay                             |        226|MAUREEN LITTLE       |         42|
Paraguay                             |        205|EILEEN CARR          |         36|
Peru                                 |        122|THELMA MURRAY        |         64|
Peru                                 |        565|JAIME NETTLES        |         58|
Peru                                 |        304|DAVID ROYAL          |         52|
Philippines                          |        236|MARCIA DEAN          |         84|
Philippines                          |        373|LOUIS LEONE          |         70|
Philippines                          |        371|BILLY POULIN         |         70|
Philippines                          |        522|ARNOLD HAVENS        |         66|
Poland                               |        380|RUSSELL BRINSON      |         72|
Poland                               |        128|MARJORIE TUCKER      |         64|
Poland                               |        558|JIMMIE EGGLESTON     |         56|
Puerto Rico                          |        360|RALPH MADRIGAL       |         68|
Puerto Rico                          |        282|JENNY CASTRO         |         54|
Romania                              |        230|JOY GEORGE           |         66|
Romania                              |        563|KEN PREWITT          |         58|
Runion                               |        148|ELEANOR HUNT         |         92|
Russian Federation                   |        295|DAISY BATES          |         76|
Russian Federation                   |         46|CATHERINE CAMPBELL   |         68|
Russian Federation                   |        462|WARREN SHERROD       |         66|
Saint Vincent and the Grenadines     |        326|JOSE ANDREW          |         50|
Saudi Arabia                         |         49|JOYCE EDWARDS        |         56|
Saudi Arabia                         |        312|MARK RINEHART        |         52|
Saudi Arabia                         |        417|TRAVIS ESTEP         |         50|
Senegal                              |        456|RONNIE RICKETTS      |         50|
Slovakia                             |        357|KEITH RICO           |         52|
South Africa                         |        125|ETHEL WEBB           |         64|
South Africa                         |        132|ESTHER CRAWFORD      |         56|
South Africa                         |        338|DENNIS GILMAN        |         56|
South Africa                         |        145|LUCILLE HOLMES       |         56|
South Africa                         |        471|DEAN SAUER           |         54|
South Africa                         |        407|DALE RATCLIFF        |         54|
South Korea                          |        237|TANYA GILBERT        |         66|
South Korea                          |        245|COURTNEY DAY         |         64|
South Korea                          |        536|FERNANDO CHURCHILL   |         50|
Spain                                |        469|WESLEY BULL          |         80|
Spain                                |        293|MAE FLETCHER         |         62|
Spain                                |         52|JULIE SANCHEZ        |         58|
Sri Lanka                            |        408|MANUEL MURRELL       |         60|
Sudan                                |         50|DIANE COLLINS        |         70|
Sudan                                |        395|JOHNNY TURPIN        |         38|
Sweden                               |         66|JANICE WARD          |         68|
Switzerland                          |        155|GAIL KNIGHT          |         50|
Switzerland                          |        598|WADE DELVALLE        |         44|
Switzerland                          |         61|KATHERINE RIVERA     |         28|
Taiwan                               |         75|TAMMY SANDERS        |         82|
Taiwan                               |          5|ELIZABETH BROWN      |         76|
Taiwan                               |        348|ROGER QUINTANILLA    |         72|
Tanzania                             |        481|HERMAN DEVORE        |         58|
Tanzania                             |        220|CHARLENE ALVAREZ     |         54|
Tanzania                             |        190|YOLANDA WEAVER       |         54|
Thailand                             |         86|JACQUELINE LONG      |         66|
Thailand                             |        390|SHAWN HEATON         |         66|
Thailand                             |         42|CAROLYN PEREZ        |         60|
Tonga                                |        344|HENRY BILLINGSLEY    |         36|
Tunisia                              |        335|GREGORY MAULDIN      |         46|
Turkey                               |        366|BRANDON HUEY         |         74|
Turkey                               |        204|ROSEMARY SCHMIDT     |         70|
Turkey                               |        566|CASEY MENA           |         68|
Turkmenistan                         |        200|JEANNE LAWSON        |         54|
Tuvalu                               |        105|DAWN SULLIVAN        |         52|
Ukraine                              |        131|MONICA HICKS         |         60|
Ukraine                              |        386|TODD TAN             |         58|
Ukraine                              |        187|BRITTANY RILEY       |         56|
United Arab Emirates                 |        452|TOM MILNER           |         64|
United Arab Emirates                 |        292|MISTY LAMBERT        |         54|
United Arab Emirates                 |         98|LILLIAN GRIFFIN      |         50|
United Kingdom                       |        497|GILBERT SLEDGE       |         56|
United Kingdom                       |         16|SANDRA MARTIN        |         56|
United Kingdom                       |        142|APRIL BURNS          |         52|
United Kingdom                       |        512|CECIL VINES          |         52|
United Kingdom                       |         85|ANNE POWELL          |         46|
United Kingdom                       |        583|MARSHALL THORN       |         46|
United States                        |        526|KARL SEAL            |         90|
United States                        |        181|ANA BRADLEY          |         68|
United States                        |         51|ALICE STEWART        |         66|
Venezuela                            |        113|CINDY FISHER         |         58|
Venezuela                            |        290|KRISTINA CHAMBERS    |         56|
Venezuela                            |        111|CARMEN OWENS         |         52|
Vietnam                              |        532|NEIL RENNER          |         64|
Vietnam                              |        520|MITCHELL WESTMORELAND|         64|
Vietnam                              |        340|PATRICK NEWSOM       |         62|
Vietnam                              |        472|GREG ROBINS          |         60|
Virgin Islands, U.S.                 |        406|NATHAN RUNYON        |         64|
Yemen                                |        470|GORDON ALLARD        |         64|
Yemen                                |        210|ELLA OLIVER          |         62|
Yemen                                |        213|GINA WILLIAMSON      |         56|
Yugoslavia                           |          7|MARIA MILLER         |         66|
Yugoslavia                           |        553|MAX PITT             |         48|
Zambia                               |        438|BARRY LOVELACE       |         66|*/

