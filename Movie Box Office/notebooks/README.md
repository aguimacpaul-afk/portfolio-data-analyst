
🎬 Escenario de trabajo (modo jefe)

"Paul, la gerencia quiere un análisis sobre nuestro portafolio de películas y cómo ciertos factores influyen en el éxito en taquilla y la recepción de la crítica. Quiero que prepares un informe claro y visual, con hallazgos clave. Después de eso, me gustaría que explores un modelo predictivo básico para anticipar el desempeño de futuros estrenos."


📌 Plan de tareas (fases de dificultad creciente)
Tarea 1 – Exploración inicial (EDA básica)

👉 "Revísame el dataset: dime cuántas filas y columnas tiene, qué tipos de datos hay, cuántos valores nulos y duplicados existen. Hazme un resumen de calidad de datos en una tabla."

Tarea 2 – Estadísticas descriptivas + Visualización

👉 "Haz un análisis descriptivo de las variables más relevantes: presupuestos, taquillas (US y global), ratings (IMDb, Rotten Tomatoes).
Muéstrame la distribución de estas métricas con histogramas y boxplots. Además, haz una tabla con los 5 géneros más comunes."

Tarea 3 – Tendencias y correlaciones (EDA avanzada)

👉 *"Quiero entender qué factores impulsan el éxito.

Haz un heatmap de correlaciones entre presupuesto, taquilla y ratings.

Muéstrame la tendencia del número de estrenos por año.

Haz una comparación de ingresos globales promedio por género."*

Tarea 4 – KPI para negocio

👉 *"Preséntame métricas clave como:

Ingresos globales totales.

Ticket promedio (US_BoxOfficeUSD / NumVotesIMDb, como proxy de ‘venta por usuario’).

TOP 10 directores con mayor recaudación global.
Hazlo en tablas y gráficas claras, tipo dashboard básico."*

Tarea 5 – Machine Learning (intro)

👉 "Constrúyeme un modelo simple para predecir Global_BoxOfficeUSD a partir de: BudgetUSD, Genre, IMDbRating, y RottenTomatoesScore.
Evalúa el modelo con R² y RMSE, y dime si es confiable.
Quiero un gráfico comparando valores reales vs. predichos."
