

  create or replace view `aec-students`.`dbt_robert`.`customers`
  OPTIONS()
  as select 

C.id
,C.name
,C.email 
,MIN(O.created_at) as first_order_at
,COUNT(O.id) as number_of_orders
--I've acceted your change.local
from `analytics-engineers-club.coffee_shop.customers` as C
left join `analytics-engineers-club.coffee_shop.orders` as O on C.id = O.customer_id

GROUP BY
C.id
,C.name
,C.email

order by first_order_at limit 5;

