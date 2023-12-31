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
),  __dbt__cte__int_github__issue_labels as (
with issue_label as (
    select *
    from __dbt__cte__int_github__issue_label_joined
)

select
  issue_id,
  
    string_agg(label, ', ')

 as labels
from issue_label
group by issue_id
),  __dbt__cte__int_github__issue_assignees as (
with issue_assignee as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__issue_assignee`
), 

github_user as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__user`
)

select
  issue_assignee.issue_id,
  
    string_agg(github_user.login_name, ', ')

 as assignees
from issue_assignee
join github_user on issue_assignee.user_id = github_user.user_id
group by 1
),  __dbt__cte__int_github__issue_open_length as (
with issue as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__issue`
), 

issue_closed_history as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__issue_closed_history`
), 

close_events_stacked as (
    select   
      issue_id,
      created_at as updated_at,
      false as is_closed
    from issue -- required because issue_closed_history table does not have a line item for when the issue was opened
    union all
    select
      issue_id,
      updated_at,
      is_closed
    from issue_closed_history
), 

close_events_with_timestamps as (
  select
    issue_id,
    updated_at as valid_starting,
    coalesce(lead(updated_at) over (partition by issue_id order by updated_at), current_timestamp) as valid_until,
    is_closed
  from close_events_stacked
)

select
  issue_id,
  sum(

    datetime_diff(
        cast(valid_until as datetime),
        cast(valid_starting as datetime),
        second
    )

  ) /60/60/24 as days_issue_open,
  count(*) - 1 as number_of_times_reopened
from close_events_with_timestamps
  where not is_closed
group by issue_id
),  __dbt__cte__int_github__issue_comments as (
with issue_comment as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__issue_comment`
)

select
  issue_id,
  count(*) as number_of_comments
from issue_comment
group by issue_id
),  __dbt__cte__int_github__pull_request_times as (
with pull_request_review as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__pull_request_review`
), 

pull_request as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__pull_request`
), 

requested_reviewer_history as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__requested_reviewer_history`
    where not removed
), 

issue as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__issue`
), 

issue_merged as (
    select
      issue_id,
      min(merged_at) as merged_at
      from `aec-students`.`dbt_robert`.`stg_github__issue_merged`
    group by 1
), 

first_request_time as (
    select
      pull_request.issue_id,
      pull_request.pull_request_id,
      -- Finds the first review that is by the requested reviewer and is not a dismissal
      min(case when requested_reviewer_history.requested_id = pull_request_review.user_id then
          case when lower(pull_request_review.state) in ('commented', 'approved', 'changes_requested') 
                then pull_request_review.submitted_at end 
      else null end) as time_of_first_requested_reviewer_review,
      min(requested_reviewer_history.created_at) as time_of_first_request,
      min(pull_request_review.submitted_at) as time_of_first_review_post_request
    from pull_request
    join requested_reviewer_history on requested_reviewer_history.pull_request_id = pull_request.pull_request_id
    left join pull_request_review on pull_request_review.pull_request_id = pull_request.pull_request_id
      and pull_request_review.submitted_at > requested_reviewer_history.created_at
    group by 1, 2
)

select
  first_request_time.issue_id,
  issue_merged.merged_at,
  

    datetime_diff(
        cast(coalesce(time_of_first_review_post_request, current_timestamp) as datetime),
        cast(time_of_first_request as datetime),
        second
    )

  / 60/60 as hours_request_review_to_first_review,
  

    datetime_diff(
        cast(least(
                            coalesce(time_of_first_requested_reviewer_review, current_timestamp),
                            coalesce(issue.closed_at, current_timestamp)) as datetime),
        cast(time_of_first_request as datetime),
        second
    )

   / 60/60 as hours_request_review_to_first_action,
  

    datetime_diff(
        cast(merged_at as datetime),
        cast(time_of_first_request as datetime),
        second
    )

  / 60/60 as hours_request_review_to_merge
from first_request_time
join issue on first_request_time.issue_id = issue.issue_id
left join issue_merged on first_request_time.issue_id = issue_merged.issue_id
),  __dbt__cte__int_github__pull_request_reviewers as (
with pull_request_review as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__pull_request_review`
), 

github_user as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__user`
),

actual_reviewers as (
  select
    pull_request_review.pull_request_id,
    
    string_agg(distinct github_user.login_name, ', ')

 as reviewers,
    count(*) as number_of_reviews
from pull_request_review
left join github_user on pull_request_review.user_id = github_user.user_id
group by 1
),

requested_reviewer_history as (

    select *
    from `aec-students`.`dbt_robert`.`stg_github__requested_reviewer_history`
    where removed = false
),

requested_reviewers as (
  select
    requested_reviewer_history.pull_request_id,
    
    string_agg(distinct github_user.login_name, ', ')

 as requested_reviewers
from requested_reviewer_history
left join github_user on requested_reviewer_history.requested_id = github_user.user_id
group by 1
),

joined as (
  select
    actual_reviewers.pull_request_id,
    actual_reviewers.reviewers,
    requested_reviewers.requested_reviewers,
    actual_reviewers.number_of_reviews
  from actual_reviewers
  full outer join requested_reviewers 
    on requested_reviewers.pull_request_id = actual_reviewers.pull_request_id
)

select *
from joined
),  __dbt__cte__int_github__issue_joined as (
with issue as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__issue`
), 

issue_labels as (
    select *
    from __dbt__cte__int_github__issue_labels
), 

repository_teams as (
    select 
    
      repository_id,
      full_name as repository
    from `aec-students`.`dbt_robert`.`stg_github__repository`

    
), 

issue_assignees as (
    select *
    from __dbt__cte__int_github__issue_assignees
), 

issue_open_length as (
    select *
    from __dbt__cte__int_github__issue_open_length
), 

issue_comments as (
    select *
    from __dbt__cte__int_github__issue_comments
), 

creator as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__user`
), 

pull_request_times as (
    select *
    from __dbt__cte__int_github__pull_request_times
), 

pull_request_reviewers as (
    select *
    from __dbt__cte__int_github__pull_request_reviewers
), 

pull_request as (
    select *
    from `aec-students`.`dbt_robert`.`stg_github__pull_request`
)

select
  issue.*,
  case 
    when issue.is_pull_request then 'https://github.com/' || repository_teams.repository || '/pull/' || issue.issue_number
    else 'https://github.com/' || repository_teams.repository || '/issues/' || issue.issue_number
  end as url_link,
  issue_open_length.days_issue_open,
  issue_open_length.number_of_times_reopened,
  labels.labels,
  issue_comments.number_of_comments,
  repository_teams.repository,
  
  issue_assignees.assignees,
  creator.login_name as creator_login_name,
  creator.name as creator_name,
  creator.company as creator_company,
  hours_request_review_to_first_review,
  hours_request_review_to_first_action,
  hours_request_review_to_merge,
  merged_at,
  reviewers, 
  requested_reviewers,
  number_of_reviews
from issue
left join issue_labels as labels
  on issue.issue_id = labels.issue_id
join repository_teams
  on issue.repository_id = repository_teams.repository_id
left join issue_assignees
  on issue.issue_id = issue_assignees.issue_id
left join issue_open_length
  on issue.issue_id = issue_open_length.issue_id
left join issue_comments 
  on issue.issue_id = issue_comments.issue_id
left join creator 
  on issue.user_id = creator.user_id
left join pull_request
  on issue.issue_id = pull_request.issue_id
left join pull_request_times
  on issue.issue_id = pull_request_times.issue_id
left join pull_request_reviewers
  on pull_request.pull_request_id = pull_request_reviewers.pull_request_id
),issue_joined as (
    select *
    from __dbt__cte__int_github__issue_joined  
)

select
  *
from issue_joined
where is_pull_request