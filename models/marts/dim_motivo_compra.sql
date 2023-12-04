with 
    stg_motivo as (
        select *
        from {{ ref('stg_sap__salesreason') }}
    )

    , stg_motivo_pedido as (
        select *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )

    , join_tabelas as (
        select 
        stg_motivo.id_motivo
        , stg_motivo.nome_motivo
        , stg_motivo.nome_razao_motivo
        , stg_motivo_pedido.id_pedido
      --  , stg_motivo_pedido. id_motivo
        from stg_motivo_pedido
        left join stg_motivo on
            stg_motivo_pedido.id_motivo = stg_motivo.id_motivo
    )
    , criar_chave as (
        select  
            row_number() over (order by id_pedido) as pk_motivo_compra
            , *
        from join_tabelas
    )
    select *
    from criar_chave