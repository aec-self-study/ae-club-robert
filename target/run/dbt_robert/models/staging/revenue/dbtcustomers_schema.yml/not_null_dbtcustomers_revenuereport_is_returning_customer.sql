select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_returning_customer
from `aec-students`.`dbt_robert`.`dbtcustomers_revenuereport`
where is_returning_customer is null



      
    ) dbt_internal_test