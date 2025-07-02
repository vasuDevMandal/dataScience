/*
Task 7: Best Product Line by Customer Type (6 Marks)
Walmart wants to know which product lines are preferred by different customer types(Member vs. Normal).
*/

with product_popularity as (
    select 
        `Customer type`,
        `Product line`,
        count(*) as purchase_count
    from walmartsales_dataset
    group by `Customer type`, `Product line`
),
ranked_products as (
    select 
        *,
        rank() OVER (PARTITION BY `Customer type` order by purchase_count desc) as product_rank
    from product_popularity
)
select 
    `Customer type`,
    `Product line` AS most_preferred_product_line,
    purchase_count
from ranked_products
where product_rank = 1
order by `Customer type`;
