with
    stg_customer as (
        select *
        from {{ ref('stg_sap__customer') }}
    )

    
    , stg_stateprovince as (
        select *
        from {{ ref('stg_sap__stateprovince') }}
    )

    , join_tabelas as (
        select 

       stg_customer.id_cliente
    ,  stg_customer.id_pessoa
    ,  stg_customer.id_loja
    ,  stg_customer.id_territorio

    , stg_stateprovince.id_estado
    , stg_stateprovince.nome_uf
    , stg_stateprovince.nome_sigla_pais
    , stg_stateprovince.nome_estado
   -- , stg_stateprovince.id_territorio

    from stg_customer
        left join stg_stateprovince on
             stg_customer.id_territorio =stg_stateprovince.id_territorio
   
            )

    , criar_chave as (
        select
            row_number() over (order by id_cliente) as pk_cliente
            , *
        from join_tabelas
    )

    select *
    from criar_chave