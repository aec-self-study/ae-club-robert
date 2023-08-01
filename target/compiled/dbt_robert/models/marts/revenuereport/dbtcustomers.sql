

select
--latest one 3
C.id
,C.name
,C.email 
--,O.created_at
,MIN(O.created_at) as first_order_at
--,format_date('%G-%V', O.created_at) as year_week_ordercreated
,COUNT(O.id) as number_of_orders
,CASE
    when COUNT(O.id) > 1 then TRUE
    else FALSE
END as is_returning_customer

from `analytics-engineers-club.coffee_shop.customers` as C
left join `analytics-engineers-club.coffee_shop.orders` as O on C.id = O.customer_id

GROUP BY
C.id
,C.name
,C.email

--order by first_order_at 
limit 5