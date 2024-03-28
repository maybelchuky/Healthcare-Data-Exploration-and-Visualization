

-------------DATA WRANGLING-------------------------

---Create a database and import healthcare csv file
CREATE DATABASE healthcare_database;

---Check for missing or null values
SELECT *
FROM healthcare
WHERE patient_name IS NULL;

---Check data structure
SELECT *
  FROM healthcare;

-------------SEGEMEENTATION ANALYSIS OF AGE DEMOGRAPHIC----------------
SELECT age,
CASE
       WHEN age BETWEEN 0 AND 12 THEN 'Child'
	WHEN age BETWEEN 13 AND 19 THEN 'Teen'
	WHEN age BETWEEN 20 AND 39 THEN 'Adult'
	WHEN age BETWEEN 40 AND 59 THEN 'Middle Age Adult'
	ELSE 'Old'
	END AS age_group
FROM healthcare;

------------------------FEATURE ENGINEERING-------------------------------


--1. New column for age group

 ALTER TABLE healthcare
 ADD age_group varchar(20);

 UPDATE healthcare
 SET age_group = 
   CASE
     WHEN age BETWEEN 0 AND 12 THEN 'Child'
	 WHEN age BETWEEN 13 AND 19 THEN 'Teen'
	 WHEN age BETWEEN 20 AND 39 THEN 'Adult'
	 WHEN age BETWEEN 40 AND 59 THEN 'Middle Age Adult'
	 ELSE 'Old'
 END;

--2. Extract the day, month, year from the date of admission and create a new columns for it

SELECT DATENAME (WEEKDAY, date_of_admission) AS day_of_admission
     FROM healthcare;

ALTER TABLE healthcare
     ADD day_of_admission VARCHAR(10);

UPDATE healthcare
    SET day_of_admission = DATENAME (WEEKDAY, date_of_admission);


---For month of admission
SELECT DATENAME (MONTH, date_of_admission) AS month_of_admission
    FROM healthcare;

ALTER TABLE healthcare
    ADD month_of_admission VARCHAR(10);

UPDATE healthcare
    SET month_of_admission = DATENAME(MONTH, date_of_admission);


---For year of admission
SELECT DATENAME (YEAR, date_of_admission) AS year_of_admission
    FROM healthcare;

ALTER TABLE healthcare
    ADD year_of_admission VARCHAR(5);

UPDATE healthcare
    SET year_of_admission = DATENAME(YEAR, date_of_admission);


--3. Extract the day, month, year from the discharge date and create a new columns for it

SELECT DATENAME (WEEKDAY, discharge_date) AS day_of_discharge
     FROM healthcare;
	 
ALTER TABLE healthcare
    ADD day_of_discharge VARCHAR(10);

UPDATE healthcare
    SET day_of_discharge = DATENAME (WEEKDAY, discharge_date);


---For month of discharge
SELECT DATENAME (MONTH, discharge_date) AS month_of_discharge
     FROM healthcare;

ALTER TABLE healthcare
     ADD month_of_discharge VARCHAR(10);

UPDATE healthcare
     SET month_of_discharge = DATENAME (MONTH, discharge_date);


---For year of discharge
SELECT DATENAME (YEAR, discharge_date) AS year_of_discharge
    FROM healthcare;

ALTER TABLE healthcare
     ADD year_of_discharge VARCHAR(5);

UPDATE healthcare
SET year_of_discharge = DATENAME(YEAR, discharge_date);



------------------------EXPLORATORY DATA ANALYSIS-------------------------------

------Problem Statement Questions-------

   --- What is the length of stay and average length of stay for patients in the hospital? 

 SELECT DATEDIFF (DAY, date_of_admission, discharge_date) AS length_of_stay
    FROM healthcare;

 ALTER TABLE healthcare
     ADD length_of_stay INT;

 UPDATE healthcare
      SET length_of_stay = DATEDIFF (DAY, date_of_admission, discharge_date);

SELECT AVG(length_of_stay) AS avg_length_of_stay FROM healthcare;

  ---How does the frequency of medical tests vary based on different admission types (Emergency, Elective, Urgent)?
   SELECT admission_type, test_results,
        COUNT(*) AS test_count
   FROM healthcare
   GROUP BY admission_type, test_results
   ORDER BY test_count DESC;
   
   --- What is the total billing amount and average billing amount per patient for each medical condition?
 SELECT medical_condition,
   SUM(billing_amount) AS total_billing_amount,
   AVG(billing_amount) AS avg_billling_amount
 FROM healthcare
 GROUP BY medical_condition 
 ORDER BY avg_billling_amount DESC;

   --- Are there any trends in billing amounts over time?
  SELECT year_of_admission,
     SUM(Billing_Amount) AS Total_Billing_Amount
  FROM healthcare
  GROUP BY year_of_admission;

  ---Are there any significant differences in billing amounts between patients with different insurance providers?
  SELECT Insurance_Provider, 
     SUM(billing_amount) AS total_billing_amount,
     AVG(Billing_Amount) AS avg_billing_amount
  FROM healthcare
  GROUP BY Insurance_Provider
  ORDER BY avg_billing_amount DESC;

   --- What percentage of medical tests have abnormal results, and how does this vary by medical condition?
SELECT Medical_Condition,
    COUNT(CASE WHEN Test_Results = 'Abnormal' THEN 1 END) AS Abnormal_Test_Count
FROM healthcare
GROUP BY Medical_Condition;

SELECT Medical_Condition,
    COUNT(*) AS Total_Test_Count
FROM healthcare
GROUP BY Medical_Condition;

SELECT a.Medical_Condition,
    CAST((CAST(a.Abnormal_Test_Count AS DECIMAL) / b.Total_Test_Count) * 100 AS DECIMAL(10,2)) AS Percentage_Abnormal_Tests
FROM 
  (SELECT Medical_Condition,
   COUNT(CASE WHEN Test_Results = 'Abnormal' THEN 1 END) AS Abnormal_Test_Count
FROM healthcare
GROUP BY Medical_Condition) a
    JOIN 
       (SELECT Medical_Condition,
       COUNT(*) AS Total_Test_Count
   FROM healthcare
   GROUP BY Medical_Condition) b
   ON a.Medical_Condition = b.Medical_Condition;

-- The relationship between distribution of age group by billing amount
 SELECT age_group,
   COUNT(*) AS total_patient,
   AVG(billing_amount) avg_billing_amount
 FROM healthcare
 GROUP BY age_group
 ORDER BY age_group DESC;

 ---How does the distribution of medical conditions vary by age group?
 SELECT age_group, medical_condition,
 COUNT(*) AS condition_count
 FROM healthcare
 GROUP BY age_group, medical_condition
 ORDER BY condition_count DESC;

--- the distribution of medical conditions by blood type
SELECT Medical_Condition, Blood_Type,
   COUNT(*) AS Condition_Count
FROM healthcare
GROUP BY Medical_Condition, Blood_Type
ORDER BY Condition_Count DESC;

--- the distribution of medical conditions by gender
SELECT medical_condition, gender,
COUNT(*) AS condition_count
FROM healthcare
GROUP BY medical_condition, gender
ORDER BY Condition_Count DESC;

---How does the distribution of insurance providers vary across different age groups?
SELECT age_group, insurance_provider,
    COUNT(*) AS condition_count
FROM healthcare
GROUP BY age_group, insurance_provider
ORDER BY Condition_Count DESC;

---What is the distribution of test results for patients with different medical conditions?
SELECT 
    Medical_Condition,
    Test_Results,
    COUNT(*) AS Test_Result_Count
FROM 
    healthcare
GROUP BY 
    Medical_Condition, Test_Results
ORDER BY 
    Medical_Condition, Test_Results;

---Are there any notable differences in test result outcomes for patients with different medical conditions?
SELECT
    Medical_Condition,
    Test_Results,
    COUNT(*) AS Result_Count
FROM
    healthcare
GROUP BY
    Medical_Condition, Test_Results
ORDER BY
    Medical_Condition, Test_Results;

--- identify any monthly patterns in the occurrence of specific medical conditions?
SELECT
    Month_of_admission,
    Medical_Condition,
    COUNT(*) AS Condition_Count
FROM healthcare
GROUP BY Month_of_admission, Medical_Condition
ORDER BY Month_of_admission, Medical_Condition DESC;

---What are the busiest day,month and year of admission, and how many admissions were recorded ?
SELECT
    day_of_admission, month_of_admission, year_of_admission,
    COUNT(*) AS Condition_Count
FROM healthcare
GROUP BY day_of_admission,  month_of_admission, year_of_admission
ORDER BY day_of_admission DESC;

----What is the distribution of discharge dates across different months and years?
SELECT
    month_of_discharge, year_of_discharge,
    COUNT(*) AS Condition_Count
FROM healthcare
GROUP BY   month_of_discharge, year_of_discharge
ORDER BY  month_of_discharge DESC;


-----------SUMMARY STATISTICAL ANALYSIS-------------- 

---Mean Age: Average age of patients.
---Minimum Age: Smallest observed age.
---Maximum Age: Largest observed age.
---Standard Deviation of Age: Measure of the dispersion of ages around the mean.
 SELECT 
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    AVG(age) AS avg_age,
	STDEV(Age) AS Age_StdDev 
 FROM healthcare;


--- Standard Deviation of Billing Amount: Measure of the variability of billed amounts around the mean
---Sum of billing amount: Total billed for healthcare.
---Average billing amount: Mean billed per patient.
---Minimum billing amount: Smallest billed amount.
---Maximum billing amount: Largest billed amount.
SELECT
    MIN(billing_amount) AS min_billing_amount,
    MAX(billing_amount)AS max_billing_amount,
    AVG(billing_amount)  AS avg_billing_amount,
    SUM(billing_amount) AS total_revenue,
	STDEV(billing_amount) AS billing_amount_stddev
FROM healthcare;

---Mode Blood Type:
SELECT blood_type, COUNT(blood_type) AS Frequency
FROM healthcare
GROUP BY blood_type
ORDER BY COUNT(blood_type) DESC;

---Minimum Length of Stay:
----Maximum Length of stay
SELECT 
    MIN(length_of_stay) AS min_length_of_stay,
	MAX(length_of_stay) AS max_length_of_stay,
	AVG(length_of_stay) AS avg_length_of_stay
FROM healthcare;


---Unique Count of doctors,patient,hospital and insurance provider

SELECT
    COUNT(DISTINCT Doctor) AS Distinct_Doctors,
    COUNT(DISTINCT Patient_Name) AS Distinct_Patients,
    COUNT(DISTINCT Hospital) AS Distinct_Hospitals,
    COUNT(DISTINCT Insurance_Provider) AS Distinct_Insurance_Provider,
	COUNT(DISTINCT room_number) AS Distinct_room,
	COUNT(DISTINCT medical_condition) AS Distinct_medical_condition
FROM healthcare;




