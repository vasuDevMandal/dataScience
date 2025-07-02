/*
Task 4: Detecting Anomalies in Sales Transactions (6 Marks)
Walmart suspects that some transactions have unusually high or low sales compared to the average for the
product line. Identify these anomalies.
*/


select 
    `Invoice ID`,
    `Product line`,
    Total,
    (select avg(Total) from walmartsales_dataset as w2 where w2.`Product line` = w1.`Product line`) as avg_total
FROM walmartsales_dataset as w1
WHERE 
    Total > (SELECT avg(Total) from walmartsales_dataset as w2 where w2.`Product line` = w1.`Product line`) * 2
    or
    Total < (SELECT avg(Total) from walmartsales_dataset as w2 where w2.`Product line` = w1.`Product line`) * 0.01;

