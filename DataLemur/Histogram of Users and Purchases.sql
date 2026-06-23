/*
Assume you're given a table on Walmart user transactions. Based on their most recent transaction date, write a query that retrieve the users along with the number of products they bought.

Output the user's most recent transaction date, user ID, and the number of products, sorted in chronological order by the transaction date.
*/


with base as (
SELECT *,dense_rank() over (partition by user_id order by transaction_date desc) rnk
FROM user_transactions
)


select transaction_date,user_id,count(product_id) as purchase_count from base
where rnk = 1
group by transaction_date,user_id
order by transaction_date;
