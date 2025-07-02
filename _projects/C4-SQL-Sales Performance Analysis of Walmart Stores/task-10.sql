/*
Task 10: Analyzing Sales Trends by Day of the Week (6 Marks)
Walmart wants to analyze the sales patterns to determine which day of the week
brings the highest sales.
*/

select 
    dayname(STR_TO_DATE(Date, '%d-%m-%Y')) as day_of_week,
    round(SUM(Total), 2) as total_sales
from walmartsales_dataset
group by day_of_week
order by total_sales desc;
