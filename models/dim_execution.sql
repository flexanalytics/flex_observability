select
    {{ dbt_utils.generate_surrogate_key(['run_result.model_execution_id']) }} as execution_key,
    run_result.execution_name,
    run_result.status,
    run_result.resource_type,
    run_result.full_refresh,
    run_result.materialization,
    coalesce(mdl.schema_name, test.schema_name, seed.schema_name, snap.schema_name) as materialized_schema,
    coalesce(mdl.database_name, test.database_name, seed.database_name, snap.database_name) as materialized_database,
    coalesce(mdl.description, test.description, seed.description, snap.description) as description,
    coalesce(mdl.package_name, test.package_name, seed.package_name, snap.package_name) as package_name,
    coalesce(mdl.tags, seed.tags, snap.tags, test.tags) as tags,
    case
        when
            md5(run_result.generated_at || run_result.unique_id)
            = md5(
                max(run_result.generated_at)
                    over (
                        partition by run_result.unique_id
                        order by run_result.generated_at desc
                        {% if target.type == 'redshift' %}
                        rows between unbounded preceding and current row
                        {% endif %}
                    )
                || run_result.unique_id
            )
            then 1
        else 0
    end as most_recent_flag,
    cast(run_result.generated_at as datetime) as generated_at
    -- most recent invocation for the day partition by package_name and generated_at
from {{ ref('stg_run_result') }} as run_result
left outer join {{ ref('stg_model') }} as mdl on run_result.unique_id = mdl.unique_id
left outer join {{ ref('stg_test') }} as test on run_result.unique_id = test.unique_id
left outer join {{ ref('stg_seed') }} as seed on run_result.unique_id = seed.unique_id
left outer join {{ ref('stg_snapshot') }} as snap on run_result.unique_id = snap.unique_id
