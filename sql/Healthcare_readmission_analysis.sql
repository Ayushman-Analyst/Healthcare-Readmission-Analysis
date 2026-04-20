CREATE DATABASE healthcare;

Use healthcare;

-- Total Number of Patient Encounters
SELECT 
    COUNT(*) as Total_patient_encounters
FROM
    diabetic_data;
    
-- Top 10 Most Frequent Diagnoses

SELECT diagnosis, COUNT(*) AS frequency
FROM (
    SELECT diag_1 AS diagnosis FROM diabetic_data
    UNION ALL
    SELECT diag_2 FROM diabetic_data
    UNION ALL
    SELECT diag_3 FROM diabetic_data
) AS combined_diagnosis
WHERE diagnosis IS NOT NULL AND diagnosis <> '?'
GROUP BY diagnosis
ORDER BY frequency DESC
LIMIT 10;

-- Average length of hospital stay by Admission type

select admission_type_id, avg(time_in_hospital) as avg_hospital_stay
from diabetic_data
group by admission_type_id
order by avg_hospital_stay desc;

-- Number of Readmitted Patients and Percentage

select count(readmitted) as total_readmitted_patients, (count(readmitted)*100/(select count(*) from diabetic_data)) as percentage_of_total_encounters
from diabetic_data
where readmitted <> 'NO';

-- Age Distribution of Patients

select age , count(*) as patient_count 
from diabetic_data
group by age
order by age;

-- Most Common Procedures

select num_procedures, count(*) as patient_count from diabetic_data
group by num_procedures
order by patient_count desc;

-- Average Medication by Age Group

select age, avg(num_medications) as avg_mediactions
from diabetic_data
group by age;

-- Readmission Distribution by Payer code

select payer_code, readmitted , count(*) as patient_count
from diabetic_data
group by payer_code, readmitted 
order by payer_code, patient_count desc;