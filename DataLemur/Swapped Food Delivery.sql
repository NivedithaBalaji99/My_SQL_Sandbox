/*
Zomato is a leading online food delivery service that connects users with various restaurants and cuisines, allowing them to browse menus, place orders, and get meals delivered to their doorsteps.

Recently, Zomato encountered an issue with their delivery system. Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID and item.

If the last item has an odd order ID, it should remain as the last item in the corrected data. For example, if the last item is Order ID 7 Tandoori Chicken, then it should remain as Order ID 7 in the corrected data.

In the results, return the correct pairs of order IDs and items.
*/


/* 
-- this only works if total number of orders are odd
select order_id,case when order_id <= (select count(order_id) from orders )-1 then COALESCE(l,la) else item end as item 
from (
SELECT order_id,item ,case when order_id % 2= 0 then item end as odd_order,
lead(case when order_id % 2= 0 then item end) over (order by order_id) as l,
case when order_id % 2 != 0 then item end as even_order,
lag(case when order_id % 2 != 0 then item end) over (order by order_id) as la
FROM orders
)a;

*/

SELECT 
    order_id,
    COALESCE(
        CASE 
            WHEN order_id % 2 != 0 THEN LEAD(item) OVER (ORDER BY order_id) -- Odd rows look down
            ELSE LAG(item) OVER (ORDER BY order_id)                         -- Even rows look up
        END, 
        item -- Fallback for the last odd row when LEAD() returns NULL
    ) AS item
FROM orders
ORDER BY order_id;
