{{config(
    materialized= 'incremental'
)}}

select 

C.id,
C.name,
C.email,
O.created_at as order_created_date

from {{source ('coffee_shop', 'customers')}} as C
left join {{source ('coffee_shop', 'orders')}} as O on C.id = O.customer_id

{% if is_incremental() %}
where O.created_at > ( select max(order_created_date) from {{ this }} )
{% endif %}

group by 1,2,3,4

order by order_created_date limit 500

-- I think this model needs to be changed as follows so that the initial date can be compared to {{ this }}, but couldnt get it to work.

-- with customerorders as (
-- select 
-- 
-- *
-- 
-- from {{source ('coffee_shop', 'customers')}} as C
-- left join {{source ('coffee_shop', 'orders')}} as O on C.id = O.customer_id
-- )
-- 
-- aggregated as(
--     C.id,
-- C.name,
-- C.email,
-- O.created_at as order_created_date
-- 
-- group by 1,2,3 
-- limit 500
-- 
-- )