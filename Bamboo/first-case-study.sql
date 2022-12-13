/*
Question 1
What is the median/average deposit value of those using payment method 3 in 2020?
*/

select
    avg(amount) as avg_deposit
from
    Bamboo.deposits
where
    payment_method_id = 3
and
    EXTRACT(YEAR FROM inserted_at) = 2020 


/*
Question 2
When, in terms of which month of which year, did we observe the peak and valley (max and min) of deposit volume for Bamboo since inception?
*/

with refined_dates as
(
    select
        inserted_at,
        extract(month from inserted_at) as month,
        extract(year from inserted_at) as year,
        amount
    from
        Bamboo.deposits
),

refined_volume as
(
    select
        month,
        year,
        sum(amount) as total_deposit
    from
        refined_dates
    group by
        month,
        year
),

condition as
(
    select
        month,
        year,
        total_deposit,
        DENSE_RANK() OVER (ORDER BY total_deposit) AS volume_rank
    from 
        refined_volume rv
    order by
        volume_rank
)

select
    month,
    year,
    total_deposit,
    case when volume_rank = 6 then 'month with maximum deposit'
         when volume_rank = 1 then 'month with minimum deposit'
         else 'other months'
    end as remark
from
    condition


/*
Question 3
Who are our power (most frequent) depositors by volume in 2021? Retrieve the user_id and the total volume of those users
*/

select
    user_id,
    count(id) as deposit_frequency,
    sum(amount) as total_deposit
from
    Bamboo.deposits
where
    extract(year from inserted_at) = 2021
group by
    user_id
having
    deposit_frequency > 1
order by
    deposit_frequency desc,
    total_deposit desc


/*
Question 4
We define High Net Worth individuals as people depositing $10k or above. Retrieve the user_id and the total deposits for users in that segment
*/

with transactions as
(
    select
        user_id,
        id,
        sum(amount) as total_deposits
    from
        Bamboo.deposits
    where
        amount > 10000
    group by
        1, 2
)

select
    user_id,
    total_deposits
from
    transactions
order by
    total_deposits desc


/*
Question 5
What's the most used payment method among all users by volume?
*/

select
    payment_method_id,
    count(payment_method_id) as methods_volume
from
    Bamboo.deposits
group by 
    1


/*
Question 6
What's the average transaction fee?
*/

select
    round(avg(fee), 2) as average_fee
from
    Bamboo.deposits