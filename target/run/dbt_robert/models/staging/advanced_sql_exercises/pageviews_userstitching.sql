
  
    

    create or replace table `aec-students`.`dbt_robert`.`pageviews_userstitching`
    
    

    OPTIONS()
    as (
      

SELECT

id,
visitor_id,		
device_type,	
timestamp,	
page,
customer_id

from `analytics-engineers-club.web_tracking.pageviews`
    );
  