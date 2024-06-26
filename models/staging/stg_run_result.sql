select
    model_execution_id,
    unique_id,
    invocation_id,
    cast(generated_at as datetime) as generated_at,
    cast(created_at as datetime) as created_at,
    name as execution_name,
    message,
    status,
    resource_type,
    cast(execution_time as decimal(10, 2)) as execution_time,
    cast(execute_started_at as datetime) as execute_started_at,
    cast(execute_completed_at as datetime) as execute_completed_at,
    cast(compile_started_at as datetime) as compile_started_at,
    cast(compile_completed_at as datetime) as compile_completed_at,
    rows_affected,
    full_refresh,
    compiled_code,
    failures,
    query_id,
    thread_id,
    materialization,
    adapter_response
from {{ source('observability', 'dbt_run_results') }}
