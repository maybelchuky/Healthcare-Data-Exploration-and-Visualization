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

Welcome to the Healthcare Data Exploration and Visualization project! In this project, I delve into a comprehensive healthcare dataset using Excel, SQL and Tableau to uncover valuable insights. By exploring patient demographics, medical conditions, billing trends, and more, I aim to gain a deeper understanding of healthcare delivery and patient outcomes. Through interactive visualizations and analysis, showcasing the power of data exploration and visualization in driving informed decision-making in the healthcare domain.

### Data Sources
---
Healthcare Dataset: Obtained from Kaggle, this synthetic healthcare dataset is provided in CSV format. It offers a realistic simulation of healthcare data for analysis, covering patient demographics, medical conditions, and billing information.

### About Data
---

The dataset was obtained from the [Kaggle Healthcare Dataset](https://www.kaggle.com/datasets/prasad22/healthcare-dataset) This dataset contains healthcare information over the years. The data contains 15 columns and 10,000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| Name              | The  name of the patient associated with the healthcare record             | VARCHAR(50)    |
| Age                 | The age of the patient at the time of admission, expressed in years        | INT     |
| Gender                   | The he gender of the patient, either "Male" or "Female"            | VARCHAR(10)    |
| Blood Type           | The patient's blood type              | VARCHAR(3)    |
| Medical Condition            | The primary medical condition or diagnosis associated with the patient        | VARCHAR(20)   |
| Date of Admission            |    The date on which the patient was admitted to the healthcare facility            | DATE |
| Doctor                | The name of the doctor responsible for the patient's care during their admission          | VARCHAR(50)            |
| Hospital                |  The healthcare facility or hospital where the patient was admitted       | VARCHAR(50)    |
| Insurance Provider                   | The patient's insurance provider          | VARCHAR(50)  |
| Billing Amount                    | The amount of money billed for the patient's healthcare services during their admission | FLOAT(10, 2)         |
| Room Number                  | The room number where the patient was accommodated during their admission | INT      |
| Admission Type                | The type of admission, which can be "Emergency," "Elective," or "Urgent"                 | VARCHAR(20) |
| Discharge Date                   | The date on which the patient was discharged from the healthcare facility                    | DATE |
| Medication | The medication prescribed or administered to the patient during their admission                | VARCHAR(20)   |
| Test Results          | The results of a medical test conducted during the patient's admission                         | VARCHAR(20)  |


### Tools
---
- Microsoft Excel for Data Cleaning and Preparation
     - [Download Dataset Here](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)
- Microsoft SQL Server for Data Manipulation and Exploration
- Tableau for Data Visualization

### Approach Used
---
1. **Data Cleaning and Preparation Using Excel:** In the data preparation phase, we performed the fo,lowing tasks:
> 1. Identify missing values in the dataset using Excel's filtering
> 2. Identify and remove duplicate rows or records from the dataset
> 3. Format the billing amount column to currency and round up the amounts to a whole number

2. **Data Wrangling:** This is the step where inspection of data is done to make sure **NULL** values and missing values are detected and data replacement methods are used to replace, missing or **NULL** values.

> 1. Build a database
> 2. Create table and insert the data.
> 3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set **NOT NULL** for each field, hence null values are filtered out.

3. **Segementation Analysis of Age Demographic:**: This will hwlp segement the age demographic into groups
   > 1. Age BETWEEN 0 AND 12 = Child
   > 2. Age BETWEEN 13 AND 19 = Teen
   > 3. Age BETWEEN 20 AND 39 = Adult
   > 4. Age BETWEEN 40 AND 59 = Middle Age Adult
   > 5. Age BETWEEN 60 AND Above = Old


5. **Feature Engineering:** This will help use generate some new columns from existing ones.

> 1. Add a new columns named `age_group` that contains the age segementation of the patient (Child, Teen, Adult).

> 2. Add a new columns named `day_of_admission` and `day_of_discharge` that contains the extracted days of the week on which the patient was admitted and discharged (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the hospital is busiest.

> 3. Add a new columns named `month_of_admission` and `month_of_discharge` that contains the extracted months of the year on which the patient was admitted and discharged (Jan, Feb, Mar). Help determine which month of the year has the most patient.

> 4. Add a new columns named `year_of_admission` and `year_of_discharge` that contains the extracted months of the year on which the patient was admitted and discharged (2021, 2022, 20023). Help determine trend over time.

4. **Exploratory Data Analysis (EDA):** Exploratory data analysis is done to answer the listed questions and aims of this project.
   
### Problem Statement Questions
---

 *Resource Utilization:*
   - What is the average length of stay for patients in each department of the hospital?
   - How many hospital beds are occupied on average each day? Can we identify peak occupancy times?

 *Cost Analysis:*
   - What is the total billing amount and average billing amount per patient for each medical condition?
   - Are there any trends in billing amounts over time or by insurance provider?

 *Patient Outcomes:*
   - What is the readmission rate for patients with specific medical conditions?
   - Is there a correlation between the length of stay and patient outcomes (e.g., readmission, mortality)?

 *Medication Management:*
   - Which medications are most commonly prescribed for patients with certain medical conditions?
   - Are there any patterns in medication prescriptions that may indicate potential drug interactions or over-prescription?

 *Emergency Management:*
   - What percentage of admissions are emergencies, and how does this vary by hospital or department?
   - How quickly are emergency patients admitted and treated compared to non-emergency cases?

 *Quality of Care:*
   - What percentage of medical tests have abnormal results, and how does this vary by medical condition?
   - Can we identify any trends or patterns in patient satisfaction scores over time or by hospital department?

 *Operational Efficiency:*
   - Are there any bottlenecks or inefficiencies in the admission and discharge processes?
   - What is the average turnaround time for test results, and are there any delays or issues with specific tests?

 *Insurance Claims Analysis:*
   - Which insurance providers have the highest and lowest average billing amounts per patient?
   - Are there any discrepancies or anomalies in billing amounts for different insurance providers?

 *Patient Segmentation:*
   - Can we identify distinct patient segments based on demographic characteristics, medical conditions, and utilization patterns?
   - How do the healthcare needs and outcomes differ among these patient segments?

 *Preventive Care and Disease Management:*
   - Are there any trends or patterns in patient admissions and medical conditions that may indicate opportunities for preventive care interventions?
   - How effective are current disease management protocols in reducing readmissions and improving patient outcomes?

6. **Data Visualization using Tableau:**
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
