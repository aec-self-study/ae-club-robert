select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select year_week_ordercreated
from `aec-students`.`dbt_robert`.`dbtcustomers_revenuereport`
where year_week_ordercreated is null



      
    ) dbt_internal_test