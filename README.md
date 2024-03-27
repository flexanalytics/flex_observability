This project provides [observability](https://www.ibm.com/topics/data-observability) built on top of the robust [elementary](https://www.elementary-data.com/) observability environment.


### Using this package

1. Add the following to your project's `packages.yml`

```yaml
packages:
  ...
  - git: "https://github.com/flexanalytics/flex_observability.git"
    revision: v0.2.0
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
    tags: ['observability']
    schema: observability_base
...
```
3. run `dbt deps` to install the package

4. run `dbt build -s tag:observability` to create base models, core models, and reporting views

This will enable elementary base tables to get metadata on your dbt models, tests, seeds, snapshots, and runs. `flex_observability` then creates a set of staging tables and kimball-style dimension and fact tables as well as canned observability reports via views which can be built upon for your own observability reporting. Make sure to keep an eye on [new releases](https://github.com/flexanalytics/flex_observability/releases) as new (and potentially breaking) changes are introduced.
