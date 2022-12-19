/*
Question 1
Obtain the month-over-month change in absolute value and percentage for all completed (where status=Filled)Trades in 2020?
*/

WITH monthly_revenue AS 
(
    select 
        (extract(year from inserted_at) || ' ' || '-' || extract(month from inserted_at)) as year_month,
        SUM(transaction_value) as revenue
    from 
        Bamboo.trades
    group by 
        1
    order by 
        1
),

monthly_revenue_delayed AS 
(
    select 
        year_month, 
        revenue,
        LAG(revenue, 1) OVER (ORDER BY year_month) as previous_revenue
    from 
        monthly_revenue
    order by
        1
)
                    
select 
    year_month,
    round(revenue, 2) as transaction_value,
    round(abs(revenue - previous_revenue), 2) as absolute_value,
    ROUND((((revenue - previous_revenue) / previous_revenue) * 100),2) as percentage_difference
from 
    monthly_revenue_delayed

/*
Question 2
Retrieve the list of user_id for those traded above 300x in 2020?
*/

select
    user_id
from
    trades
where
    extract(year from inserted_at) = 2020
and
    transaction_value > 300


/*
Question 3
Find the best performing week, by total transaction value, from 2019 until today?
*/

with transactions as
(
    select
        extract(week from inserted_at) as week,
        extract(year from inserted_at) as year,
        round(sum(transaction_value), 2) as total_transaction,
        dense_rank() over(order by sum(transaction_value) desc) as rank_
    from
        trades
    group by
        1, 2
)

select
    week,
    year
from
    transactions
where 
    rank_ = 1
	

/*
Question 4
What are the top 5 bought stocks by volume?
*/

with transactions as 
(
    select
        stock_symbol as stock,
        round(sum(transaction_value), 2) as total_volume
    from
        trades
    where
        side = 'BUY'
    group by
        stock_symbol
    order by
        total_volume desc
    limit
        5
)

select
    stock
from
    transactions
    

/*
Question 5
What are the trade commissions for each side?
(The question didn't seem clear so I had to improvise by findig the average commission for both sides instead)
*/

select
    side,
    round(avg(dollar_fee), 2) as average_commission
from
    trades
group by
    side
	

/*
Question 6
Which stock generated the most commissions from the BUY side?
*/

with commissions as
(
    select
        stock_symbol,
        round(sum(dollar_fee), 2) as total_commission,
        dense_rank() over(order by avg(dollar_fee) desc) as rank_
    from
        trades
    where
        side = 'BUY'
    group by
        1
)

select
    stock_symbol
from
    commissions
where
    rank_ =1