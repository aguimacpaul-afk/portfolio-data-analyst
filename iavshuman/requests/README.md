📊 Fase 1 – Exploración avanzada

Balance de clases
  Calcula cuántos ensayos hay de AI vs Human.
  Haz una gráfica de barras comparativa.
  Evalúa si el dataset está balanceado (clase 0 vs 1).
Distribución de longitudes
  Crea columnas con:
  Longitud en caracteres.
  Número de palabras.
  Promedio de longitud de palabra.
  Compara estadísticamente (t-test o Mann-Whitney) si hay diferencia significativa entre textos AI y Human.

🔎 Fase 2 – Análisis lingüístico

Riqueza léxica
  Calcula el ratio de palabras únicas / total de palabras por ensayo.
  Compara entre AI y Human: ¿quién usa vocabulario más variado?
Stopwords y estilo
  Extrae las palabras más frecuentes de cada clase (usa nltk o collections.Counter).
  Identifica diferencias estilísticas (ejemplo: AI repite más conectores o palabras técnicas).
Longitud de oraciones
  Divide cada ensayo por “.”
  Calcula la media y desviación de la longitud de oraciones.
  Visualiza con un boxplot comparativo AI vs Human.

🤖 Fase 3 – Machine Learning básico

Baseline simple
  Usa solo features numéricas (longitud, vocabulario, stopwords, oraciones).
  Entrena un modelo (Logistic Regression, RandomForest).
  Evalúa con accuracy, precision, recall, F1.
TF-IDF + Clasificación
  Transforma los textos con TF-IDF.
  Entrena un modelo de regresión logística o Naive Bayes.
  Evalúa con matriz de confusión y curva ROC.
Interpretabilidad
  Identifica las palabras que más pesan en el modelo TF-IDF.
  Explica con ejemplos cómo el modelo diferencia AI de Human.
