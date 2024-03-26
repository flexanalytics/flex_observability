with
    tests as (
        select
            m.unique_id,
            m.model_name,
            m.materialization,
            m.database_name,
            m.schema_name,
            case when t.parent_model_unique_id is null then 0 else 1 end
            as is_tested
        from
            {{ ref('stg_model') }} as m
        left outer join {{ ref('stg_test') }} as t on
            m.unique_id = t.parent_model_unique_id
    )

select * from tests where is_tested = 0
