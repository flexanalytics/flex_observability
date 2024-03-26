select
    {{ dbt_utils.generate_surrogate_key(['unique_id']) }} as test_key,
    database_name,
    schema_name,
    test_name,
    test_category,
    test_column_name,
    configured_severity,
    quality_dimension,
    warn_if,
    error_if,
    test_namespace,
    package_name,
    tags,
    generated_at
from {{ ref('stg_test') }}
