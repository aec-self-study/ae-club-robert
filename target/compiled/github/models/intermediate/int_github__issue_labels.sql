with  __dbt__cte__int_github__issue_label_joined as (
with issue_label as (

    select *
    from `aec-students`.`dbt_robert`.`stg_github__issue_label`

), label as (

    select *
    from `aec-students`.`dbt_robert`.`stg_github__label`

), joined as (

    select 
        issue_label.issue_id,
        label.label
    from issue_label
    left join label 
        on issue_label.label_id = label.label_id

)

select *
from joined
),issue_label as (
    select *
    from __dbt__cte__int_github__issue_label_joined
)

select
  issue_id,
  
    string_agg(label, ', ')

 as labels
from issue_label
group by issue_id