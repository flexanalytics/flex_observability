select
    model_execution_id,
    unique_id,
    invocation_id,
    generated_at,
    execution_name,
    status,
    execution_time,
    rows_affected,
    execute_started_at,
    execute_completed_at,
    compile_started_at,
    compile_completed_at,
    materialization,
    full_refresh
from {{ ref('stg_run_result') }}
