{{config(
    materialized= 'table'
)}}

SELECT

id,
visitor_id,		
device_type,	
timestamp,	
page,
customer_id

from `analytics-engineers-club.web_tracking.pageviews`