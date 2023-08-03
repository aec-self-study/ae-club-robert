

    
    


    
    




with window_functions as (

    select
        
        product_id as partition_by_col,
        
        created_at as lower_bound,
        ended_at as upper_bound,

        lead(created_at) over (
            partition by product_id
            order by created_at, ended_at
        ) as next_lower_bound,

        row_number() over (
            partition by product_id
            order by created_at desc, ended_at desc
        ) = 1 as is_last_record

    from `aec-students`.`dbt_robert`.`product_price_history`

),

calc as (
    -- We want to return records where one of our assumptions fails, so we'll use
    -- the `not` function with `and` statements so we can write our assumptions more cleanly
    select
        *,

        -- For each record: lower_bound should be < upper_bound.
        -- Coalesce it to return an error on the null case (implicit assumption
        -- these columns are not_null)
        coalesce(
            lower_bound < upper_bound,
            false
        ) as lower_bound_less_than_upper_bound,

        -- For each record: upper_bound < the next lower_bound.
        -- Coalesce it to handle null cases for the last record.
        coalesce(
            upper_bound < next_lower_bound,
            is_last_record,
            false
        ) as upper_bound_less_than_next_lower_bound

    from window_functions

),

validation_errors as (

    select
        *
    from calc

    where not(
        -- THE FOLLOWING SHOULD BE TRUE --
        lower_bound_less_than_upper_bound
        and upper_bound_less_than_next_lower_bound
    )
)

select * from validation_errors
