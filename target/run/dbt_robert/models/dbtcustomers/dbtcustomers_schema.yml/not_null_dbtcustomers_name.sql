select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select name
from `aec-students`.`dbt_robert`.`dbtcustomers`
where name is null



      
    ) dbt_internal_test