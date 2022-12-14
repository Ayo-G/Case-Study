/*
Question 1
Count all users who deposited since bamboo began but haven't traded
*/

select
    count(distinct user_id) as not_traded
from
    Bamboo.deposits
where
    user_id in 
        (
            select
                distinct user_id
            from
                Bamboo.trades
        )
		
/*
Question 2
Count all users with deposits under $1k
*/

with all_deposits as
(
    select
        user_id,
        sum(amount) as deposits_
    from
        Bamboo.deposits
    group by
        user_id
    having
        deposits_ < 1000
)

select
    count(user_id) as user_count
from
    all_deposits


/*
Question 3
Count all users who had 4 or more trades before 2021 but have not traded in 2021
*/

with formatted_table as
(
    select
        user_id,
        count(id) as trades_count
    from 
        Bamboo.trades
    where
        extract(year from inserted_at) < 2021
    group by
        user_id
    having
        count(id) >= 4
)

select
    count(distinct user_id) users
from
    formatted_table
where user_id not in
    (
        select 
            user_id
        from 
            Bamboo.trades
        where
            extract(year from inserted_at) = 2021
    )



/*
Question 4
Count all users who had 2 or more deposits before 2021 but have not deposited in 2021
*/

with formatted_table as
(
    select
        user_id,
        count(id) as trades_count
    from 
        Bamboo.deposits
    where
        extract(year from inserted_at) < 2021
    group by
        user_id
    having
        count(id) >= 2
)

select
    count(distinct user_id) users
from
    formatted_table
where user_id not in
    (
        select 
            user_id
        from 
            Bamboo.deposits
        where
            extract(year from inserted_at) = 2021
    )
