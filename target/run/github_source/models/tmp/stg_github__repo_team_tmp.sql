

  create or replace view `aec-students`.`dbt_robert`.`stg_github__repo_team_tmp`
  OPTIONS()
  as 

select * 
from `aec-students`.`github`.`repo_team`;

