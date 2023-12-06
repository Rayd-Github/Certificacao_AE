with
    stg_store as (
        select *
        from {{ ref('stg_sap__store') }}
    )
  select *
    from stg_store