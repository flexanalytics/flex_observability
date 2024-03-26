### Using this package

1. Add the following to your project's `packages.yml`

```yaml
packages:
  ...
  - git: "https://github.com/flexanalytics/flex_observability.git"
    revision: 0.1.0
  ...
```

2. add the following to your `dbt_project.yml`

```yaml
models:
...
  observability:
    tags: ['observability']
    materialized: table
    schema: observability
    staging:
      materialized: table
      schema: observability_staging
    views:
      materialized: view
      schema: observability_views
  elementary:
    schema: observability_base
...
```
3. run `dbt deps` to install the package

4. run `dbt build -s tag:observability` to create base models, core models, and reporting views
