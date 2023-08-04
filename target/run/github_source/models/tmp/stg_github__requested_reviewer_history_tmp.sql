

  create or replace view `aec-students`.`dbt_robert`.`stg_github__requested_reviewer_history_tmp`
  OPTIONS()
  as select *
from `analytics-engineers-club`.`github`.`requested_reviewer_history`;

