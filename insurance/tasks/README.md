📌 Sprint 1 – Análisis Exploratorio de Datos (EDA)

Carga y limpieza
  Carga el dataset en un DataFrame.
  Verifica tipos de datos, valores nulos y duplicados.
  Genera estadísticas descriptivas con .describe() y .info().

Exploración de distribuciones
  Grafica histogramas para age, bmi y charges.
  Haz un boxplot para comparar charges entre fumadores y no fumadores.

Correlaciones
  Calcula la matriz de correlación numérica (age, bmi, children, charges).
  Visualízala con un heatmap.

📌 Sprint 2 – Análisis Avanzado

Agrupaciones
  Encuentra el costo promedio de seguro por región.
  Calcula la diferencia promedio de charges entre fumadores y no fumadores.

Transformaciones con Numpy
  Normaliza bmi con min-max scaling (sin usar sklearn, solo numpy).
  Crea una nueva columna categórica:
  bmi_category: Bajo peso (<18.5), Normal (18.5–24.9), Sobrepeso (25–29.9), Obeso (>=30).

Visualización avanzada
  Haz un gráfico combinado: scatter de bmi vs charges, coloreado por smoker.
  Agrega una regresión lineal simple (puede ser con numpy.polyfit).

📌 Sprint 3 – Machine Learning Básico

Regresión Lineal
  Usa LinearRegression (de sklearn) para predecir charges a partir de: age, bmi, children y smoker.
  Divide el dataset en train/test.
  Evalúa con R² y MAE.

Comparación de modelos
  Entrena un árbol de decisión regresor y compara sus métricas con la regresión lineal.

Feature importance
  Si usas el árbol de decisión, muestra la importancia de cada variable.
