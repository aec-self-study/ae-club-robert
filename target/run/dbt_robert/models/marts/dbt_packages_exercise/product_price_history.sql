

  create or replace view `aec-students`.`dbt_robert`.`product_price_history`
  OPTIONS()
  as select 

id,
product_id,
price,
created_at,
ended_at

from analytics-engineers-club.coffee_shop.product_prices;

