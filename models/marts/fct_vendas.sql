with
    dim_b2c as (
        select *
        from {{ ref('dim_b2c') }}
    )
    , dim_clientes as (
        select *
        from {{ ref('dim_clientes') }}

       , dim_data as (
        select *
        from {{ ref('dim_data') }}

    
       , dim_local as (
        select *
        from {{ ref('dim_local') }}

        
       , dim_loja as (
        select *
        from {{ ref('dim_loja') }}

        , dim_motivo_compra as (
        select *
        from {{ ref('dim_motivo_compra') }}

       , dim_pagamentos as (
        select *
        from {{ ref('dim_pagamentos') }}
        
       , dim_produtos as (
        select *
        from {{ ref('dim_produtos') }}
        
      , pedido_itens as (
        select *
        from {{ ref('int_vendas__pedido_itens') }}
    )    