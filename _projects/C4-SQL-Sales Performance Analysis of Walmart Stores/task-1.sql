/*
Task 1: Identifying the Top Branch by Sales Growth Rate (6 Marks)
Walmart wants to identify which branch has exhibited the highest sales growth over time. Analyze the total sales
for each branch and compare the growth rate across months to find the top performer.
*/

-- get the required data
 
WITH monthly_sales AS (
    SELECT 
        Branch,
        DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') AS month,
        SUM(Total) AS total_sales
    FROM walmartsales_dataset
    GROUP BY Branch, month
),

-- Aggregate total sales per branch per month

growth_calc AS (
    SELECT 
        Branch,
        month,
        total_sales,
        LAG(total_sales) OVER (PARTITION BY Branch ORDER BY month) AS prev_month_sales
    FROM monthly_sales
),

-- Calculate the month-over-month growth rate

growth_rate_per_month AS (
    SELECT 
        Branch,
        month,
        ROUND(((total_sales - prev_month_sales) / prev_month_sales) * 100, 2) AS monthly_growth
    FROM growth_calc
    WHERE prev_month_sales IS NOT NULL
),

-- Average (or sum) the growth rates per branch

branch_avg_growth AS (
    SELECT 
        Branch,
        ROUND(AVG(monthly_growth), 2) AS avg_monthly_growth
    FROM growth_rate_per_month
    GROUP BY Branch
)

-- Find the branch with the highest average/sum of growth rates
 
SELECT 
    Branch,
    avg_monthly_growth
FROM branch_avg_growth
ORDER BY avg_monthly_growth DESC;


