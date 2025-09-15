🔑 Key Features

Data Preprocessing
  Cleaning text (punctuation, stopwords, tokenization).
  Feature extraction: sentence length, vocabulary richness, stopword ratio.

Exploratory Data Analysis (EDA)
  Distribution of text lengths.
  Unique words per document.
  Class balance (Human vs AI).

Machine Learning Models
  Baseline Model
    Logistic Regression using numerical features (sentence length, vocabulary ratio).
  TF-IDF + Classification
    TF-IDF vectorization for word importance.
    Logistic Regression & Naive Bayes for classification.

Evaluation Metrics
  Accuracy, Precision, Recall, F1-score.
  Confusion Matrix visualization.
  ROC Curve and AUC score.

Interpretability
  Top words that contribute most to classification.
  How TF-IDF weights differentiate AI vs Human texts.

📊 Results
  Baseline Logistic Regression: Good separation using simple numeric features.
  TF-IDF + Logistic Regression: Higher accuracy and generalization.
  Naive Bayes: Performed efficiently with sparse text data.
  Performance was evaluated using:
  Confusion Matrix ✅
  ROC-AUC Score ✅
  Classification Report ✅

⚙️ Tech Stack
  Python 🐍
  Pandas, Numpy → Data preprocessing
  Matplotlib, Seaborn → Visualization
  Scikit-learn → Machine Learning (Logistic Regression, Naive Bayes, TF-IDF)
