select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

    SELECT  
        amount
    FROM `aec-students`.`dbt_robert`.`dbtcustomers_revenuereport`
where not amount >=0

 
      
    ) dbt_internal_test