--Created a table "covid".
create table covid(
	Province VARCHAR(40),
	Country_Region VARCHAR(40),
	Latitude FLOAT,
	Longitude FLOAT,
	date_s DATE,
	Confirmed INT,
	Deaths INT,
	Recovered INT);
select * from covid;

--Changed the datestyle from DD-MM-YYYY to YYYY-MM-DD.
set DateStyle TO 'ISO, DMY';

--Imported the Corona virus dataset.
copy covid
from'C:/SQL/CoronaVirusDataset.csv'
delimiter ',' csv header;
select * from covid;

--Q1.Write a code to check NULL values.
select * from covid 
where province is null or
country_region is null or
latitude is null or
longitude is null or
date_s is null or
confirmed is null or
deaths is null or
recovered is null;

--Q2.If NULL values are present, update them with zeros for all columns.
--Thus there are no null values in the dataset.

--Q3.check total number of rows.
select count(*) as total_rows
from covid;

--Q4.Check what is start_date and end_date.
select min(date_s) as start_date,max(date_s) as end_date
FROM covid;

--Q5.Number of month present in dataset.
SELECT
COUNT(DISTINCT EXTRACT(YEAR FROM date_s) * 100 + EXTRACT(MONTH FROM date_s)) AS num_months
FROM covid;

SELECT COUNT(DISTINCT EXTRACT(MONTHS FROM date_s)) AS num_months
FROM covid;

--Q6.Find monthly average for confirmed,deaths,recovered.
select extract(month from date_s) as month,
avg(Confirmed) as avg_confirmed,
avg(Deaths) as avg_deaths,
avg(Recovered) as avg_recovered
from covid
GROUP BY month
ORDER BY month;

--??? Q7.Find most frequent value for confirmed,deaths,recovered each month. 
select extract(month from date_s) as month,
mode() within group (ORDER BY Confirmed) as most_freq_confirmed,
mode() within group (ORDER BY Deaths) as most_freq_deaths,
mode() within group (ORDER BY Recovered) as most_freq_recovered
from covid
GROUP BY month
ORDER BY month;

--Q8.Find minimum values for confirmed,deaths,recovered per year.
select extract(year from date_s) as year,
min(Confirmed) as min_confirmed,
min(Deaths) as min_deaths,
min(Recovered) as min_recovered
from covid
GROUP BY year
ORDER BY year;

--Q9.Find maximum values of confirmed,deaths,recovered per year.
select extract(year from date_s) as year,
max(Confirmed) as max_confirmed,
max(Deaths) as max_deaths,
max(Recovered) as max_recovered
from covid
GROUP BY year
ORDER BY year;

--Q10.The total number of case of confirmed,deaths,recovered each month.
select extract(month from date_s) as month,
sum(Confirmed) as total_confirmed,
sum(Deaths) as total_deaths,
sum(Recovered) as total_recovered
FROM covid
GROUP BY month
ORDER BY month;

--Q11.Check how corona virus spread out with respect to confirmed case.
--(Eg.: total confirmed cases, their average, variance & STDEV)
select 
sum(Confirmed) as total_confirmed,
avg(Confirmed) as avg_confirmed,
variance(Confirmed) as var_confirmed,
STDDEV(Confirmed) as stdev_confirmed
FROM covid;

--Q12.Check how corona virus spread out with respect to death case per month.
--(Eg.: total confirmed cases,their average,variance & STDEV)
select
sum(Deaths) as total_deaths,
avg(Deaths) as avg_deaths,
variance(Deaths) as var_deaths,
STDDEV(Deaths) AS stdev_deaths
from covid;

--Q13.Check how corona virus spread out with respect to recovered case.
--(Eg.: total confirmed cases,their average,variance & STDEV)
select
sum(Recovered) as total_recovered,
avg(Recovered) as avg_recovered,
variance(Recovered) as var_recovered,
STDDEV(Recovered) as stdev_recovered
FROM covid;

--Q14.Find Country having highest number of the Confirmed case.
select Country_Region,max(Confirmed) as max_confirmed
from covid
GROUP BY Country_Region
ORDER BY max_confirmed DESC
LIMIT 1;

--Q15.Find Country having lowest number of the death case.
select Country_Region,sum(deaths) as total_deaths
from covid
GROUP BY Country_Region
ORDER BY total_deaths 
LIMIT 1;

--Q16.Find top 5 countries having highest recovered case.
select Country_Region,sum(Recovered) as total_recovered
from covid
GROUP BY Country_Region
ORDER BY total_recovered DESC
LIMIT 5;

