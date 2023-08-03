with issue_comment as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__issue_comment`
)

select
  issue_id,
  count(*) as number_of_comments
from issue_comment
group by issue_id