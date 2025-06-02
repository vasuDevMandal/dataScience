/*
Task 6: Monthly Sales Distribution by Gender (6 Marks)
Walmart wants to understand the sales distribution between male and female customers on a monthly basis.
*/

with monthly_sales as (
   select
        DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') as month,
        Gender,
        SUM(Total) as total_sales
    from walmartsales_dataset
    group by month, Gender
)
select 
    month,
    Gender,
    total_sales
from monthly_sales
order by month, Gender;
