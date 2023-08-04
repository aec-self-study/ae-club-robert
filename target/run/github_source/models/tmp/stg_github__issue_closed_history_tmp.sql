

  create or replace view `aec-students`.`dbt_robert`.`stg_github__issue_closed_history_tmp`
  OPTIONS()
  as select *
from `analytics-engineers-club`.`github`.`issue_closed_history`;

