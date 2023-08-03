
  
    

    create or replace table `aec-students`.`dbt_robert`.`visitors_userstitching`
    
    

    OPTIONS()
    as (
      


-- one record per visitor id
with visitors_userstitching as (
    select distinct
        visitor_id,

        first_value(customer_id ignore nulls) over (
            partition by visitor_id
            order by timestamp
            range between unbounded preceding and unbounded following
        ) as first_customer_id,

        min(timestamp) over (
            partition by visitor_id
        ) as first_seen_at,

        max(timestamp) over (
            partition by visitor_id
        ) as last_seen_at


    from `analytics-engineers-club`.`web_tracking`.`pageviews`
)
select
    *,
    first_value(visitor_id) over (
        partition by coalesce(first_customer_id, visitor_id)
        order by first_seen_at
    ) as first_visitor_id
from visitors_userstitching
    );
  