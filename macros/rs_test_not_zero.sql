{% test not_zero(model, column_name) %}

    SELECT  
        {{ column_name }}
    FROM {{ model }}
where not amount >=0

 {% endtest %}
