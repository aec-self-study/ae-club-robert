{% snapshot favorite_ice_cream_flavors %}
{{ config(
      target_schema='dbt_robert_snapshots',
      unique_key='github_username',
      strategy='timestamp',
      updated_at='updated_at',
 ) }}
select 
*
from 
--`analytics-engineers-club.advanced_dbt_examples.favorite_ice_cream_flavors`
{{ source('advanced_dbt_examples', 'favorite_ice_cream_flavors') }}
--where github_username = 'rschembri'

{% endsnapshot %}