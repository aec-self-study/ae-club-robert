select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select first_order_at
from `aec-students`.`dbt_robert`.`dbtcustomers`
where first_order_at is null



      
    ) dbt_internal_test