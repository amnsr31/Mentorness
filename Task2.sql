use aman;
-- Q1. Write a code to check NULL values
SELECT
  (SELECT COUNT(*) FROM `Corona Virus Dataset` WHERE `Province` IS NULL) AS null_province,
  (SELECT COUNT(*) FROM `Corona Virus Dataset` WHERE `Country/Region` IS NULL) AS null_country_region,
  (SELECT COUNT(*) FROM `Corona Virus Dataset` WHERE `Latitude` IS NULL) AS null_latitude,
  (SELECT COUNT(*) FROM `Corona Virus Dataset` WHERE `Longitude` IS NULL) AS null_longitude,
  (SELECT COUNT(*) FROM `Corona Virus Dataset` WHERE `Date` IS NULL) AS null_date,
  (SELECT COUNT(*) FROM `Corona Virus Dataset` WHERE `Confirmed` IS NULL) AS null_confirmed,
  (SELECT COUNT(*) FROM `Corona Virus Dataset` WHERE `Deaths` IS NULL) AS null_deaths,
  (SELECT COUNT(*) FROM `Corona Virus Dataset` WHERE `Recovered` IS NULL) AS null_recovered;

-- Q3. check total number of rows
SELECT COUNT(*) AS total_rows FROM `Corona Virus Dataset`;

-- Q4. Check what is start_date and end_date
SELECT
  MIN(DATE(CONCAT(SUBSTRING(`Date`, 7, 4), '-', SUBSTRING(`Date`, 4, 2), '-', SUBSTRING(`Date`, 1, 2)))) AS start_date,
  MAX(DATE(CONCAT(SUBSTRING(`Date`, 7, 4), '-', SUBSTRING(`Date`, 4, 2), '-', SUBSTRING(`Date`, 1, 2)))) AS end_date
FROM `Corona Virus Dataset`;

-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT SUBSTR(`Date`, 4, 2)) AS num_months
FROM `Corona Virus Dataset`;

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
    SUBSTR(`Date`, 4, 2) AS month,
    AVG(Confirmed) AS avg_confirmed,
    AVG(Deaths) AS avg_deaths,
    AVG(Recovered) AS avg_recovered
FROM `Corona Virus Dataset`
GROUP BY month;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT 
    month,
    (SELECT Confirmed 
     FROM `Corona Virus Dataset` AS inner_data
     WHERE SUBSTR(inner_data.`Date`, 4, 2) = outer_data.month 
     GROUP BY Confirmed 
     ORDER BY COUNT(*) DESC 
     LIMIT 1) AS most_frequent_confirmed,
    (SELECT Deaths 
     FROM `Corona Virus Dataset` AS inner_data
     WHERE SUBSTR(inner_data.`Date`, 4, 2) = outer_data.month 
     GROUP BY Deaths 
     ORDER BY COUNT(*) DESC 
     LIMIT 1) AS most_frequent_deaths,
    (SELECT Recovered 
     FROM `Corona Virus Dataset` AS inner_data
     WHERE SUBSTR(inner_data.`Date`, 4, 2) = outer_data.month 
     GROUP BY Recovered 
     ORDER BY COUNT(*) DESC 
     LIMIT 1) AS most_frequent_recovered
FROM (
    SELECT SUBSTR(`Date`, 4, 2) AS month
    FROM `Corona Virus Dataset`
    GROUP BY month
) AS outer_data;

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    SUBSTR(`Date`, 7, 4) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM `Corona Virus Dataset`
GROUP BY year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    SUBSTR(`Date`, 7, 4) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM `Corona Virus Dataset`
GROUP BY year;

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT 
    SUBSTR(`Date`, 4, 2) AS month,
    SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths,
    SUM(Recovered) AS total_recovered
FROM `Corona Virus Dataset`
GROUP BY month;


-- Q11. Check how corona virus spread out with respect to confirmed case
SELECT
    COUNT(*) AS total_cases,
    AVG(`Confirmed`) AS average_confirmed,
    VARIANCE(`Confirmed`) AS variance_confirmed,
    STDDEV_POP(`Confirmed`) AS stdev_confirmed
FROM `Corona Virus Dataset`;

-- Q12. Check how corona virus spread out with respect to death case per month
SELECT
    SUBSTR(`Date`, 4, 2) AS month,
    COUNT(*) AS total_deaths,
    AVG(Deaths) AS average_deaths,
    VARIANCE(Deaths) AS variance_deaths,
    STDDEV_POP(Deaths) AS stdev_deaths
FROM `Corona Virus Dataset`
GROUP BY month;

-- Q13. Check how corona virus spread out with respect to recovered case
SELECT
    COUNT(*) AS total_recovered_cases,
    AVG(Recovered) AS average_recovered_cases,
    VARIANCE(Recovered) AS variance_recovered_cases,
    STDDEV_POP(Recovered) AS stdev_recovered_cases
FROM `Corona Virus Dataset`;

-- Q14. Find Country having highest number of the Confirmed case
SELECT `Country/Region` AS country,
       MAX(Confirmed) AS max_confirmed_cases
FROM `Corona Virus Dataset`
GROUP BY `Country/Region`
ORDER BY max_confirmed_cases DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case
SELECT `Country/Region` AS country,
       MIN(Deaths) AS min_death_cases
FROM `Corona Virus Dataset`
GROUP BY `Country/Region`
ORDER BY min_death_cases ASC
LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT `Country/Region` AS country,
       SUM(Recovered) AS total_recovered_cases
FROM `Corona Virus Dataset`
GROUP BY `Country/Region`
ORDER BY total_recovered_cases DESC
LIMIT 5;

























