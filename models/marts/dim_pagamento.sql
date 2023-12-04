with
    stg_pagamento as (
        select *
        from {{ ref('stg_sap__creditcard') }}
    )
    , criar_chave as (
        select
            row_number() over(order by id_cartao) as pk_pagamento
            , id_cartao
            , nome_bandeira_cartao
        from stg_pagamento
    )
select *
from criar_chave