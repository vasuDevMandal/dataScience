/*
Task 8: Identifying Repeat Customers (6 Marks)
Walmart needs to identify customers who made repeat purchases within a specific time frame (e.g., within 30
days).
*/

select distinct a.`Customer ID`
from walmartsales_dataset a
 join walmartsales_dataset b
  on a.`Customer ID` = b.`Customer ID`
  and a.`Invoice ID` != b.`Invoice ID`
  and ABS(DATEDIFF(STR_TO_DATE(a.Date, '%d-%m-%Y'), STR_TO_DATE(b.Date, '%d-%m-%Y'))) <= 30;

