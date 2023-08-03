with issue_label as (

    select *
    from `aec-students`.`dbt_robert`.`stg_github__label_tmp`

), macro as (
    select
        /*
        The below macro is used to generate the correct SQL for package staging models. It takes a list of columns 
        that are expected/needed (staging_columns from dbt_github_source/models/tmp/) and compares it with columns 
        in the source (source_columns from dbt_github_source/macros/).

        For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
        */
            
    
    
    _fivetran_synced
    
 as 
    
    _fivetran_synced
    
, 
    
    
    color
    
 as 
    
    color
    
, 
    
    
    description
    
 as 
    
    description
    
, 
    
    
    id
    
 as 
    
    id
    
, 
    
    
    is_default
    
 as 
    
    is_default
    
, 
    
    
    name
    
 as 
    
    name
    
, 
    
    
    url
    
 as 
    
    url
    




    from issue_label

), fields as (

    select 
        id as label_id,
        _fivetran_synced,	
        color,
        description,
        is_default,
        name as label,
        url
    from macro
)

select *
from fields