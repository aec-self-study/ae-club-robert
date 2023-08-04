

  create or replace view `aec-students`.`dbt_robert`.`stg_github__issue_merged_tmp`
  OPTIONS()
  as select *
from `aec-students`.`github`.`issue_merged`;

