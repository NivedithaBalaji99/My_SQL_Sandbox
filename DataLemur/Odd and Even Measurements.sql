/*
Assume you're given a table with measurement values obtained from a Google sensor over multiple days with measurements taken multiple times within each day.

Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day and display the results in two different columns. Refer to the Example Output below for the desired format.

Definition:

Within a day, measurements taken at 1st, 3rd, and 5th times are considered odd-numbered measurements, and measurements taken at 2nd, 4th, and 6th times are considered even-numbered measurements.
*/


select date(measurement_time),
sum(case when rnk % 2 != 0 then measurement_value end )as odd_sum,
sum(case when rnk % 2 = 0 then measurement_value end) as even_sum
from(
SELECT row_number() over ( partition by date(measurement_time ) order by measurement_time) as rnk 
,measurement_value,measurement_time FROM measurements
)a group by date(measurement_time)
order by date(measurement_time)
