with definition_history as (
    select
        model_execution_id,
        unique_id,
        invocation_id,
        generated_at,
        execution_name,
        rows_affected,
        materialization,
        compiled_code as current_definition,
        lag(compiled_code)
            over (partition by unique_id order by execute_completed_at desc)
            as previous_definition,
        md5(compiled_code) as definition_hash,
        md5(previous_definition) as previous_definition_hash
    from {{ ref('stg_run_result') }}
    where
        split_part(unique_id, '.', 1) = 'model'
)

select
    model_execution_id,
    unique_id,
    invocation_id,
    generated_at,
    execution_name,
    rows_affected,
    materialization,
    current_definition,
    previous_definition
from definition_history
where definition_hash != previous_definition_hash
