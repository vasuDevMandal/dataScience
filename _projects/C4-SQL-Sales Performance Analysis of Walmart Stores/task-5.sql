/*
Task 5: Most Popular Payment Method by City (6 Marks)
Walmart needs to determine the most popular payment method in each city to tailor marketing strategies.
*/

-- select * from walmartsales_dataset;

with payment_counts as (
    select 
        City,
        Payment,
        COUNT(*) as payment_count
    from walmartsales_dataset
    group by City, Payment
),
ranked_payments as (
    select 
        *,
        rank() OVER (partition by City order by payment_count desc) as payment_rank
    from payment_counts
)
select 
    City,
    Payment as most_popular_payment,
    payment_count
from ranked_payments
where payment_rank = 1
order by City;
