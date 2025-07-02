/*
Task 3: Analyzing Customer Segmentation Based on Spending (6 Marks)
Walmart wants to segment customers based on their average spending behavior. Classify customers into three
tiers: High, Medium, and Low spenders based on their total purchase amounts.
*/

-- select * from walmartsales_dataset;

WITH customer_avg AS (
    SELECT 
        `Customer ID`,
        AVG(Total) AS avg_spend
    FROM walmartsales_dataset
    GROUP BY `Customer ID`
),

min_max_vals AS (
    SELECT 
        MIN(avg_spend) AS min_val,
        MAX(avg_spend) AS max_val
    FROM customer_avg
),

classified_customers AS (
    SELECT 
        c.`Customer ID`,
        c.avg_spend,
        m.min_val,
        m.max_val,
        (m.max_val - m.min_val) AS range_val,
        CASE
            WHEN c.avg_spend <= m.min_val + (m.max_val - m.min_val) * 1/3 THEN 'Low'
            WHEN c.avg_spend <= m.min_val + (m.max_val - m.min_val) * 2/3 THEN 'Medium'
            ELSE 'High'
        END AS spending_tier
    FROM customer_avg c
    JOIN min_max_vals m
)

SELECT `Customer ID`, ROUND(avg_spend,2) AS avg_spend, spending_tier
FROM classified_customers
ORDER BY avg_spend DESC;

