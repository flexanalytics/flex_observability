select
    {{ dbt_utils.generate_surrogate_key(['unique_id']) }} as snapshot_key,
    database_name,
    schema_name,
    snapshot_name,
    description,
    package_name,
    materialization,
    tags,
    generated_at
from {{ ref('stg_snapshot') }}
