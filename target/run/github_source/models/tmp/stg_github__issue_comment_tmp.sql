

  create or replace view `aec-students`.`dbt_robert`.`stg_github__issue_comment_tmp`
  OPTIONS()
  as select *
from `aec-students`.`github`.`issue_comment`;

