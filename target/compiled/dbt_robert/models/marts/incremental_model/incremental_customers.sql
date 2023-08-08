

select 

C.id,
C.name,
C.email,
O.created_at as order_created_date

from `analytics-engineers-club`.`coffee_shop`.`customers` as C
left join `analytics-engineers-club`.`coffee_shop`.`orders` as O on C.id = O.customer_id


where O.created_at > ( select max(order_created_date) from `aec-students`.`dbt_robert`.`incremental_customers` )


group by 1,2,3,4


order by order_created_date limit 500