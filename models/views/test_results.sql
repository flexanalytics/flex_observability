select
    model_execution_id,
    unique_id,
    invocation_id,
    generated_at,
    execution_name,
    status,
    execution_time,
    failures
from {{ ref('stg_run_result') }} where resource_type = 'test'
