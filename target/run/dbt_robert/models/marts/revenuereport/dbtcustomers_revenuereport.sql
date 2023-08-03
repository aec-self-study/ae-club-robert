
  
    

    create or replace table `aec-students`.`dbt_robert`.`dbtcustomers_revenuereport`
    
    

    OPTIONS()
    as (
      

select
C.id
,C.name
,C.email 
,O.created_at as sold_at
,format_date('%G-%V', O.created_at) as year_week_ordercreated
,P.category as product_category
,PP.price as amount
,dbtC.is_returning_customer
,dbtC.number_of_orders



from `analytics-engineers-club.coffee_shop.customers` as C
left join `analytics-engineers-club.coffee_shop.orders` as O on C.id = O.customer_id
left join `analytics-engineers-club.coffee_shop.order_items` as OI  on O.id = OI.order_id
left join `analytics-engineers-club.coffee_shop.products` as P  on P.id = OI.product_id
left join `analytics-engineers-club.coffee_shop.product_prices` as PP  on PP.product_id = OI.product_id
left join `aec-students.dbt_robert.dbtcustomers` as dbtC on C.id = dbtC.id

--GROUP BY
--C.id
--,C.name
--,C.email

--order by first_order_at 
limit 25
    );
  