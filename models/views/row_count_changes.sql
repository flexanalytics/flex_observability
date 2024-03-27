with row_count_history as (
    select
        model_execution_id,
        unique_id,
        invocation_id,
        generated_at,
        execution_name,
        resource_type,
        full_refresh,
        materialization,
        cast(rows_affected as numeric(10, 4)) as rows_affected,
        cast(lag(rows_affected)
            over (partition by unique_id order by execute_completed_at desc)
        as numeric(10, 4)) as previous_row_count,
        (rows_affected - previous_row_count)
        / nullif(previous_row_count, 0) as perc_diff
    from {{ ref('stg_run_result') }}
)

select
    model_execution_id,
    unique_id,
    invocation_id,
    generated_at,
    execution_name,
    resource_type,
    full_refresh,
    materialization,
    rows_affected,
    previous_row_count,
    perc_diff
from row_count_history where abs(perc_diff) > .05
