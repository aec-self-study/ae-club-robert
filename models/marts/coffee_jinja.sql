{{config(
    materialized= 'table')
}}
{% set product_category = ["coffee beans", "merch", "brewing supplies"] %}

select
  date_trunc(sold_at, month) as date_month,
 -- sum(case when product_category = 'coffee beans' then amount end) as coffee_beans_amount,
 -- sum(case when product_category = 'merch' then amount end) as merch_amount,
 -- sum(case when product_category = 'brewing supplies' then amount end) as brewing_supplies_amount

{% for product_category in product_category %}
sum(case when product_category = '{{product_category}}' then amount end) as {{product_category}}_amount,
{% endfor %}

-- you may have to `ref` a different model here, depending on what you've built previously
from {{ ref('dbtcustomers_revenuereport') }}
group by 1