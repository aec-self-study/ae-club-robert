{{config(
    materialized= 'table'
)}}

SELECT * from {{ source('web_tracking', 'pageviews')}}

--id,
--visitor_id,		
--device_type,	
--timestamp,	
--page,
--customer_id

--from `analytics-engineers-club.web_tracking.pageviews`