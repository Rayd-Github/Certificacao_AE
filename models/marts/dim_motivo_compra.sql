with 
    stg_salesreason as (
        select *
        from {{ ref('stg_sap__salesreason') }}
    )

    , stg_salesorderheadersalesreason as (
        select *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )

    , join_tabelas as (
        select 
          stg_salesreason.id_motivo
        , stg_salesreason.nome_motivo
        , stg_salesreason.nome_razao_motivo

        , stg_salesorderheadersalesreason.id_pedido
      --  ,stg_salesorderheadersalesreason. id_motivo

      
        from stg_salesorderheadersalesreason
        left join stg_salesreason on
            stg_salesorderheadersalesreason.id_motivo = stg_salesreason.id_motivo
    )
    , criar_chave as (
        select  
            row_number() over (order by id_pedido) as pk_motivo_compra
            , *
        from join_tabelas
    )
    select *
    from criar_chave