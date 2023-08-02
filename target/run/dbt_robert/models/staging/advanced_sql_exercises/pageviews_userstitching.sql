
  
    

    create or replace table `aec-students`.`dbt_robert`.`pageviews_userstitching`
    
    

    OPTIONS()
    as (
      

-- SELECT * from `analytics-engineers-club`.`web_tracking`.`pageviews`

--id,
--visitor_id,		
--device_type,	
--timestamp,	
--page,
--customer_id

--from `analytics-engineers-club.web_tracking.pageviews`

with pageviews as (
    select * from `analytics-engineers-club`.`web_tracking`.`pageviews`
),

visitors as (
    select * from `aec-students`.`dbt_robert`.`visitors_userstitching`
),

joined as (
    select
        pageviews.*,
        -- customer id if we have it, else visitor id
        coalesce(
            visitors.first_customer_id,
            pageviews.visitor_id
        ) as blended_user_id,

        visitors.first_visitor_id

    from pageviews
    left join visitors
        on pageviews.visitor_id = visitors.visitor_id
)

select * from joined
    );
  