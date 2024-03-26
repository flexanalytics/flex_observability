select
    {{ dbt_utils.generate_surrogate_key(['unique_id']) }} as model_key,
    database_name,
    schema_name,
    model_name,
    description,
    package_name,
    materialization,
    tags,
    generated_at
from {{ ref('stg_model') }}
