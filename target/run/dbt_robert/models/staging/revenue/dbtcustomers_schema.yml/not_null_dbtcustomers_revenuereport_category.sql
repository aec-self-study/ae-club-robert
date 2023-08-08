select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select category
from `aec-students`.`dbt_robert`.`dbtcustomers_revenuereport`
where category is null



      
    ) dbt_internal_test