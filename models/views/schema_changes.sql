select
    database_name,
    schema_name,
    table_name,
    column_name,
    detected_at,
    test_sub_type,
    test_results_description
from {{ source('observability', 'elementary_test_results') }}
where test_short_name = 'schema_changes' and failures = 1
