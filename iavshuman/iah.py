import pandas as pd
import numpy as np

path = "iavshuman/balanced_ai_human_prompts.csv"
df = pd.read_csv(path)#2750,2

"""                                                text  generated
0  Machine learning, a subset of artificial intel...          1
1  A decision tree, a prominent machine learning ...          1
2  Education, a cornerstone of societal progress,...          1
3  Computers, the backbone of modern technology, ...          1
4  Chess, a timeless game of strategy and intelle...          1
"""
 
# 1.1 Calcula cuántos ensayos hay de AI vs Human.
balance = df.generated.value_counts().reset_index() # 1375, 1375
"""   generated 	count
0          0    1375
1          1   	1375"""
import matplotlib.pyplot as plt
import seaborn as sns

# 1.2 Haz una gráfica de barras comparativa.
plt.figure(num="Ensayos AI vs Human", figsize=(10,6))
plt.title("Ensayos AI vs Human")
sns.barplot(data=balance, x='generated', y='count', palette="Set2")
#plt.show()
# 1.3 esta balanceado? si
# 1.4 crear columnas con longitud de caracteres, numero de palabras, promedio log de palabra

df_mots = df.copy()
df_mots['len_mot'] = df.text.str.len()
df_mots['num_mot'] = df.text.str.split().apply(len)
df_mots['media_mot'] = (df_mots.len_mot/df_mots.num_mot).round(2)
"""                                                text  ...  media_mot
0  Machine learning, a subset of artificial intel...  ...       7.52
1  A decision tree, a prominent machine learning ...  ...       7.51
2  Education, a cornerstone of societal progress,...  ...       8.14
3  Computers, the backbone of modern technology, ...  ...       7.80
4  Chess, a timeless game of strategy and intelle...  ...       7.52"""

# 1.5 Compara estadísticamente (t-test o Mann-Whitney) si hay
# diferencia significativa entre textos AI y Human.

summary = df_mots.groupby('generated')[['len_mot','num_mot','media_mot']].describe()

# Filtrar datos
ai = df_mots[df_mots["generated"]==1]
human = df_mots[df_mots["generated"]==0]

plt.figure(num="Distribución de PAlabras Human - AI", figsize=(12,5))

# Histograma Human
plt.subplot(1,2,1)
sns.histplot(human["num_mot"], bins=40, kde=True, color="orange")
plt.title("Distribución de número de palabras - Human")
plt.xlabel("Número de palabras")
plt.ylabel("Frecuencia")

# Histograma AI
plt.subplot(1,2,2)
sns.histplot(ai["num_mot"], bins=40, color="blue")
plt.title("Distribución de número de palabras - AI")
plt.xlabel("Número de palabras")
plt.ylabel("Frecuencia")

#plt.show()

# 2. analisis linguistico
# 2.1 Calcula el ratio de palabras únicas / total de palabras por ensayo.

import re 
def tokenize(text):
	text = text.lower()
	text = re.sub(r"[^\w\s]", "", text) #quita puntuacion
	return text.split()

# Palabras únicas / total
df["tokens"] = df["text"].apply(tokenize)
df["unique_ratio"] = df["tokens"].apply(lambda x: len(set(x)) / len(x) if len(x) > 0 else 0)

# Comparación por clase
df.groupby("generated")["unique_ratio"].mean()
"""generated
0    0.435684
1    0.920862"""

# 2.2 Extrae las palabras más frecuentes de cada clase (usa nltk o collections.Counter).
# Identifica diferencias estilísticas (ejemplo: AI repite más conectores o palabras técnicas).

from nltk.corpus import stopwords
from collections import Counter
import nltk

nltk.download("stopwords")

stop_words = set(stopwords.words("english"))
#funcion para filtrar stopwords
def remove_stopwords(tokens):
	return[w for w in tokens if w not in stop_words]

df["tokens_nonstop"] = df["tokens"].apply(remove_stopwords)

#contar palabras mas comunes
def top_words(df_subset, n=20):
	all_words = [word for tokens in df_subset["tokens_nonstop"] for word in tokens]
	return Counter(all_words).most_common(n)

print("top human", top_words(df[df.generated == 0]))
print("top ai", top_words(df[df.generated == 1]))

# 2.3 Longitud de oraciones

def sentence_len(text):
	sentences = text.split(".")
	lenghts = [len(s.split()) for s in sentences if s.strip != ""]
	return lenghts

df["sent_lengths"] = df["text"].apply(sentence_len)
df["avg_sent_len"] = df["sent_lengths"].apply(lambda x:sum(x)/len(x)
	if len(x)>0 else 0)
df["std_sent_len"] = df["sent_lengths"].apply(lambda x:pd.Series(x).std()
	if len(x)>1 else 0)

# Visualiza con un boxplot comparativo AI vs Human.
plt.figure(num="Comparación de longitud promedio de oraciones",figsize=(8,5))
sns.boxplot(data=df, x="generated", y="avg_sent_len", palette="Set2")
plt.xticks([0,1], ["Human", "AI"])
plt.title("Comparación de longitud promedio de oraciones")
#plt.show()

# 3 Ml
# 3.1 Usa solo features numéricas (longitud, vocabulario, stopwords, oraciones).
# Entrena un modelo (Logistic Regression, RandomForest).
# Evalúa con accuracy, precision, recall, F1.

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report

"""Index(['text', 'generated', 'tokens', 'unique_ratio', 'tokens_nonstop',
       'sent_lengths', 'avg_sent_len', 'std_sent_len'],"""


df["essay_length"] = df["tokens"].apply(len)
df["unique_ratio"] = df["tokens"].apply(lambda x: len(set(x)) / len(x) if len(x) > 0 else 0)
df["sentence_len"] = df["text"].apply(lambda x: np.mean([len(s.split()) for s in x.split(".") if s.strip()]))
df["stopword_ratio"] = df["tokens"].apply(lambda x: sum(1 for w in x if w in stop_words) / len(x) if len(x) > 0 else 0)

X = df[["essay_length", "unique_ratio", "sentence_len", "stopword_ratio"]]
y = df.generated

X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.2,
	random_state=42)

model = LogisticRegression(max_iter=1000)
model.fit(X_train,y_train)

y_pred =model.predict(X_test)
print(classification_report(y_test,y_pred))

# 3.2 tfidf + clasificacion

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import ConfusionMatrixDisplay, roc_auc_score, RocCurveDisplay

# vectorizar textos

tfidf = TfidfVectorizer(max_features=5000, stop_words="english")
X_tfidf = tfidf.fit_transform(df.text)

X_train, X_test, t_train, y_test = train_test_split(X_tfidf, y,
	test_size=0.2, random_state=42)

clf = MultinomialNB()
clf.fit(X_train, y_train)

y_pred = clf.predict(X_test)

print(classification_report(y_test,y_pred))

#matriz de confusion
ConfusionMatrixDisplay.from_estimator(clf,X_test,y_test)
plt.show()
#curva roc
RocCurveDisplay.from_estimator(clf, X_test, y_test)
plt.show()
