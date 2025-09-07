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
 /*country                              |title                      |total_rental|total_money|
-------------------------------------+---------------------------+------------+-----------+
Afghanistan                          |PARK CITIZEN               |           8|   71.91999|
Afghanistan                          |BUTTERFLY CHOCOLAT         |           8|   55.91999|
Afghanistan                          |HOPE TOOTSIE               |           8|   55.91999|
Afghanistan                          |QUEEN LUKE                 |           8|   55.91999|
Afghanistan                          |MASK PEACH                 |           8|      47.92|
Afghanistan                          |JERK PAYCHECK              |           8|      47.92|
Afghanistan                          |BORN SPINAL                |           8|      39.92|
Afghanistan                          |SATURN NAME                |           8|      39.92|
Afghanistan                          |HAUNTING PIANIST           |           8|      23.92|
Afghanistan                          |LONELY ELEPHANT            |           8|      23.92|
Afghanistan                          |DISTURBING SCARFACE        |           8|      23.92|
Algeria                              |GROUNDHOG UNCUT            |          16|   95.83998|
Algeria                              |ZORRO ARK                  |           8|   87.91999|
Algeria                              |RAGE GAMES                 |           8|   71.91999|
Algeria                              |MEMENTO ZOOLANDER          |           8|   71.91999|
Algeria                              |SATISFACTION CONFIDENTIAL  |           8|   71.91999|
Algeria                              |SNATCH SLIPPER             |           8|   63.91999|
Algeria                              |HANGING DEEP               |           8|   63.91999|
Algeria                              |DOGMA FAMILY               |           8|   63.91999|
Algeria                              |JEKYLL FROGMEN             |           8|   63.91999|
Algeria                              |HANKY OCTOBER              |           8|   55.91999|
Algeria                              |WHISPERER GIANT            |           8|   55.91999|
Algeria                              |PURE RUNNER                |           8|   55.91999|
Algeria                              |ARMY FLINTSTONES           |           8|   55.91999|
Algeria                              |CONEHEADS SMOOCHY          |           8|   55.91999|
Algeria                              |CAROL TEXAS                |           8|   55.91999|
Algeria                              |MOVIE SHAKESPEARE          |           8|   55.91999|
American Samoa                       |CAT CONEHEADS              |           8|   63.91999|
American Samoa                       |GAMES BOWFINGER            |           8|      39.92|
American Samoa                       |AGENT TRUMAN               |           8|      39.92|
American Samoa                       |DYNAMITE TARZAN            |           8|      39.92|
American Samoa                       |FIDELITY DEVIL             |           8|      39.92|
American Samoa                       |SCARFACE BANG              |           8|      39.92|
American Samoa                       |SECRETARY ROUGE            |           8|      39.92|
American Samoa                       |TRIP NEWTON                |           8|      39.92|
American Samoa                       |WORKING MICROCOSMOS        |           8|      39.92|
American Samoa                       |GANGS PRIDE                |           8|      31.92|
American Samoa                       |TROUBLE DATE               |           8|      31.92|
American Samoa                       |KRAMER CHOCOLATE           |           8|      23.92|
American Samoa                       |VACATION BOONDOCK          |           8|      23.92|
American Samoa                       |ARTIST COLDBLOODED         |           8|      23.92|
American Samoa                       |PIRATES ROXANNE            |           8|  15.919999|
Angola                               |KNOCK WARLOCK              |          16|  103.83998|
Angola                               |AMERICAN CIRCUS            |           8|   79.91999|
Angola                               |INTERVIEW LIAISONS         |           8|   71.91999|
Angola                               |TUXEDO MILE                |           8|   71.91999|
Angola                               |BREAKFAST GOLDFINGER       |           8|   63.91999|
Angola                               |JINGLE SAGEBRUSH           |           8|   63.91999|
Angola                               |METROPOLIS COMA            |           8|   63.91999|
Angola                               |CHAMPION FLATLINERS        |           8|   55.91999|
Angola                               |MALTESE HOPE               |           8|   55.91999|
Anguilla                             |SEATTLE EXPECATIONS        |           8|   71.91999|
Anguilla                             |CONTACT ANONYMOUS          |          16|  47.840008|
Anguilla                             |FORWARD TEMPLE             |           8|      39.92|
Anguilla                             |COMA HEAD                  |           8|      39.92|
Anguilla                             |MULAN MOON                 |           8|      39.92|
Anguilla                             |WITCHES PANIC              |           8|      39.92|
Anguilla                             |DESTINY SATURDAY           |           8|      39.92|
Anguilla                             |INCH JET                   |           8|      39.92|
Anguilla                             |WEEKEND PERSONAL           |           8|      39.92|
Anguilla                             |BUCKET BROTHERHOOD         |           8|      39.92|
Anguilla                             |HOLY TADPOLE               |           8|      31.92|
Anguilla                             |WRONG BEHAVIOR             |           8|      23.92|
Anguilla                             |BARBARELLA STREETCAR       |           8|      23.92|
Anguilla                             |BEAR GRACELAND             |           8|      23.92|
Anguilla                             |BERETS AGENT               |           8|      23.92|
Anguilla                             |CITIZEN SHREK              |           8|      23.92|
Anguilla                             |DETECTIVE VISION           |           8|      23.92|
Anguilla                             |DINOSAUR SECRETARY         |           8|      23.92|
Anguilla                             |INSIDER ARIZONA            |           8|      23.92|
Anguilla                             |LUCKY FLYING               |           8|      23.92|
Anguilla                             |PACKER MADIGAN             |           8|      23.92|
Anguilla                             |SPINAL ROCKY               |           8|      23.92|
Anguilla                             |WON DARES                  |           8|      23.92|
Argentina                            |CALENDAR GUNFIGHT          |          24|  159.76001|
Argentina                            |PRINCESS GIANT             |          24|  143.75998|
Argentina                            |EYES DRIVING               |          24|  143.75998|
Argentina                            |PITY BOUND                 |          16|  127.83997|
Argentina                            |MERMAID INSECTS            |          16|  111.83997|
Argentina                            |HEAVYWEIGHTS BEAST         |          16|  103.83998|
Armenia                              |NIGHTMARE CHILL            |           8|   79.91999|
Armenia                              |ROAD ROXANNE               |           8|   63.91999|
Armenia                              |WEST LION                  |           8|   63.91999|
Armenia                              |CONFUSED CANDLES           |           8|   63.91999|
Armenia                              |IMAGE PRINCESS             |           8|   55.91999|
Armenia                              |GOODFELLAS SALUTE          |           8|   55.91999|
Armenia                              |MODERN DORADO              |           8|      47.92|
Armenia                              |THIEF PELICAN              |           8|      47.92|
Armenia                              |JERICHO MULAN              |           8|      39.92|
Armenia                              |DAISY MENAGERIE            |           8|      39.92|
Armenia                              |MISSION ZOOLANDER          |           8|      39.92|
Armenia                              |HOLES BRANNIGAN            |           8|      39.92|
Armenia                              |MEET CHOCOLATE             |           8|      39.92|
Armenia                              |PINOCCHIO SIMON            |           8|      39.92|
Austria                              |SNATCH SLIPPER             |          16|   87.83998|
Austria                              |HARRY IDAHO                |           8|   71.91999|
Austria                              |SONS INTERVIEW             |           8|   71.91999|
Austria                              |FLASH WARS                 |           8|   71.91999|
Austria                              |INTENTIONS EMPIRE          |           8|   71.91999|
Austria                              |NUTS TIES                  |           8|   63.91999|
Austria                              |HYDE DOCTOR                |           8|   63.91999|
Austria                              |STRANGERS GRAFFITI         |           8|   55.91999|
Austria                              |BALLOON HOMEWARD           |           8|   55.91999|
Austria                              |SHOW LORD                  |           8|   55.91999|
Austria                              |AFRICAN EGG                |           8|      47.92|
Austria                              |JEEPERS WEDDING            |           8|      47.92|
Austria                              |TIMBERLAND SKY             |           8|      47.92|
Austria                              |MERMAID INSECTS            |           8|      47.92|
Austria                              |LORD ARIZONA               |           8|      47.92|
Austria                              |CONEHEADS SMOOCHY          |           8|      47.92|
Azerbaijan                           |TITANIC BOONDOCK           |          16|  103.83998|
Azerbaijan                           |COLDBLOODED DARLING        |          16|   95.83997|
Azerbaijan                           |FLINTSTONES HAPPINESS      |           8|   87.91999|
Azerbaijan                           |WONDERFUL DROP             |           8|   71.91999|
Azerbaijan                           |BETRAYED REAR              |           8|   63.91999|
Azerbaijan                           |GOSFORD DONNIE             |           8|   63.91999|
Bahrain                              |EAGLES PANKY               |           8|   79.91999|
Bahrain                              |CHARADE DUFFEL             |           8|   63.91999|
Bahrain                              |PICKUP DRIVING             |           8|   55.91999|
Bahrain                              |SUSPECTS QUILLS            |           8|      47.92|
Bahrain                              |ATLANTIS CAUSE             |           8|      47.92|
Bahrain                              |DOUBTFIRE LABYRINTH        |           8|      39.92|
Bahrain                              |BUCKET BROTHERHOOD         |           8|      39.92|
Bahrain                              |CALIFORNIA BIRDS           |           8|      39.92|
Bahrain                              |CENTER DINOSAUR            |           8|      39.92|
Bahrain                              |MADRE GABLES               |           8|      39.92|
Bahrain                              |PATHS CONTROL              |           8|      39.92|
Bahrain                              |PHILADELPHIA WIFE          |           8|      39.92|
Bahrain                              |SHOW LORD                  |           8|      39.92|
Bahrain                              |SOLDIERS EVOLUTION         |           8|      39.92|
Bangladesh                           |MOONWALKER FOOL            |          16|  111.83997|
Bangladesh                           |PATTON INTERVIEW           |          24|  111.75998|
Bangladesh                           |WAGON JAWS                 |          24|  103.75998|
Bangladesh                           |TRAP GUYS                  |           8|   87.91999|
Bangladesh                           |STRANGERS GRAFFITI         |           8|   79.91999|
Belarus                              |FOOL MOCKINGBIRD           |           8|   79.91999|
Belarus                              |IMAGE PRINCESS             |           8|   71.91999|
Belarus                              |DARKO DORADO               |           8|   71.91999|
Belarus                              |PREJUDICE OLEANDER         |           8|   63.91999|
Belarus                              |SAGEBRUSH CLUELESS         |           8|   63.91999|
Belarus                              |SUGAR WONKA                |           8|   63.91999|
Belarus                              |PARK CITIZEN               |           8|   63.91999|
Belarus                              |STATE WASTELAND            |           8|   63.91999|
Belarus                              |STRANGER STRANGERS         |           8|   63.91999|
Belarus                              |LOLA AGENT                 |           8|   63.91999|
Belarus                              |HARRY IDAHO                |           8|   55.91999|
Belarus                              |EASY GLADIATOR             |           8|   55.91999|
Belarus                              |CLOSER BANG                |           8|   55.91999|
Belarus                              |WAIT CIDER                 |           8|   55.91999|
Belarus                              |AGENT TRUMAN               |           8|   55.91999|
Belarus                              |QUEEN LUKE                 |           8|      47.92|
Belarus                              |PAPI NECKLACE              |           8|      47.92|
Belarus                              |AIRPORT POLLOCK            |           8|      47.92|
Belarus                              |SABRINA MIDNIGHT           |           8|      47.92|
Belarus                              |REQUIEM TYCOON             |           8|      47.92|
Bolivia                              |PANKY SUBMARINE            |           8|   71.91999|
Bolivia                              |BETRAYED REAR              |           8|   71.91999|
Bolivia                              |UNBREAKABLE KARATE         |           8|   55.91999|
Bolivia                              |INTERVIEW LIAISONS         |           8|   55.91999|
Bolivia                              |PELICAN COMFORTS           |           8|   55.91999|
Bolivia                              |SEARCHERS WAIT             |           8|   55.91999|
Bolivia                              |VAMPIRE WHALE              |           8|      47.92|
Bolivia                              |EFFECT GLADIATOR           |           8|      39.92|
Bolivia                              |CALIFORNIA BIRDS           |           8|      39.92|
Bolivia                              |CENTER DINOSAUR            |           8|      39.92|
Bolivia                              |DOGMA FAMILY               |           8|      39.92|
Bolivia                              |DRIFTER COMMANDMENTS       |           8|      39.92|
Bolivia                              |EAGLES PANKY               |           8|      39.92|
Bolivia                              |ENGLISH BULWORTH           |           8|      39.92|
Bolivia                              |JASON TRAP                 |           8|      39.92|
Bolivia                              |MAGIC MALLRATS             |           8|      39.92|
Bolivia                              |PICKUP DRIVING             |           8|      39.92|
Bolivia                              |TRUMAN CRAZY               |           8|      39.92|
Bolivia                              |WORKING MICROCOSMOS        |           8|      39.92|
Bolivia                              |YENTL IDAHO                |           8|      39.92|
Bolivia                              |PILOT HOOSIERS             |           8|      31.92|
Bolivia                              |CAPER MOTIONS              |           8|      31.92|
Brazil                               |WIFE TURN                  |          32|  239.68005|
Brazil                               |ROCKETEER MOTHER           |          40|  199.60004|
Brazil                               |BEHAVIOR RUNAWAY           |          24|  183.76001|
Brazil                               |MINE TITANS                |          16|  175.84001|
Brazil                               |BEAR GRACELAND             |          24|  167.76001|
Brazil                               |FRENCH HOLIDAY             |          24|  167.76001|
Brunei                               |FEATHERS METAL             |           8|      47.92|
Brunei                               |MAJESTIC FLOATS            |           8|      39.92|
Brunei                               |MEMENTO ZOOLANDER          |           8|      39.92|
Brunei                               |BUBBLE GROSSE              |           8|      39.92|
Brunei                               |MYSTIC TRUMAN              |           8|      39.92|
Brunei                               |APACHE DIVINE              |           8|      39.92|
Brunei                               |ELEMENT FREDDY             |           8|      39.92|
Brunei                               |ROCK INSTINCT              |           8|      39.92|
Brunei                               |SUSPECTS QUILLS            |           8|      39.92|
Brunei                               |GAMES BOWFINGER            |           8|      39.92|
Brunei                               |SOMETHING DUCK             |           8|      39.92|
Brunei                               |PAYCHECK WAIT              |           8|      39.92|
Brunei                               |GLEAMING JAWBREAKER        |           8|      39.92|
Brunei                               |CHAMBER ITALIAN            |           8|      39.92|
Brunei                               |INDEPENDENCE HOTEL         |           8|      39.92|
Brunei                               |ENCOUNTERS CURTAIN         |           8|      31.92|
Brunei                               |MUSCLE BRIGHT              |           8|      23.92|
Brunei                               |OPERATION OPERATION        |           8|      23.92|
Brunei                               |BOULEVARD MOB              |           8|      23.92|
Brunei                               |SHRUNK DIVINE              |           8|      23.92|
Brunei                               |LABYRINTH LEAGUE           |           8|      23.92|
Brunei                               |ROBBERS JOON               |           8|      23.92|
Brunei                               |SIERRA DIVIDE              |           8|  15.919999|
Brunei                               |GOLDMINE TYCOON            |           8|  15.919999|
Brunei                               |MILE MULAN                 |           8|  15.919999|
Bulgaria                             |LOSER HUSTLER              |           8|   71.91999|
Bulgaria                             |DAY UNFAITHFUL             |           8|   71.91999|
Bulgaria                             |INNOCENT USUAL             |           8|   71.91999|
Bulgaria                             |CAUSE DATE                 |           8|   71.91999|
Bulgaria                             |FALCON VOLUME              |           8|   63.91999|
Bulgaria                             |SILVERADO GOLDFINGER       |           8|   55.91999|
Bulgaria                             |DAUGHTER MADIGAN           |           8|   55.91999|
Bulgaria                             |QUEEN LUKE                 |           8|   55.91999|
Bulgaria                             |HILLS NEIGHBORS            |           8|      39.92|
Bulgaria                             |HARRY IDAHO                |           8|      39.92|
Bulgaria                             |APOCALYPSE FLAMINGOS       |           8|      39.92|
Bulgaria                             |USUAL UNTOUCHABLES         |           8|      39.92|
Bulgaria                             |SLEEPING SUSPECTS          |           8|      39.92|
Bulgaria                             |HEAVYWEIGHTS BEAST         |           8|      39.92|
Bulgaria                             |DADDY PITTSBURGH           |           8|      39.92|
Bulgaria                             |SATURDAY LAMBS             |           8|      39.92|
Bulgaria                             |ROSES TREASURE             |           8|      39.92|*/
