# Healthcare Data Exploration and Visualization
![Healthcare](image_intro.jpg)

## Table of Contents
- [Project Overview](#project_overview)
- [Data Sources](#data_sources)
- [Tools](#tools)
- [Data Cleaning and Preparation](#data_cleaning_and_preparation)
- [Data Manipulation and Exploration Analysis](#data_manipulation_and_exploration_analysis)
- [Data Visualization](#data-visualization)
- [Results/Findings](#results_/_findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [References](#references)


### Project Overview
---

Welcome to the Healthcare Data Exploration and Visualization project! In this project, we delve into a comprehensive healthcare dataset using Excel, SQL and Tableau to uncover valuable insights. By exploring patient demographics, medical conditions, billing trends, and more, we aim to gain a deeper understanding of healthcare delivery and patient outcomes. Through interactive visualizations and analysis, we showcase the power of data exploration and visualization in driving informed decision-making in the healthcare domain.

### Data Sources
---
Healthcare Dataset: Obtained from Kaggle, this synthetic healthcare dataset is provided in CSV format. It offers a realistic simulation of healthcare data for analysis, covering patient demographics, medical conditions, and billing information.

### Tools
---
- Microsoft Excel for Data Cleaning and Preparation
     - [Download Dataset Here](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)
- Microsoft SQL Server for Data Manipulation and Exploration
- Tableau for Data Visualization

### Data Cleaning and Preparation
---
In the data preparation phase, we performed the fo,lowing tasks:
1. Identify missing values in the dataset using Excel's filtering
2. Identify and remove duplicate rows or records from the dataset
3. Format the billing amount column to display numeric data as currency

### Data Manipulation and Exploration Analysis
---
Some Key SQL queries used in my analysis :
```SQL
----SEGEMENENTATION ANLAYSIS OF AGE GROUP---------
SELECT Age,
CASE
     WHEN age BETWEEN 5 AND 12 THEN 'Child'
	 WHEN age BETWEEN 13 AND 19 THEN 'Teen'
	 WHEN age BETWEEN 20 AND 39 THEN 'Adult'
	 WHEN age BETWEEN 40 AND 59 THEN 'Middle Age Adult'
	 ELSE 'Old'
	END AS age_group
FROM healthcare;

-----FEATURE ENGINEERING/ OF DAYNAME, MONTH & YEAR FROM DATE COLUMN & CREATING NEW COLUMN---------
SELECT DATENAME (WEEKDAY, date_of_admission) AS day_of_admission
     FROM healthcare;
ALTER TABLE healthcare
     ADD day_of_admission VARCHAR(30);
UPDATE healthcare
   SET day_of_admission = DATENAME (WEEKDAY, date_of_admission);

---FOR MONTH
SELECT DATENAME (MONTH, date_of_admission) AS month_of_admission
    FROM healthcare;
ALTER TABLE healthcare
    ADD month_of_admission VARCHAR(30);
UPDATE healthcare
    SET month_of_admission = DATENAME(MONTH, date_of_admission);

---FOR YEAR
SELECT DATENAME (YEAR, date_of_admission) AS year_of_admission
    FROM healthcare;
ALTER TABLE healthcare
    ADD year_of_admission VARCHAR(30);
UPDATE healthcare
    SET year_of_admission = DATENAME(YEAR, date_of_admission);


```
## Data Visualization

### Results/ Findings
---
1.

### Recommendations
---

### Limitations
---

### Refernces
---
1.
