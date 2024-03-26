select
    unique_id,
    alias,
    checksum,
    tags,
    meta,
    owner,
    database_name,
    schema_name,
    cast(description as varchar(65535)) as description,
    name as seed_name,
    package_name,
    original_path,
    path,
    cast(generated_at as datetime) as generated_at,
    metadata_hash
from {{ source('observability', 'dbt_seeds') }}
