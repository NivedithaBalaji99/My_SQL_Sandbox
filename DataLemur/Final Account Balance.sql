/*
Given a table containing information about bank deposits and withdrawals made using Paypal, write a query to retrieve the final account balance for each account, taking into account all the transactions recorded in the table with the assumption that there are no missing transactions.
*/


select account_id,sum(amt) from (
SELECT account_id,amount,transaction_type,
case when TRANSACTION_type = 'Deposit' then amount else -amount end as amt FROM
transactions
)a group by account_id 
