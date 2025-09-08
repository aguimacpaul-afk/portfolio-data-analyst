1. Top clientes por gasto: Calcula los 10 clientes que más dinero han gastado en total

2. Ciudades con más churn: Encuentra qué ciudad tiene más clientes Inactivos (churned = 'Inactive') y su porcentaje sobre el total de esa ciudad.

3. Restaurantes mejor valorados: Obtén los 5 restaurantes con el promedio de rating más alto, considerando solo clientes activos.

4. Categorías más pedidas según edad: Agrupa por age y category para ver qué tipo de comida prefieren los diferentes grupos (Adult, Senior, Youth).

5. Predicción de lealtad simple: Genera una nueva columna booleana: high_loyalty = loyalty_points > promedio_general. Luego, cruza eso con churn
   para ver si los clientes con alta lealtad tienen menor tasa de abandono.

6. El equipo de negocio quiere entender mejor cómo se relaciona la lealtad con la retención de clientes.
#Debes:
   #Calcular la tasa de churn (porcentaje de clientes inactivos) en función de si tienen alta lealtad o no.
   #Mostrar los resultados en un gráfico de barras comparativo.
   #Escribir una conclusión corta que explique si los puntos de lealtad realmente ayudan a retener clientes.

7. Queremos analizar si hay diferencias en cómo los usuarios califican a los restaurantes según su categoría de comida.

      Calcula la distribución estadística de las calificaciones (rating) agrupada por category (media,               mediana, desviación estándar, mínimo, máximo).
      Ordena las categorías de mayor a menor por su promedio de rating.
      Haz un boxplot donde el eje X sean las categorías (ordenadas) y el eje Y los ratings.
      Bonus: agrega un stripplot encima para mostrar la dispersión de puntos.

8. Convierte las columnas order_date y signup_date a tipo datetime.
      Calcula para cada cliente el tiempo de vida en la plataforma:
      lifetime=ultima fecha de orden−fecha de signup
      lifetime=ultima fecha de orden−fecha de signup
      Obtén estadísticas descriptivas del lifetime (media, mediana, std, percentiles).
      Crea una columna categórica que clasifique a los clientes:
      Short-term: lifetime < 90 días
      Mid-term: 90–180 días
      Long-term: >180 días
      Haz un gráfico (barplot o countplot) mostrando cuántos clientes caen en cada categoría de lifetime.

