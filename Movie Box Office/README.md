📌 Project Overview

This project analyzes a dataset of movies with the goal of exploring key insights and applying data analysis and machine learning techniques.
The focus is on understanding how different features (budget, ratings, and genres) affect the Global Box Office performance.

🚀 Objectives

Clean and preprocess the dataset.

Perform exploratory data analysis (EDA) with descriptive statistics and visualizations.

Engineer new features for deeper insights.

Apply predictive models to estimate Global Box Office revenue.

Evaluate model performance using industry metrics.

📊 Tasks
1️⃣ Data Cleaning & Preparation

Handled missing values and checked for duplicates.

Converted numerical values into millions (for readability).

Ensured data consistency in categorical features (e.g., genre, director).

2️⃣ Exploratory Data Analysis (EDA)

Distribution of IMDb ratings and Rotten Tomatoes scores.

Correlation between budget and box office revenue.

Top performing genres and directors.

3️⃣ Feature Engineering

Created new metric: Revenue per IMDb Vote.

Aggregated Global Box Office revenue in millions.

Ranked directors by total worldwide revenue.

4️⃣ Visualizations

Box office revenue distribution.

Top 10 directors by Global Box Office.

Relationship between ratings and revenue.

5️⃣ Predictive Modeling

Target variable: Global_BoxOfficeUSD.

Features: BudgetUSD, Genre, IMDbRating, RottenTomatoesScore.

Model: Linear Regression.

Evaluation metrics:

R² (coefficient of determination).

RMSE (Root Mean Squared Error).

Real vs. Predicted revenue plot to validate performance.

🛠️ Tech Stack

Python: pandas, numpy, matplotlib, seaborn, scikit-learn

Jupyter Notebook for development

Git/GitHub for version control

✅ Key Insights

Budget has a positive but not perfect correlation with revenue.

Some directors consistently deliver high box office returns.

IMDb ratings show moderate influence on global revenue.

Predictive model provides a first approximation but with room for improvement.
