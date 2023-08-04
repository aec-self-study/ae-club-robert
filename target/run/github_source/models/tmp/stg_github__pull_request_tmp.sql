

  create or replace view `aec-students`.`dbt_robert`.`stg_github__pull_request_tmp`
  OPTIONS()
  as select *
from `aec-students`.`github`.`pull_request`;

