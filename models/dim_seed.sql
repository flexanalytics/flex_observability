select
    {{ dbt_utils.generate_surrogate_key(['unique_id']) }} as seed_key,
    database_name,
    schema_name,
    seed_name,
    description,
    package_name,
    tags,
    generated_at
from {{ ref('stg_seed') }}
