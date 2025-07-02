/*
Task 2: Finding the Most Profitable Product Line for Each Branch (6 Marks)
Walmart needs to determine which product line contributes the highest profit to each branch.The profit margin
should be calculated based on the difference between the gross income and cost of goods sold.
*/

-- select * from walmartsales_dataset;

WITH product_profit AS (
    SELECT
        Branch,
        `Product line` AS product_line,
        SUM(`gross income`) AS total_profit
    FROM walmartsales_dataset
    GROUP BY Branch, product_line
),

ranked_profit AS (
    SELECT *,
        RANK() OVER (PARTITION BY Branch ORDER BY total_profit DESC) AS rnk
    FROM product_profit
)

SELECT
    Branch,
    product_line,
    ROUND(total_profit, 2) AS total_profit
FROM ranked_profit
WHERE rnk = 1;

-- to validate uncomment and chack first of every branch
-- SELECT Branch, `Product line`, SUM(`gross income`) AS profit
-- FROM walmartsales_dataset
-- GROUP BY Branch, `Product line`
-- ORDER BY Branch, profit DESC;
