select
    {{ dbt_utils.generate_surrogate_key(['model_execution_id']) }} as execution_key,
    {{ dbt_utils.generate_surrogate_key(['unique_id']) }} as model_key,
    {{ dbt_utils.generate_surrogate_key(['unique_id']) }} as test_key,
    {{ dbt_utils.generate_surrogate_key(['unique_id']) }} as seed_key,
    {{ dbt_utils.generate_surrogate_key(['unique_id']) }} as snapshot_key,
    rows_affected,
    execution_time,
    execute_started_at,
    execute_completed_at,
    compile_started_at,
    compile_completed_at
from {{ ref('stg_run_result') }}
