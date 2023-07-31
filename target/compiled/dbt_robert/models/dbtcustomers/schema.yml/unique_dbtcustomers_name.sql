
    
    

with dbt_test__target as (

  select name as unique_field
  from `aec-students`.`dbt_robert`.`dbtcustomers`
  where name is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


