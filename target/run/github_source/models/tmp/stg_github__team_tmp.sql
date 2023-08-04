

  create or replace view `aec-students`.`dbt_robert`.`stg_github__team_tmp`
  OPTIONS()
  as 

select * 
from `aec-students`.`github`.`team`;

