

  create or replace view `aec-students`.`dbt_robert`.`stg_github__issue_tmp`
  OPTIONS()
  as select *
from `analytics-engineers-club`.`github`.`issue`;

