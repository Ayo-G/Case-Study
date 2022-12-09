# Bamboo Interview Questions (Case Study)
This is the case study part of the Bamboo Data Analyst interview. There are two different cast studies with which have seperate datasets provided. The datasets can be found in the dataset folder in this repo.

## First Case Study
dataset - [deposit.csv](https://github.com/Ayo-G/Case-Study/blob/main/Bamboo/datasets/deposits.csv)
#### Dataset Overview
The following table has the first 1000 rows of approx. 900k records of trades made on the Bamboo platform by its users since inception. Given the following documentation, answer the questions below in the form of a query.
- id: Transaction id
- amount: Money paid by the user in $
- status: Status of deposit (Note: 'Settlemented' refers to completed/accepted)
- user_id: Id of user
- payment_method_id: Id of payment type (up to 7)
- inserted_at: DateTime of the transaction first captured by the database
- updated_at: DateTime of transaction last updated by database
- amount_paid: If in Naira, the amount is converted in local currency
- fee: Transaction fee
- exchange_rate: The exchange rate benchmarked to the dollar
- deposit_type: Type of deposit (Standard or Instant)
- dollar_instant_deposit_fee: Fee if deposit type in dollar
- dollar_processing_fee: Processing fee in dollar
- currency: USD or Naira
#### Questions
1. What is the median/average deposit value of those using payment method 3 in 2020?
2. When, in terms of which month of which year, did we observe the peak and valley (max and min) of deposit volume for Bamboo since inception?
3. Who are our power (most frequent) depositors by volume in 2021? Retrieve the user_id and the total volume of those users
4. We define High Net Worth individuals as people depositing $10k or above. Retrieve the user_id and the total deposits for users in that segment
5. What's the most used payment method among all users by volume?
6. What's the average transaction fee?

## Second Case study
dataset - [trades.csv](https://github.com/Ayo-G/Case-Study/blob/main/Bamboo/datasets/trades.csv)
#### Dataset Overview
The following table has the first 1000 rows of approx. 900k records of trades made on the Bamboo platform by its users since inception. Given the following documentation, answer the questions below in the form of a query

- id: Transaction Id
- price_per_share: Share price
- side: Trade side (BUY/SELL)
- stock_symbol: Tick Symbol of Stock
- transaction_value: Dollar amount for transaction
- type: Transaction type
- user_id: id of user
- quantity: Number of shares
- inserted_at: DateTime first captured by database
- updated_at: DateTime last updated by database
- naira_fee: 1.5% commission on the transaction value (in $) then converted in Naira
- dollar_fee: 1.5% commission on the transaction value (in $)
- status: Trade's stage of approval  (Note: Filled refers to accepted/completed)
#### Questions
1. Obtain the month-over-month change in absolute value and percentage for all completed (where status=Filled)Trades in 2020?
2. Retrieve the list of user_id for those traded above 300x in 2020?
3. Find the best performing week, by total transaction value, from 2019 until today?
4. What are the top 5 bought stocks by volume? 
5. What are the trade commissions for each side? 
6. Which stock generated the most commissions from the BUY side?
##### Ad-hoc Questions
- Count all users who deposited since bamboo began but haven't traded
- Count all users with deposits under $1k
- Count all users who had 4 or more trades before 2021 but have not traded in 2021
- Count all users who had 2 or more deposits before 2021 but have not deposited in 2021
