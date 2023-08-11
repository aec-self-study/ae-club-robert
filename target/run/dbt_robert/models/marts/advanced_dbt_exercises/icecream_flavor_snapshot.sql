

  create or replace view `aec-students`.`dbt_robert`.`icecream_flavor_snapshot`
  OPTIONS()
  as 

select 
  github_username,
  favorite_ice_cream_flavor,
  created_at,
  updated_at

from `analytics-engineers-club`.`advanced_dbt_examples`.`favorite_ice_cream_flavors`
where github_username = 'rschembri';

