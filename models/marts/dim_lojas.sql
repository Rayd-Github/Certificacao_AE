with
    stg_store as (
        select *
        from {{ ref('stg_sap__store') }}
    )

    , stg_salesorderheader  as (
        select *
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , stg_stateprovince as (
        select *
        from {{ ref('stg_sap__stateprovince') }}
    )

    , join_tabelas as (
        select 
       stg_store.id_representante
    ,  stg_store.nome_loja
    ,  stg_store.id_vendedor

    ,  stg_salesorderheader.id_pedido
    ,  stg_salesorderheader.data_pedido
    ,  stg_salesorderheader.id_status
    ,  stg_salesorderheader.id_cliente
    ,  stg_salesorderheader.id_vendedor
    ,  stg_salesorderheader.id_territorio
    ,  stg_salesorderheader.id_cartao
    ,  stg_salesorderheader.id_compra_aprovada
    ,  stg_salesorderheader.subtotal_compra
    ,  stg_salesorderheader.total_compra

    , stg_stateprovince.id_estado
    , stg_stateprovince.nome_uf
    , stg_stateprovince.nome_sigla_pais
    , stg_stateprovince.nome_estado
   -- , stg_stateprovince.id_territorio

    from stg_store
        left join stg_salesorderheader on
            stg_store.id_vendedor = stg_salesorderheader.id_vendedor
   
        left join stg_stateprovince on
            stg_salesorderheader.id_territorio =  stg_stateprovince.id_territorio
     )

    , criar_chave as (
        select
            row_number() over (order by id_representante) as pk_loja
            , *
        from join_tabelas
    )

    select *
    from criar_chave