{{ config(
    schema='observability_staging'
)}}

select
    unique_id,
    alias,
    checksum,
    materialization,
    tags,
    meta,
    owner,
    database_name,
    schema_name,
    depends_on_macros,
    depends_on_nodes,
    cast(description as varchar(65535)) as description,
    name as model_name,
    package_name,
    original_path,
    path,
    patch_path,
    cast(generated_at as datetime) as generated_at,
    metadata_hash
from {{ source('observability', 'dbt_models') }}
